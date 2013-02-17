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
library code_parser;

import 'package:irhydra/src/modes/code.dart';
import 'package:irhydra/src/parsing.dart' as parsing;

/** Parse given disassembly dump. */
parse(List<String> text) => text != null ?
    (new CodeParser(text)..parse()).code : new Code.empty();

class CodeParser extends parsing.ParserBase {
  final _code = [];
  final blocks = {};

  /** Base address of the code object. */
  int start;

  /** Current basic block range. */
  Range block;

  CodeParser(lines) : super(lines);

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

    // Other comments between instrcutions.
    r"^\s+;;+(.*)$": (comment) {
      // Check if this comment ends the last block and start code epilogue
      // which contains instructions' slow paths and deopt stubs.
      if (block != null &&
          (comment.contains("SlowPath") ||
           comment.contains("Deopt stub"))) {
        block.end = _code.length;
        block = null;
      }
      _code.add(new Comment(comment));
    },
  };

  get code {
    if (block != null) {  // Finalize the last block.
      block.end = _code.length;
    }
    return new Code(start, _code, blocks);
  }
}
