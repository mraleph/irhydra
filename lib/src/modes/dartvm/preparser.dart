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

/** Splits full compilation log into IR and native code artifacts. */
library preparser;

import 'package:irhydra/src/modes/dartvm/name_parser.dart' as name_parser;
import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:irhydra/src/parsing.dart' as parsing;

/** Start of the IR dump section. */
const MARKER_IR = "After Optimizations:";

/** Start of the disassembly dump section. */
const MARKER_CODE = "Code for optimized function ";

canRecognize(text) =>
  text.contains(MARKER_IR) || text.contains(MARKER_CODE);

parse(text) =>
  (new PreParser(text)..parse()).functions;

class PreParser extends parsing.ParserBase {
  final functions = <IR.Method>[];

  PreParser(text) : super(text.split('\n'));

  get patterns => {
    // Start of the IR dump.
    r"^After Optimizations:": () {
      var functionName;
      enter({
        // Function name marker.
        r"^==== (.*)$": (name) => functionName = name,

        // Instruction prefixed by a lifetime position marker.
        r"^\s*\d+:\s+.*$": () {
          if (currentLine.endsWith("{")) {
            // Joins have phi section attached to them: it is wrapped in curly
            // braces, one phi on a line. Skip lines until phi section is
            // closed.
            enter({ r"^}$": () => leave() });
          }
        },

        // If no previous expression matches we reached the end of the dump.
        r"": () {
          functions.add(_createMethod(functionName, ir: subrange()));
          leave(backtrack: 1);  // Current line can be a start of the next dump.
        }
      });
    },

    // Start of the disassembly listing.
    r"^Code for optimized function '(.*)' {$": (functionName) {
      enter({
        r"^}$": () {  // Listing ends with a curly brace.
          final code = subrange();
          if (!functions.isEmpty && functions.last.name.full == functionName) {
            // IR for this function was already parsed. Merge disassembly
            // listing into it.
            functions.last.phases.last.code = code;
          } else {
            // No IR information was parsed for this function.
            functions.add(_createMethod(functionName, code: code));
          }
          leave();
        }
      });
    }
  };

  _createMethod(fullname, {ir, code}) {
    // Currently Dart VM dumps information only at the very end of compilation.
    // Thus create a single artificial phase hosting both IR and code.
    final name = name_parser.parse(fullname);
    return new IR.Method(name)..phases.add(
        new IR.Phase("After optimizations", ir: ir, code: code));
  }
}


