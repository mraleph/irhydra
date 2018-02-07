// Copyright 2013 Google Inc. All Rights Reserved.
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

/** Parser for dumps of Dart VM intermediate language. */
library modes.dartvm.ir_parser;

import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:ui_utils/parsing.dart' as parsing;

import 'package:fixnum/fixnum.dart' as fixnum;

/** Parse given IR dumps. */
parse(text) {
  final blocks = (new IRParser(text())..parse()).builder.blocks;

  // Add explicit edge from the graph entry to the first block.
  final graphEntry = blocks.values.first;
  final firstBlock = blocks.values.toList()[1];
  graphEntry.edge(firstBlock);

  return blocks;
}

class IRParser extends parsing.ParserBase {
  final builder = new IR.CfgBuilder();

  IR.Block currentBlock;

  var parseOperands;

  IRParser(text) : super(text.split('\n')) {
    parseOperands = parsing.makeSplitter({
      r"B\d+\b": (val) => new IR.BlockRef(val),
      r"[tv]\d+\b": (val) => new IR.ValRef(val),
    });
  }

  /** Regular expression stripping lifetime position from the line. */
  final lineRe = new RegExp(r"^\s*\d+:\s+(.*)$");

  /** Returns current line trimmed and stripped through [lineRe]. */
  get currentLine {
    final line = super.currentLine;
    final m = lineRe.firstMatch(line);
    return m != null ? m.group(1) : line.trim();
  }

  get patterns => {
    // BlockEntryInstr
    r"^(B\d+)\[": (block_name) {
      currentBlock = builder.block(block_name);
      currentBlock.hir.add(new IR.Instruction(null, null, null));
    },

    // GotoInstr
    r"goto[^\s]*\s+B?(\d+)$": (successor) {
      final target = "B${successor}";
      currentBlock.hir.add(new IR.Instruction(null, "goto", [new IR.BlockRef(target)]));
      builder.edge(currentBlock.name, target);
    },

    // BranchInstr
    r"if (\w+)[^\(]*(\(.*\)).+goto[^\s]*\s+.(\d+), (\d+).$":
        (cond_op, cond_args, true_successor, false_successor) {
      true_successor = "B${true_successor}";
      false_successor = "B${false_successor}";

      builder.edge(currentBlock.name, true_successor);
      builder.edge(currentBlock.name, false_successor);
      currentBlock.hir.add(new IR.Branch(cond_op,
                                         parseOperands(cond_args),
                                         true_successor,
                                         false_successor));
    },

    // Definition (with an SSA name).
    r"^(v\d+) <- (\w+)[^\(]*(\(.*\)) *(\[-?\d+, -?\d+\])?": (id, op, args, [range]) {
      if (op == "phi") op = "Phi";  // Rename phis to match style.
      currentBlock.hir.add(new IR.Instruction(id, op, parseOperands(args)));
      if (range != null) {
        currentBlock.hir.last.args..add(" ")
                                  ..add(Range.fromString(range));
      }
    },

    // Definition (with two SSA names).
    r"^\(?(v\d+), (v\d+)\)? <- (\w+)[^\(]*(\(.*\)) *(\[-?\d+, -?\d+\])?": (id1, id2, op, args, [range]) {
      if (op == "phi") op = "Phi";  // Rename phis to match style.
      currentBlock.hir.add(new IR.Instruction(new IR.MultiId([id1, id2]), op, parseOperands(args)));
      if (range != null) {
        currentBlock.hir.last.args..add(" ")
                                  ..add(Range.fromString(range));
      }
    },

    // Instruction.
    r"^(\w+)(?::\d+)?(\(.*\))": (op, args) {
      currentBlock.hir.add(new IR.Instruction(null, op, parseOperands(args)));
    },

    // Special support for ParallelMove.
    r"^(ParallelMove) (.*)": (op, args) {
      args = args.replaceAll(new RegExp(r"(\S+) <- \1,?"), "")
                 .trim();
      if (args.isEmpty) {
        return;
      }

      currentBlock.hir.add(new IR.Instruction(null, op, parseOperands(args)));
    },
  };
}


class C {
  final value;
  final text;

  C(this.value, this.text);
}

c(v, t) => new C(fixnum.Int64.parseHex(v), t);

class Range extends IR.Operand {
  final low;
  final high;

  static final KNOWN_CONSTANTS = [
    c("ffffffffc0000000", "Int31Min"),
    c("000000003fffffff", "Int31Max"),
    c("ffffffff80000000", "Int32Min"),
    c("000000007fffffff", "Int32Max"),
    c("00000000ffffffff", "Uint32Max"),
    c("c000000000000000", "Int63Min"),
    c("3fffffffffffffff", "Int63Max"),
    c("8000000000000000", "Int64Min"),
    c("7fffffffffffffff", "Int64Max")
  ];

  static toReadableName(val) {
    for (var c in KNOWN_CONSTANTS)
      if (c.value == val)
        return c.text;
    return val.toString();
  }

  Range(low, high)
    : low = fixnum.Int64.parseInt(low),
      high = fixnum.Int64.parseInt(high);

  static final RANGE_RE = new RegExp(r"\[(-?\d+), (-?\d+)\]");

  static fromString(str) {
    return parsing.match(str, RANGE_RE, (lo, hi) => new Range(lo, hi));
  }

  final tag = "range";
  get text => "[${toReadableName(low)}, ${toReadableName(high)}]";


}
