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

/** Mode for parsing V8's hydrogen.cfg and code dumps. */
library v8;

import 'package:irhydra/src/modes/ir.dart' as ir;
import 'package:irhydra/src/modes/code.dart' show CodeCollector;
import 'package:irhydra/src/modes/mode.dart';
import 'package:irhydra/src/modes/v8/code_parser.dart' as code_parser;
import 'package:irhydra/src/modes/v8/hydrogen_parser.dart' as hydrogen_parser;
import 'package:irhydra/src/modes/v8/view.dart' as view;
import 'package:irhydra/src/ui/graph.dart' as graphview;
import 'package:irhydra/src/xref.dart' as xref;

/**
 * Mode for viewing of V8's compilation artifacts.
 *
 * Data arrives from two separate sources:
 *
 *   * IR from hydrogen.cfg file generated when flag --trace-hydrogen is set;
 *   * disassembly and deopt events are dumped to stdout when flags
 *     `--trace-deopt --code-comments --print-opt-code` are set.
 */
class Mode extends BaseMode {
  /** [true] if code dump file is already loaded. */
  var codeLoaded = false;

  /** [true] if hydrogen.cfg file is already loaded. */
  var hydrogenLoaded = false;

  /** Currently loaded methods. */
  var methods;

  /** Currently displayed method. */
  var currentMethod;

  canRecognize(text) =>
    hydrogen_parser.canRecognize(text) || code_parser.canRecognize(text);

  /**
   * Extract methods from the given artifact (either hydrogen.cfg or
   * an stdout dump)
   */
  parse(text) {
    if (hydrogen_parser.canRecognize(text)) {
      // This is hydrogen.cfg containing IR.
      if (hydrogenLoaded) reset();  // Drop currently loaded IR data.
      _merge(hydrogen_parser.preparse(text), methods);
      hydrogenLoaded = true;
    } else if (code_parser.canRecognize(text)) {
      // This is an stdout dump containing native code and deopts.
      if (codeLoaded) reset();  // Drop current native code data.
      _merge(methods, code_parser.preparse(text));
      codeLoaded = true;
    }

    return methods;
  }

  toIr(method, phase) {
    final blocks = hydrogen_parser.parse(phase.ir);
    final code = code_parser.parse(phase.code);

    final lirIdMarker = new RegExp(r"<@(\d+),#\d+>");

    attachCode(block, lir) {
      final codeCollector = new CodeCollector(code.codeOf(block.name));

      var previous;
      for (var instr in lir) {
        codeCollector.collectUntil("@${instr.id}");

        if (!codeCollector.isEmpty) {
          if (previous.code == null) previous.code = [];
          previous.code.addAll(codeCollector.collected);
        }

        // If we found marker that signifies start of the instructions emitted for
        // this lithium instruction then emit this instructions until something
        // that looks like a marker for the next instruction is reached.
        // This tries to workaround cases when some instructions from lithium
        // level (e.g. goto) produce no code and their markers are not present in the
        // resulting code comments.
        if (codeCollector.isAfterMarker("@${instr.id}")) {
          codeCollector.collectWhile((comment) => !lirIdMarker.hasMatch(comment));
          instr.code = codeCollector.collected;
        }
        previous = instr;
      }
    }
    
    if (!method.deopts.isEmpty) {
      hydrogen_parser.DeoptMatcher.resolve(method.deopts, blocks);
    }

    return new ir.ParsedIr(blocks, code, attachCode, method.deopts);
  }

  reset() {
    methods = null;
    codeLoaded = hydrogenLoaded = false;
  }

  /** Merge method lists obtained from IR and code sources. */
  _merge(ir, code) {
    if (ir == null) {
      methods = code;
      return;
    } else if (code == null) {
      methods = ir;
      return;
    }

    // Both are present, thus have to merge. Iterate both lists simultaneously
    // assuming that for every optimized code dump there must be a hydrogen
    // graph.
    var i = 0;
    for (var j = 0; j < code.length; j++) {
      var currentIr = i;
      while (currentIr < ir.length && code[j].name.full != ir[currentIr].name.full) currentIr++;

      // We are going to ignore code objects without IR artifacts.
      if (currentIr < ir.length) {
        // Move code and deopt information to the method with IR as it
        // can contain information about multiple phases and method with code
        // always contains only one.
        ir[currentIr].phases.last.code = code[j].phases.last.code;
        ir[currentIr].deopts.addAll(code[j].deopts);

        // There can be no other code objects attributed to this IR.
        // Advance past it.
        i = currentIr + 1;
      } else {
        // Report ignored code object to console for debugging purposes.
        print("Ignoring code artifact for '${code[j].name.full}'. It doesn't have IR graph.");
      }
    }

    methods = ir;
  }
}