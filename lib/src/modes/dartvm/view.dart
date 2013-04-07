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

/** Display Dart VM IR and code on the [IRPane]. */
library view;

import 'dart:html';

import 'package:irhydra/src/modes/code.dart';
import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:irhydra/src/formatting.dart' as formatting;
import 'package:irhydra/src/html_utils.dart';
import 'package:irhydra/src/parsing.dart' as parsing;
import 'package:irhydra/src/xref.dart' as xref;

display(pane, blocks, code, codeMode, {ticks, blockTicks}) {
  new _Renderer(pane, codeMode, blocks, code, ticks, blockTicks).display();
}

class _Renderer {
  /** [IRPane] that is used to display IR. */
  final pane;

  /** Current code rendering mode. */
  final codeMode;

  /** IR control flow graph. */
  final blocks;

  /** Native code. */
  final code;

  /** Profiling ticks percentages per instruction. */
  final ticks;

  /** Profiling ticks percentages per block. */
  final blockTicks;

  /** [xref] referencer producing anchor elements for definition uses. */
  final makeDefinitionRef;

  /** [xref] referencer producing anchor elements for block references. */
  final makeBlockRef;

  /** [formatting.Formatter] for IR instruction operands. */
  var formatOperands;

  _Renderer(pane, this.codeMode, this.blocks, this.code, this.ticks, this.blockTicks)
      : pane = pane,
        makeDefinitionRef = xref.makeReferencer(pane.rangeContentAsHtml,
                                                pane.href,
                                                type: xref.TOOLTIP),
        makeBlockRef = xref.makeReferencer(pane.rangeContentAsHtmlFull,
                                           pane.href,
                                           type: xref.POPOVER) {
    formatOperands = formatting.makeFormatter({
      r"v\d+\b": makeDefinitionRef,
      r"B\d+\b": makeBlockRef
    });
  }

  /** Output all artifacts to the [pane]. */
  display() {
    // Display code prologue.
    new CodeSplicer(pane, code, code.prologue, codeMode).emitRest();

    // Display blocks.
    for (var block in blocks.values) {
      displayBlock(block);
    }

    // Display code epilogue.
    pane.add(" ", " ");
    new CodeSplicer(pane, code, code.epilogue, codeMode).emitRest();
  }

  /** Output a single [block] to the [pane]. */
  displayBlock(IR.Block block) {
    final blockCode = code.codeOf(block.name);

    final codeSplicer = new CodeSplicer(pane, code, blockCode, codeMode);

    // Block name.
    pane.add(" ", " ");

    var blockComment = "";
    if (blockTicks != null && blockTicks[block.name] > 0.0) {
      final percentage = blockTicks[block.name];
      blockComment = new Element.html("<em>(${percentage.toStringAsFixed(2)}% ticks)</em>");
    }

    pane.add(span("boldy", block.name), blockComment, id: block.name);

    // Block HIR body. Dart VM has no LIR.
    for (var instr in block.hir) {
      final marker = instructionMarker(instr);
      if (marker != null) codeSplicer.emitUntil(marker);

      if (instr is IR.Branch) {
        displayBranch(instr);
      } else {
        displayInstruction(instr);
      }
    }

    if (block.successors.length == 1) {  // Emit implicit goto.
      codeSplicer.emitUntil("goto:");
      displayGoto(block.successors.first.name);
    }

    codeSplicer.emitRest();  // Block epilogue: jump and parallel moves.

    pane.createRange(block.name);  // Mark block range for block's references.
  }

  /** Output a [Branch] instruction. */
  displayBranch(instr) {
    pane.add(" ", new SpanElement()
                     ..append(span("boldy", "if "))
                     ..append(format(instr.op, instr.args))
                     ..append(span("boldy", " goto "))
                     ..appendText("(")
                     ..append(makeBlockRef(instr.true_successor))
                     ..appendText(", ")
                     ..append(makeBlockRef(instr.false_successor))
                     ..appendText(")"));
  }

  /** Ouput an implicit goto instruction. */
  displayGoto(target) {
    pane.add(" ", format("goto", "${target}"));
  }

  /** Ouput normal instruction. */
  displayInstruction(instr) {
    // Some instruction (e.g. CheckSmi) don't have an SSA name.
    pane.add(instr.id == null ? " " : instr.id,
             format(instr.op, instr.args));
  }

  /** Format a single instruction from given [opcode] and [operands]. */
  format(opcode, operands) =>
    new SpanElement()..append(span("boldy", opcode))
                     ..appendText(' ')
                     ..append(formatOperands(operands));

  /** Extracts opcode and deoptimization id from the raw instruction text. */
  final opcodeRe = new RegExp(r"([\w]+:-?\d+?)");

  /**
   * Return a reliable marker (opcode:deoptid) to use for identifiction during
   * code splicing.
   */
  instructionMarker(instr) {
    final m = opcodeRe.firstMatch(instr.raw);
    return (m != null) ? m.group(1) : null;
  }
}


