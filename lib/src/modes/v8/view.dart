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

/** Display V8 IR and code on the [IRPane]. */
library view;

import 'dart:html' hide Comment;

import 'package:irhydra/src/html_utils.dart';
import 'package:irhydra/src/formatting.dart' as formatting;
import 'package:irhydra/src/modes/code.dart';
import 'package:irhydra/src/parsing.dart' as parsing;
import 'package:irhydra/src/xref.dart' as xref;

import 'package:js/js.dart' as js;

/** Display given [ir] and [code] belonging to the [method]. */
displayIR(pane, method, ir, code, codeMode) {
  final descriptions = document.query("#v8-ir-descriptions").xtag;

  // Format IR instruction opcode. If description is available link create a
  // popover.
  formatOpcode(ns, opcode) {
    final element = span('boldy', opcode);

    final desc = descriptions.lookup(ns, opcode);
    if (desc != null) {
      js.scoped(() {
        js.context.jQuery(element).popover(js.map({
          "title": opcode,
          "content": desc,
          "trigger": "hover",
          "placement": "bottom",
          "html": true,
          "container": "body"
        }));
      });
    }

    return element;
  }

  // Add given instruction to the pane.
  // ns specifies whether instruction is hir or lir one.
  add(ns, id, opcode, operands, formatter) =>
    pane.add(id, new SpanElement()..append(formatOpcode(ns, opcode))
                                  ..appendText(" ")
                                  ..append(formatter(operands)));

  final makeBlockRef = xref.makeReferencer(pane.rangeContentAsHtmlFull,
                                           pane.href,
                                           type: xref.POPOVER);
  final makeValueRef = xref.makeReferencer(pane.rangeContentAsHtml,
                                           pane.href,
                                           type: xref.TOOLTIP);
  
  // TODO(mraleph): allow makeFormatter to forward group captures to the formatting callbacks.
  final RANGE = new RegExp(r"^range:(-?\d+)_(-?\d+)(_m0)?$");

  // Formatter for HIR operands.
  final formatHir = formatting.makeFormatter({
    r"0x[a-f0-9]+": (val) => span('hir-constant', val),
    r"B\d+\b": makeBlockRef,
    r"[xstvid]\d+\b": makeValueRef,
    r"range:[^\s]+": (val) {
      final m = RANGE.firstMatch(val);
      final range = span('hir-range', "[${m.group(1)}, ${m.group(2)}]");
      if (m.group(3) != null) {
        range.appendHtml("&cup;{-0}");
      }      
      return range;
    },
    r"changes\[[^\]]+\]": (val) => span(val == "changes[*]" ? 'hir-changes-all' : 'hir-changes', val),
    r"type:\w+": (val) => span('hir-type', val.split(':').last),
  });

  // Formatter for LIR operands.
  final formatLir = formatting.makeFormatter({
    r"\[id=.+\]\]": (val) => span('lir-env', val),
    r"{[^}]+}": (val) => span('lir-map', val),
    r"B\d+\b": makeBlockRef,
  });

  // Output code prologue.
  new CodeSplicer(pane, code, code.prologue, codeMode).emitRest();

  // Output block bodies.
  for (var block in ir.values) {
    // Block name.
    pane.add(" ", " ");
    pane.add(span('boldy', block.name), " ", id: block.name);

    // First hydrogen (highlevel IR).
    decomposeHIR(block.hir, (id, opcode, operands) {
      add("hir", id, opcode, operands, formatHir);
    });

    // Then lithium (lowlevel IR) and native code generated from it.
    final codeSplicer = new CodeSplicer(pane,
                                        code,
                                        code.codeOf(block.name),
                                        codeMode);

    decomposeLIR(block.lir, (id, opcode, operands) {
      // Lithium ids are multiplied by 2 in the hydrogen.cfg (artifact of
      // the register allocation architecture).
      codeSplicer.emitUntil("@${int.parse(id) ~/ 2}");

      var ln = add("lir", id, opcode, operands, formatLir);
      ln.gutter.classes.add("lir-gutter");
      ln.text.classes.add("lir-line");
    });

    // Rest of the native code for the block (jumps and parallel moves).
    codeSplicer.emitRest();
    pane.createRange(block.name);  // Mark block range for cross-references.
  }

  // Ouput code epilogue.
  pane.add(" ", " ");
  new CodeSplicer(pane, code, code.epilogue, codeMode).emitRest();

  // Create deoptimiztion markers and quick links to them.
  document.query(".ir-quick-links").nodes.clear();
  if (!method.deopts.isEmpty) {
    DeoptAnnotator.annotate(pane, method, ir, code);
  }
}

/** Single HIR instruction from the hydrogen.cfg. */
final hirLineRe = new RegExp(r"^\s+\d+\s+\d+\s+([xstvid]\d+)\s+([-\w]+)\s*(.*)<");

