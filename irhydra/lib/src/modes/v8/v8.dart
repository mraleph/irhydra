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
library modes.v8;

import 'dart:html' as html;

import 'package:irhydra/src/modes/ir.dart' as ir;
import 'package:irhydra/src/modes/code.dart' show CodeCollector;
import 'package:irhydra/src/modes/mode.dart';
import 'package:irhydra/src/modes/v8/code_parser.dart' as code_parser;
import 'package:irhydra/src/modes/v8/hydrogen_parser.dart' as hydrogen_parser;

class _V8HIRDescriptor extends HIRDescriptor {
  const _V8HIRDescriptor() : super();

  codeOf(instr, {skipComment: false}) =>
    instr.code.expand((instr) => instr.code == null ? const []
                                                     : instr.code)
              .skip(skipComment ? 1 : 0);
}

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
  final irs = const [const _V8HIRDescriptor()];

  final statusObject;

  Mode(this.statusObject);

  /** [true] if code dump file is already loaded. */
  var codeLoaded = false;

  /** [true] if hydrogen.cfg file is already loaded. */
  var hydrogenLoaded = false;

  var _descriptions;
  get descriptions {
    if (_descriptions == null) {
      _descriptions = new html.Element.tag('ir-descriptions-v8');
    }
    return _descriptions;
  }

  /**
   * Extract methods from the given artifact (either hydrogen.cfg or
   * an stdout dump)
   */
  load(text) {
    if (hydrogen_parser.canRecognize(text) && !hydrogenLoaded) {
      // This is hydrogen.cfg containing IR.
      _merge(hydrogen_parser.preparse(text), methods);
      hydrogenLoaded = true;
      return true;
    } else if (code_parser.canRecognize(text) && !codeLoaded) {
      // This is an stdout dump containing native code and deopts.
      timeline = [];
      _merge(methods, code_parser.preparse(text, timeline, statusObject));
      codeLoaded = true;
      return true;
    } else {
      return false;
    }
  }

  final _lirIdMarker = new RegExp(r"<@(\d+),#\d+>");
  _attachCode(blocks, code) {
    for (var block in blocks.values) {
      final codeCollector = new CodeCollector(code.codeOf(block.name));

      var previous;
      for (var instr in block.lir) {
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
        if (codeCollector.isAtMarker("@${instr.id}")) {
          codeCollector.collectCurrent();  // Collect marker itself.
          codeCollector.collectWhile((comment) => !_lirIdMarker.hasMatch(comment));
          instr.code = codeCollector.collected;
        }
        previous = instr;
      }

      codeCollector.collectRest();
      if (!codeCollector.isEmpty && previous != null) {
        if (previous.code == null) previous.code = [];
        previous.code.addAll(codeCollector.collected);
      }
    }
  }

  _mapTurboFanDeopts(ir.Method method) {
    for (var deopt in method.deopts) {
      if (deopt.srcPos != null) {
        continue;
      }

      final m = new RegExp(r";;; deoptimize at (-?\d+)(?:_(\d+))?").firstMatch(deopt.raw.join('\n'));
      if (m == null) continue;
      var inliningId = m.group(1);
      var srcPos = m.group(2);
      if (srcPos == null) {
        srcPos = inliningId;
        inliningId = "-1";
      }
      inliningId = int.parse(inliningId) + 1;
      srcPos = int.parse(srcPos) - method.inlined[inliningId].source.startPos;
      deopt.srcPos = new ir.SourcePosition(inliningId, srcPos);
    }

  }

  toIr(method, phase, statusObject) {
    final blocks = phase.ir != null ? hydrogen_parser.parse(method, phase.ir, statusObject) : {};
    final code = code_parser.parse(phase.code);
    _attachCode(blocks, code);
    _mapTurboFanDeopts(method);
    return new ir.ParsedIr(method, this, blocks, code, method.deopts);
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

    // Both are present, thus have to merge.
    mergeMethod(ir.Method methodIr, ir.Method methodCode) {
      // Move code, sources and deopt information to the method with IR as it
      // can contain information about multiple phases and method with code
      // always contains only one.
      assert(methodIr.sources.isEmpty);
      assert(methodIr.inlined.isEmpty);
      assert(methodIr.deopts.isEmpty);
      if (!methodCode.phases.isEmpty) {
        methodIr.phases.last.code = methodCode.phases.last.code;
      }
      methodIr.sources.addAll(methodCode.sources);
      methodIr.inlined.addAll(methodCode.inlined);

      methodIr.deopts.addAll(methodCode.deopts);
      methodIr.worstDeopt = methodCode.worstDeopt;
      if (methodCode.tags != null) {
        methodIr.tags ??= new Set<String>();
        methodIr.tags.addAll(methodCode.tags);
      }
    }

    // First try to merge based on optimization IDs.
    final opt2ir = new Map.fromIterable(
      ir.where((method) => method.optimizationId != null),
      key: (method) => method.optimizationId
    );

    if (opt2ir.length > 0) {
      // TODO(mraleph) be more resilent and report meaningful error if
      // we can't match.
      for (var currentCode in code) {
        if (opt2ir[currentCode.optimizationId] == null) {
          print('Unable to find IR for ${currentCode}');
          if (currentCode.isTagged('turbofan')) {
            print('... ${currentCode} was compiled with TurboFan. IRHydra does not support TurboFan code and IR artifacts - only Crankshaft code. There are no plans to support TurboFan. Contact V8 team for assistance.');
            statusObject.hasTurboFanCode = true;
          }
          continue;
        }
        mergeMethod(opt2ir[currentCode.optimizationId], currentCode);
      }
      methods = ir;
      return;
    }

    // Try to merge based on names.
    // Iterate both lists simultaneously assuming that for every
    // optimized code dump there must be a hydrogen graph.
    var i = 0;
    for (var j = 0; j < code.length; j++) {
      var currentIr = i;
      while (currentIr < ir.length && code[j].name.full != ir[currentIr].name.full) currentIr++;

      // We are going to ignore code objects without IR artifacts.
      if (currentIr < ir.length) {
        mergeMethod(ir[currentIr], code[j]);

        // There can be no other code objects attributed to this IR.
        // Advance past it.
        i = currentIr + 1;
      } else {
        // Report ignored code object to console for debugging purposes.
        print("Ignoring code artifact for '${code[j].name.full}' (id = ${code[j].optimizationId}). It doesn't have IR graph.");
      }
    }

    methods = ir;
  }

  lastOffset(code) => code_parser.lastOffset(code);
}