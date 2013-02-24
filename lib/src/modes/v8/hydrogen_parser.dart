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

/** Parser for hydrogen.cfg files. */
library hydrogen_parser;

import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:irhydra/src/parsing.dart' as parsing;

bool canRecognize(String str) =>
  str.contains("begin_cfg") && str.contains("begin_compilation");

/**
 * Preparse the hydrogen.cfg file content extracting all compiled method
 * and phases.
 */
List<IR.Method> preparse(String str) {
  // Matches tags that start/end compilation and cfg records.
  final tagRe = new RegExp(r"(begin|end)_(compilation|cfg)\n");

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
      final name = nameRe.firstMatch(substr).group(1);

      // Create the method and make it current.
      method = new IR.Method(new IR.Name.fromFull(name));
      methods.add(method);
    } else if (tag == "end_cfg\n") {
      // This is the cfg record containing blocks. No need to create substring
      // right away: its content will be needed only when this phase is
      // displayed.
      final substr = _deferSubstring(str, start, match.start);

      // Extract phase's name from the first line of the cfg record.
      final firstLine = str.substring(start, str.indexOf("\n", start));
      final name = nameRe.firstMatch(firstLine).group(1);

      method.phases.add(new IR.Phase(name, ir: substr));
    }
  }

  return methods;
}

/** Create a substring thunk. */
_deferSubstring(str, start, end) =>
  () => str.substring(start, end);

/** Parse given phase IR stored in the deferred substring thunk. */
Map parse(Function ir) =>
  (new CfgParser(ir())..parse()).builder.blocks;

class CfgParser extends parsing.ParserBase {
  final builder = new IR.CfgBuilder();
  var block;

  CfgParser(str) : super(str.split('\n'));

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

      r"begin_locals": {  // Block phis.
        r"end_locals": () => leave(),

        r"^\s+\d+\s+(\w\d+)\s+(.*)$": (name, args) {
          block.hir.add(" 0 0 $name Phi $args <|@");
        }
      },

      "begin_HIR": {  // Hydrogen IR.
        "end_HIR": () {
          block.hir.addAll(subrange());
          leave();
        }
      },

      "begin_LIR": {  // Lithium IR.
        "end_LIR": () {
          block.lir.addAll(subrange());
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
