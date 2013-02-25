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
library ir_parser;

import 'dart:html';

import 'package:irhydra/src/html_utils.dart';
import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:irhydra/src/parsing.dart' as parsing;
import 'package:irhydra/src/xref.dart' as xref;

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

  IRParser(text) : super(text.split('\n'));

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
    },

    // GotoInstr
    r"goto[^\s]*\s+(\d+)$": (successor) {
      builder.edge(currentBlock.name, "B${successor}");
    },

    // BranchInstr
    r"if (\w+)[^\(]*(\(.*\)).+goto[^\s]*\s+.(\d+), (\d+).$":
        (cond_op, cond_args, true_successor, false_successor) {
      true_successor = "B${true_successor}";
      false_successor = "B${false_successor}";

      builder.edge(currentBlock.name, true_successor);
      builder.edge(currentBlock.name, false_successor);
      currentBlock.hir.add(new IR.Branch(currentLine,
                                         cond_op,
                                         cond_args,
                                         true_successor,
                                         false_successor));
    },

    // Definition (with an SSA name).
    r"^(v\d+) <- (\w+)[^\(]*(\(.*\))": (id, op, args) {
      if (op == "phi") op = "Phi";  // Rename phis to match style.
      currentBlock.hir.add(new IR.Instruction(currentLine, id, op, args));
    },

    // Instruction.
    r"^(\w+):\d+(\(.*\))": (op, args) {
      currentBlock.hir.add(new IR.Instruction(currentLine, null, op, args));
    },
  };
}