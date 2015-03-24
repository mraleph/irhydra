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

/** Parsing native code artifacts dumped by Dart VM disassembler. */
library modes.dartvm.code_parser;

import 'package:irhydra/src/modes/code.dart';
import 'package:ui_utils/parsing.dart' as parsing;
import 'package:fixnum/fixnum.dart' as fixnum;

/** Parse given disassembly dump. */
Code parse(text) => text != null ?
    (new CodeParser(text())..parse()).code : new Code.empty();

class CodeParser extends parsing.ParserBase {
  final _code = [];
  final blocks = {};

  /** Base address of the code object. */
  int start;

  /** Current basic block range. */
  Range block;

  CodeParser(text) : super(text.split('\n'));

  get patterns => {
    // Jump instruction.
    r"^0x([a-f0-9]+)\s+[a-f0-9]+\s+(j\w+) 0x([a-f0-9]+)$": (address,
                                                            jmp,
                                                            target) {
      final from = int.parse(address, radix: 16) - start;
      final to = int.parse(target, radix: 16) - start;
      _code.add(new Jump(from, jmp, to));
    },

    // Other instructions.
    r"^0x([a-f0-9]+)\s+[a-f0-9]+\s+([^;]+)$": (address, instr) {
      address = int.parse(address, radix: 16);
      if (start == null) start = address;
      _code.add(new Instruction(address - start, instr));
    },

    // Comment marking block's start.
    r"^\s+;; (B\d+)$": (name) {
      if (block != null) block.end = _code.length;
      blocks[name] = block = new Range(_code.length);
    },

    // Other comments between instructions.
    r"^\s+;;+\s*(.*)$": (comment) {
      // Check if this comment ends the last block and start code epilogue
      // which contains instructions' slow paths and deopt stubs.
      if (block != null &&
          (comment.contains("SlowPath") ||
           comment.contains("Deopt stub"))) {
        block.end = _code.length;
        block = null;
      }

      comment = cleanRedundantParallelMove(comment);
      if (comment != null) {
        _code.add(new Comment(comment));
      }
    },
  };

  final PARALLEL_MOVE = new RegExp(r"^ParallelMove\s+(.*)$");
  final SINGLE_MOVE = new RegExp(r"([-\w+]+) <\- ([-\w+]+),?");

  cleanRedundantParallelMove(comment) {
    final m = PARALLEL_MOVE.firstMatch(comment);
    if (m == null) {
      return comment;
    }

    final args = m.group(1).replaceAllMapped(SINGLE_MOVE,
        (m) => (m.group(1) == m.group(2)) ? "" : m.group(0));

    if (!SINGLE_MOVE.hasMatch(args)) {
      return null;
    }

    return "ParallelMove ${args}";
  }

  get code {
    if (block != null) {  // Finalize the last block.
      block.end = _code.length;
    }
    return new Code(start, _code, blocks);
  }
}

lastOffset(String code) {
  try {
    var firstLineStart = code.indexOf("{"), firstLineSpace;
    do {
      firstLineStart = code.indexOf("\n", firstLineStart) + 1;
      firstLineSpace = code.indexOf(" ", firstLineStart);
    } while (firstLineStart == firstLineSpace);

    final lastLineStart = code.lastIndexOf("\n", code.indexOf("\n}") - 1) + 1;
    final lastLineSpace = code.indexOf(" ", lastLineStart);

    final firstAddr = fixnum.Int64.parseHex(code.substring(firstLineStart + 2, firstLineSpace));
    final lastAddr = fixnum.Int64.parseHex(code.substring(lastLineStart + 2, lastLineSpace));

    final lastOffset = lastAddr - firstAddr;

    return lastOffset.toInt();
  } catch (e, stack) {
    return 0;
  }
}
