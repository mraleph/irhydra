// Copyright 2015 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library parser;

import 'package:petitparser/petitparser.dart' as p;
import 'package:saga/src/flow/node.dart' show BB;

final codeRe = new RegExp(r"^\s+(0x[0-9a-f]+):\s+(?:data32 |rep )?(\w+)([^;#]*)([;#].*)?$");
final commentRe = new RegExp(r"^\s+([;#].*)$");

class Imm {
  final value;
  Imm(value) : value = value.startsWith(r"$") ? value.substring(1) : value;

  toString() => "$value";

  operator == (other) => other is Imm && other.value == this.value;
}

class Addr {
  final base;
  final index;
  final scale;
  final offset;

  Addr(this.base, this.index, this.scale, this.offset);

  Addr.absolute(addr) : this(null, null, null, addr);

  get isAbsolute => base == null && index == null && scale == null && offset != null;

  toString() {
    var components = [];
    if (base != null) components.add(base);
    if (index != null) {
      assert(scale != null);
      components.add("${index}*${scale}");
    }
    if (offset != null) components.add(offset);
    return "[${components.join(' + ')}]";
  }
}

class RegRef {
  final String name;

  RegRef(this.name);

  toString() => name;
}

class Reg {
  static from(name) => new RegRef(name.substring(1));
}

class Instruction {
  final addr;
  final opcode;
  final operands;
  final comment;

  Instruction(this.addr, this.opcode, this.operands, this.comment);

  toString() => "${opcode} ${operands.reversed.join(', ')} ${comment == null ? '' : comment}";
}

class Ir {
  final Map<String, BB> blocks;
  final Map<int, BB> blockMap;

  Ir(this.blocks, this.blockMap);
}

class CallTargetAttribute {
  final name;

  const CallTargetAttribute(this.name);

  toString() => this.name;

  static const NORETURN = const CallTargetAttribute("noreturn");

  static const values = const [NORETURN];

  static parse(name) {
    return values.firstWhere((val) => val.name == name);
  }
}

class CallTarget {
  final target;
  final attributes = new Set<CallTargetAttribute>();

  CallTarget(this.target);

  toString() => "CallTarget($target)";
}

class ParsedCode {
  final List code;
  final callTargets = <String, CallTarget>{};
  final callSites = new Set<int>();
  final fallthroughs = new Set<int>();
  final blockEntries = new Set<int>();

  ParsedCode(text) : code = instructionSeq.parse(text).value {
    final addrMap = new Map<String, int>.fromIterables(code.map((op) => op.addr), new Iterable.generate(code.length));

    toCallTarget(addr) =>
        callTargets.putIfAbsent(addr, () => new CallTarget(addr));

    var blockStarted = false;
    for (var i = 0; i < code.length; i++) {
      if (!blockStarted) {
        blockEntries.add(i);
        blockStarted = true;
      }

      final op = code[i];
      final opcode = op.opcode;
      if (opcode.startsWith("j")) {
        assert(op.operands.length == 1);
        final addr = op.operands[0];
        assert(addr is Addr && addr.isAbsolute);

        if (addrMap.containsKey(addr.offset)) {
          blockEntries.add(op.operands[0] = addrMap[addr.offset]);
        } else {
          op.operands[0] = toCallTarget(addr.offset);
        }

        if (opcode != "jmp") {
          fallthroughs.add(i);
        }

        blockStarted = false;
      } else if (opcode.startsWith("ret")) {
        blockStarted = false;
      } else if (opcode == "callq") {
        final addr = op.operands[0];
        assert(addr is Addr && addr.isAbsolute);
        op.operands[0] = toCallTarget(addr.offset);
        callSites.add(i + 1);
      }
    }
  }

  buildCfg() {
    var entries = []
      ..addAll(blockEntries)
      ..addAll(callSites.where((idx) {
        final callTarget = code[idx - 1].operands[0];
        return !blockEntries.contains(idx) && callTarget.attributes.contains(CallTargetAttribute.NORETURN);
      }))
      ..sort()
      ..add(code.length);

    final blocks = new Map<int, BB>();
    for (var i = 0; i < entries.length - 1; i++) {
      blocks[entries[i]] = new BB(i, code.getRange(entries[i], entries[i + 1]));
    }

    addSuccessor(block, succ) {
      if (succ is int) {
        assert(blocks.containsKey(succ));
        block.edge(blocks[succ]);
      } else {
        assert(succ is CallTarget);
      }
    }

    var next = 0;
    for (var block in blocks.values) {
      next++;

      final last = block.asm.last;
      final opcode = last.opcode;
      if (opcode == "jmp") {
        addSuccessor(block, last.operands[0]);
      } else if (opcode.startsWith("j")) {
        addSuccessor(block, entries[next]);
        addSuccessor(block, last.operands[0]);
      } else if (opcode == "retq" || (opcode == "callq" && last.operands[0].attributes.contains(CallTargetAttribute.NORETURN))) {
        // No successors.
      } else if (next < entries.length - 1) {
        addSuccessor(block, entries[next]);
      }
    }

    return new Ir(new Map.fromIterable(blocks.values, key: (block) => block.name, value: (block) => block), blocks);
  }

}

parse(String text) => new ParsedCode(text);

final instructionSeq = instruction.trim().plus().end();

final instruction = ((hexValue & p.char(':')).pick(0) & (trim(prefixes) & trim(p.word().plus().flatten())).pick(1) & operandSeq.optional() & commentSeq).map((matches) {
  final addr = matches[0];
  final opcode = matches[1];
  final operands = matches[2] == null ? const [] : matches[2];
  final comments = matches[3];
  return new Instruction(addr, opcode, operands, comments);
});

final ws = p.anyOf("\t ");
final trim = (p) => p.trim(ws, ws);

final commentSeq = (p.anyOf(";#") & p.noneOf('\n').star() & p.char('\n')).flatten().trim().star().map((matches) => matches.join(''));

final prefixes = p.string("data32").optional();

final regName = (p.char("%") & p.lowercase().or(p.digit()).plus()).flatten().map(Reg.from);
final addrMode = p.char("(") &
    regName.optional() &
    (p.char(",") & regName).pick(1).optional() &
    (p.char(",") & p.digit().plus().flatten()).pick(1).optional() &
    p.char(")");

final hexValue = (p.char("-").optional() & p.string("0x") & p.anyOf("0123456789abcdef").plus()).flatten();
final immValue = (p.char(r"$") & hexValue).flatten();

parseAddrMode(am, [offset = null]) {
  var base = am[1];
  var index = am[2];
  final scale = am[3];

  if (scale != null && index == null) {
    index = base;
    base = null;
  }

  return new Addr(base, index, scale, offset);
}

final anOperand = regName
                | immValue.map((value) => new Imm(value))
                | (hexValue & addrMode.optional()).map((addr) {
                    final offset = addr[0];
                    final am = addr[1];
                    if (am == null) {
                      return new Addr.absolute(offset);
                    }

                    return parseAddrMode(am, offset);
                  })
                | addrMode.map(parseAddrMode);

final operandSeq = (anOperand & (p.char(",") & anOperand).pick(1).star()).map((ops) {
  return [ops[0]]..addAll(ops[1]);
});