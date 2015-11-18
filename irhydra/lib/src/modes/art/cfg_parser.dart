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

/** Parser for ART's .cfg files. */
library modes.art.cfg_parser;

import 'package:irhydra/src/modes/code.dart' as code;
import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:ui_utils/parsing.dart' as parsing;

final artInstructionsRe = new RegExp(r"ParameterValue|SuspendCheck|NullCheck");
final cfgRe = new RegExp(r"begin_cfg|begin_compilation");

bool canRecognize(String str) =>
  cfgRe.hasMatch(str) && artInstructionsRe.hasMatch(str);

/**
 * Preparse the hydrogen.cfg file content extracting all compiled method
 * and phases.
 */
List<IR.Method> preparse(String str) {
  // Restore trailing newline if it was stripped somehow e.g. by copy-paste.
  if (str[str.length - 1] != '\n') str += '\n';

  // Matches tags that start/end compilation and cfg records.
  final tagRe = new RegExp(r"(begin|end)_(compilation|cfg)\n");

  // Matches line containing method name and optimization id.
  final compilationRe = new RegExp(r'name "([^"]*)"\n\s+method "[^"]*(:\d+)?"');

  // Matches line containing the name field.
  final nameRe = new RegExp(r'name "([^"]*)"');

  // Current method and the list of all methods.
  var method, methods = [];

  // Start position of the current record.
  var start;

  // Find all tags in the string.
  for (var match in tagRe.allMatches(str)) {
    final tag = match.group(0);

    if (tag.startsWith("begin_")) {
      start = match.end;  // Just remember the start and wait for the end tag.
    } else if (tag == "end_compilation\n") {
      // This is the compilation record for the method.
      // Extract the name from the record.
      final substr = str.substring(start, match.start);
      parsing.match(substr, compilationRe, (name, [optId]) {
        // Create the method and make it current.
        if (optId != null) optId = optId.substring(1);
        method = new IR.Method(new IR.Name.fromFull(name), optimizationId: optId);
        methods.add(method);
      });
    } else if (tag == "end_cfg\n") {
      // This is the cfg record containing blocks. No need to create substring
      // right away: its content will be needed only when this phase is
      // displayed.
      final substr = _deferSubstring(str, start, match.start);

      // Extract phase's name from the first line of the cfg record.
      final firstLine = str.substring(start, str.indexOf("\n", start));
      final name = nameRe.firstMatch(firstLine).group(1);

      method.phases.add(new IR.Phase(method, name, ir: substr));
    }
  }

  return methods;
}

/** Create a substring thunk. */
_deferSubstring(str, start, end) =>
  () => str.substring(start, end);

/** Parse given phase IR stored in the deferred substring thunk. */
Map parse(IR.Method method, Function ir, statusObject) {
  final stopwatch = new Stopwatch()..start();
  final parser = new CfgParser(ir())..parse();

  print("art.cfg_parser.parse took ${stopwatch.elapsedMilliseconds}");
  return parser.builder.blocks;
}

class CfgParser extends parsing.ParserBase {
  final builder = new IR.CfgBuilder();
  IR.Block block;

  var hirOperands;

  CfgParser(str) : super(str.split('\n')) {
    hirOperands = parsing.makeSplitter({
      r"0x[a-f0-9]+": (hirId, val) => new Constant(val),
      r"B\d+\b": (hirId, val) => new IR.BlockRef(val),
      r"[a-zA-Z]+\d+\b": (hirId, val) => new IR.ValRef(val),
    });
  }

  /** Parses ART's HIR instructions into SSA name, opcode and operands. */
  parseHir(line, re) {
    final m = re.firstMatch(line);
    if (m == null) return null;

    final id = m.group(1);
    final opcode = m.group(2);
    final operands = m.group(3);

    return new IR.Instruction(id, opcode, hirOperands(operands, context: id));
  }

  get patterns => {
    r"begin_block": {
      r'name "([^"]*)"': (name) {
        block = builder.block(name);
      },

      r"successors(.*)$": (successors) {
        final successorsRe = new RegExp(r'"(B\d+)"');
        for (var m in successorsRe.allMatches(successors)) {
          builder.edge(block.name, m.group(1));
        }
      },

      "begin_HIR": {
        "end_HIR": () {
          final it = subrange().iterator;
          while(it.moveNext()) {
            final line = it.current;
            var instr = null;
            if (line.endsWith("<|@")) {
              instr = parseHir(line, hirSingleLineRe);
            } else {
              // Instruction with attached code.
              instr = parseHir(line, hirMultiLineRe);

              final disasm = instr.code = [];
              while (it.moveNext()) {
                final line = it.current;
                if (line.endsWith("<|@")) {
                  break;
                }

                final m = disasmRe.firstMatch(line);

                disasm.add(new code.Instruction(int.parse(m.group(1), radix: 16), m.group(2)));
              }
            }

            if (instr == null) {
              continue;
            }

            block.hir.add(instr);
          }

          leave();
        }
      },

      "end_block": () {
        block = null;
        leave();
      }
    },
  };
}

/** Single HIR instruction from the hydrogen.cfg. */
final hirMultiLineRe = new RegExp(r"^\s+\d+\s+\d+\s+(\w+\d+)\s+([-\w]+)\s*(.*)$");
final hirSingleLineRe = new RegExp(r"^\s+\d+\s+\d+\s+(\w+\d+)\s+([-\w]+)\s*(.*)<\|@$");

final disasmRe = new RegExp(r"^(?:0x)?([a-fA-F0-9]+):\s+[a-f0-9]+\s+(.*)$");

class Constant extends IR.Operand {
  final text;
  Constant(this.text);

  get tag => "constant";
}