/** Parses hydrogen instructions into SSA name, opcode and operands. */
decomposeHIR(hir, cb) {
  hir.forEach((line) {
    final m = hirLineRe.firstMatch(line);
    if (m != null) cb(m.group(1), m.group(2), m.group(3));
  });
}

/** Single LIR instruction from hydrogen.cfg. */
final lirLineRe = new RegExp(r"^\s+(\d+)\s+([-\w]+)\s*(.*)<");

/** Matches ignored gap moves inserted by lithium-allocator. */
final lirLineIgnoredMovesRe = new RegExp(r"\(0\) = \[[^\]]+\];");

/** Matches redundant gap moves inserted by lithium-allocator. */
final lirLineRedundantMovesRe = new RegExp(r"([^ ])\[[^\]]+\];");

/**
 * Parses lithium instructions into id, opcode and operands.
 * Removes ignored and redundant gap moves and discards empty gaps and labels.
 */
decomposeLIR(lir, cb) {
  lir.forEach((line) {
    final m = lirLineRe.firstMatch(line);
    if (m != null) {
      final opcode = m.group(2);
      final operands = m.group(3);

      if (opcode == "label" || opcode == "gap") {
        final cleaned = operands.replaceAll(lirLineIgnoredMovesRe, "")
                                .replaceAll("()", "")
                                .replaceAllMapped(lirLineRedundantMovesRe,
                                                  (m) => m.group(1))
                                .replaceAll(new RegExp(r"\s+"), " ");
        if (cleaned.contains("=")) {  // Any moves left?
          cb(m.group(1), opcode, cleaned);
        }
      } else {
        cb(m.group(1), opcode, operands);
      }
    }
  });
}

/** Annotates [IRPane] with deoptization markers. */
class DeoptAnnotator {
  /** [true] if deoptimization information is for 32bit platform. */
  final is32Bit;

  /** [IRPane] that contains IR and native code to be annotated. */
  final pane;

  final method;
  final ir;
  final code;

  static annotate(pane, method, ir, code) =>
      new DeoptAnnotator(pane, method, ir, code)..annotateDeopts();

  DeoptAnnotator(pane, method, this.ir, this.code)
      : pane = pane,
        method = method,
        is32Bit = are32BitDeopts(method.deopts);

  annotateDeopts() {
    for (var deopt in method.deopts) {
      annotateDeopt(deopt);
    }
  }

  /** Matches code comment outputted as a part of the deopt information. */
  final lirReferenceRe = new RegExp(r"^\s+;+.*@(\d+)");
  annotateDeopt(deopt) {
    // If we are on 32bit we can rely on the second line of the deopt
    // that contains comment with lir reference.
    if (is32Bit && deopt.raw.length > 2) {
      final m = lirReferenceRe.firstMatch(deopt.raw[1]);
      if (m != null) {
        final lirId = _translateLirId(m.group(1));
        createMarkerAt(lirId, deopt);
        return;
      }
    }

    // Either we are on x64 where comment printed together with the deopt
    // has nothing to do with the actual deopt place or we are on ia32
    // but there is a comment in between deopt point and a comment with a
    // reference. In both cases we need to compute reverse mapping.
    if (bailoutsMapping == null) {
      // TODO(vegorov): fallback to ast id matching.
      document.query("#unmatched-deopt-warning").style.display = "block";
      return;
    }

    final lirId = bailoutsMapping[deopt.id];
    createMarkerAt(lirId, deopt);
  }

  /** Create marker for [deopt] at the line corresponding to [lirId]. */
  createMarkerAt(lirId, deopt) {
    assert(lirId != null);

    // Create a marker with a popover containing raw deopt information.
    final marker = new SpanElement()
        ..classes.addAll(['label', 'label-important', 'deopt-marker'])
        ..text = "deopt";

    js.scoped(() {
      final divElement = new PreElement()
          ..appendText(deopt.raw.join('\n'));
      final raw = toHtml(divElement);
      js.context.jQuery(marker).popover(js.map({
        "title": "",
        "content": "${raw}",
        "placement": "bottom",
        "html": true,
        "container": 'body'
      })).data('popover').tip().addClass('deopt');
    });

    pane.line(lirId).text.append(marker);

    // Create quick link to the deopt line.
    final link = new AnchorElement(href: "#${pane.href(lirId)}")
        ..classes.addAll(['label', 'label-important'])
        ..text = "deopt @${lirId}";
    document.query(".ir-quick-links").nodes.add(link);
  }

  /** Translates lir id extracted from a code comment into hydrogen.cfg id. */
  _translateLirId(lirId) => (int.parse(lirId) * 2).toString();

  var _bailoutsMappingComputed = false;
  var _bailoutsMapping;

