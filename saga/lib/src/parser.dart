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

import 'dart:async';

import 'package:petitparser/petitparser.dart' as p;
import 'package:ui_utils/parsing.dart' as parsing;

import 'package:saga/src/flow/cpu_register.dart' show CpuRegister;
import 'package:saga/src/flow/node.dart' show BB;
import 'package:saga/src/flow/types.dart' show TypeSystem;

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

  Addr.withOffset(Addr base, offset)
      : this(base != null ? base.base : null,
             base != null ? base.index : null,
             base != null ? base.scale : null,
             offset);

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
  final ParsedCode owner;

  final target;
  final attributes = new Set<CallTargetAttribute>();

  CallTarget(this.owner, this.target);

  toggleAttribute(attr) {
    if (attributes.contains(attr)) {
      attributes.remove(attr);
    } else {
      attributes.add(attr);
    }
    owner._changesController.add(null);
  }

  toString() => "CallTarget($target)";
}

class ArgumentInfo {
  final name;
  final type;

  ArgumentInfo(this.name, this.type);
}

class FieldInfo {
  final offset;
  final name;
  final type;

  FieldInfo(this.offset, this.name, this.type);
}

class TypeInfo {
  final String name;
  final List<FieldInfo> fields;

  TypeInfo(this.name, this.fields);
}

class PrefixParser extends parsing.ParserBase {
  final args = <int, ArgumentInfo>{};
  final types = <String, TypeInfo>{};

  PrefixParser(str) : super(str.split('\n')) {
    this.parse();
  }

  get patterns => {
    r"^# ([\w$.]+) object internals:": (className) {
      final fields = [];
      enter({
        r"^#\s+(\d+)\s+\d+\s+([\w\[\]]+)\s+([\w.]+)": (offset, type, name) {
          final lastDot = name.lastIndexOf('.');
          if (lastDot >= 0) name = name.substring(lastDot + 1);
          fields.add(new FieldInfo(int.parse(offset), name, type));
        },

        r"Instance size": leave
      });

      types[className] = new TypeInfo(className, fields);
    },

    r"# (this|parm\d+):\s+(\w+)(?::(\w+))?\s+=\s+('[^']+'|\w+)": (arg, reg0, reg1, type) {
      assert(reg1 == null || reg1 == reg0);
      if (type[0] == "'") type = type.substring(1, type.length - 1);
      args[CpuRegister.parse(reg0)] = new ArgumentInfo(arg, type.replaceAll('/', '.'));
    }
  };
}

class ParsedCode {
  final prefix;
  final List code;
  final callTargets = <String, CallTarget>{};
  final callSites = new Set<int>();
  final blockEntries = new Set<int>();

  final Map<int, ArgumentInfo> args;
  final TypeSystem typeSystem;

  factory ParsedCode(text) {
    final parsed = instructionSeq.parse(text).value;

    final pp = new PrefixParser(parsed[0]);

    return new ParsedCode._(parsed[1], pp.args, pp.types);
  }

  ParsedCode._(this.code, this.args, typesInfo) : typeSystem = new TypeSystem(typesInfo) {
    final addrMap = new Map<String, int>.fromIterables(code.map((op) => op.addr), new Iterable.generate(code.length));

    toCallTarget(addr) =>
        callTargets.putIfAbsent(addr, () => new CallTarget(this, addr));

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

  final _changesController = new StreamController.broadcast();
  get changes => _changesController.stream;
}

parse(String text) => new ParsedCode(text);

final instructionSeq = (commentSeq.optional() & instruction.trim().plus()).end();

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

final aComma = p.char(",");

final aScale = p.anyOf("1248");

final addrMode = (p.char("(") &
    regName.optional() & (aComma & regName & (aComma & aScale).pick(1).optional()).optional() &
    p.char(")")).map((am) {
    final base = am[1];
    final index = am[2] != null ? am[2][1] : null;
    final scale = am[2] != null ? am[2][2] : null;
    return new Addr(base, index, scale, null);
  });

final hexValue = (p.char("-").optional() & p.string("0x") & p.anyOf("0123456789abcdef").plus()).flatten();
final immValue = (p.char(r"$") & hexValue).flatten();

final anOperand = regName
                | immValue.map((value) => new Imm(value))
                | (hexValue & addrMode.optional()).map((addr) {
                    final offset = addr[0];
                    final base = addr[1];

                    return new Addr.withOffset(base, offset);
                  })
                | addrMode;

final operandSeq = (anOperand & (p.char(",") & anOperand).pick(1).star()).map((ops) {
  return [ops[0]]..addAll(ops[1]);
});