  /** Returns a mapping from bailout ids to lir ids. */
  get bailoutsMapping {
    if (!_bailoutsMappingComputed) {
      _bailoutsMapping = computeBailoutsMapping();
      _bailoutsMappingComputed = true;
    }
    return _bailoutsMapping;
  }

  /** Matches bailout id comment attached to the jump or mov instructions. */
  final bailoutRe = new RegExp(r"^deoptimization bailout (\d+)");

  /** Matches deopt_id data stored in lithium environment in hydrogen.cfg. */
  final deoptIdRe = new RegExp(r"^\s+(\d+)\s+.*deopt_id=(\d+)");

  /** Matches lir id embedded into code comment. */
  final commentLirReferenceRe = new RegExp(r"@(\d+)");

  /**
   * Try computing bailout id to lir id mapping.
   *
   * For newer V8 (from 3.17.1) this information can be extracted from lithium
   * environments dumped to hydrogen.cfg.
   *
   * For older V8's it can only be extracted from native code disassembly by
   * finding [bailoutRe] comments.
   */
  computeBailoutsMapping() {
    // On newer V8 deopt id is printed as part of the lithium environment.
    if (_irContainsDeoptMapping()) {
      final mapping = new Map<int, String>();
      recordMapping(lirId, deoptId) =>
          mapping[int.parse(deoptId)] = lirId;

      for (var block in ir.values) {
        if (block.lir != null) {
          for (var line in block.lir) {
            parsing.match(line, deoptIdRe, recordMapping);
          }
        }
      }

      return mapping;
    }

    // Disassembly is not available. There is no other reliable way to compute
    // required mapping. Give up.
    if (code == null) {
      return null;
    }

    // First find all comments mentioning bailout id.
    final bailoutPos = new Map<int, int>();

    final instructions = code.code;
    for (var i = 0; i < instructions.length; i++) {
      final instr = instructions[i];
      if ((instr is Instruction || instr is Jump) && instr.comment != null) {
        parsing.match(instr.comment, bailoutRe, (bailout) {
          final id = int.parse(bailout);
          if (!bailoutPos.containsKey(id)) {
            bailoutPos[id] = i;
          }
        });
      }
    }

    if (!is32Bit) {
      // On x64 deoptimization jumps are indirect:
      //
      //   55 jo 174
      //     ...
      //  174 REX.W movq r10, 0x2564c493c00a    ;; deoptimization bailout 1
      //  160 jnz 213
      //

      // Build reverse mapping of offsets to bailouts.
      final bailoutByOffs = new Map<int, int>();
      for (var id in bailoutPos.keys) {
        final pos = bailoutPos[id];
        final instr = instructions[pos];
        bailoutByOffs[instr.offset] = id;
      }

      bailoutPos.clear();  // Discard everything collected so far.

      // Find jumps that lead to bailout jumps and record them as bailouts.
      for (var i = 0; i < instructions.length; i++) {
        final instr = instructions[i];
        if (instr is Jump && bailoutByOffs.containsKey(instr.target)) {
          final id = bailoutByOffs[instr.target];
          bailoutPos[id] = i;
        }
      }
    }

    // Now relate bailout positions to lir instructions searching backwards from
    // the bailout point for a comment that contains lir id reference.
    final bailoutToLir = new Map<int, String>();

    for (var id in bailoutPos.keys) {
      recordMapping(lirId) => bailoutToLir[id] = _translateLirId(lirId);

      for (var pos = bailoutPos[id]; pos >= 0; pos--) {
        final instr = instructions[pos];
        if (instr is Comment &&
            instr.comment != null &&
            parsing.match(instr.comment, commentLirReferenceRe, recordMapping)) {
          break;
        }
      }
    }

    return bailoutToLir;
  }

  /** Marker matching the start of lithium environment. */
  static const LIR_ENVIROMENT_MARKER = "[id=";

  /** Returns [true] if bailout information is present in hydrogen.cfg. */
  _irContainsDeoptMapping() {
    if (ir == null) {
      return false;
    }

    // Try every lir line for a match with environment marker.
    for (var block in ir.values) {
      if (block.lir != null) {
        for (var line in block.lir) {
          if (line.contains(LIR_ENVIROMENT_MARKER)) {
            // Does environment contain a deopt_id data?
            return deoptIdRe.hasMatch(line);
          }
        }
      }
    }

    return false;
  }

  /** Matches memory address. */
  static final addressRe = new RegExp(r"0x([a-f0-9]+)");

  /** Returns [true] if deopt data does not contain any non-32bit address. */
  static are32BitDeopts(deopts) {
    for (var deopt in deopts) {
      for (var line in deopt.raw) {
        for (var match in addressRe.allMatches(line)) {
          if (match.group(1).length > 8) {
            return false;  // 64-bit constant found
          }
        }
      }
    }
    return true;
  }
}