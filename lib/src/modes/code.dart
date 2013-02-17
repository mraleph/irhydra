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

/** Object model and rendering rules for native code artifacts. */
library code;

import 'dart:html' hide Comment;

import 'package:irhydra/src/formatting.dart' as formatting;
import 'package:irhydra/src/html_utils.dart';

/** Code object artifact. */
class Code {
  /** Base address of this code when it was emitted. */
  final int start;

  /** Individual instructions. */
  final List code;

  /** Basic block ranges. */
  final Map blocks;

  Code(this.start, this.code, this.blocks);

  /** Empty code object. */
  Code.empty() : start = 0, code = const [], blocks = const {};

  bool get isEmpty => code.isEmpty;

  /** Return all instructions generated for the given block [name].  */
  List codeOf(String name) => blocks.containsKey(name) ?
      code.getRange(blocks[name].start, blocks[name].length) : const [];

  /** Return instructions emitted before the very first block. */
  List get prologue => blocks.isEmpty ? const [] :
      code.getRange(0, blocks.values.first.start);

  /** Return instructions emitted after the very last block */
  List get epilogue => blocks.isEmpty ? const [] :
      code.getRange(blocks.values.last.end,
                    code.length - blocks.values.last.end);
}

/** Instruction range. */
class Range {
  int start, end;

  Range(this.start, [this.end]);

  int get length => end - start;
}

/** Single instruction. */
class Instruction {
  /** Offset from the code object's base address to this instruction. */
  final int offset;

  /** Instruction opcode with operands. */
  final String instr;

  /** Comment (if any) attached to the instruction. */
  final String comment;

  Instruction(this.offset, this.instr, [this.comment]);
}

/** Jump instruction (include conditional jumps). */
class Jump {
  /** Offset from the code object's base address to this instruction. */
  final int offset;

  /** Actual jump mnemonic (includes conditions). */
  final String opcode;

  /** Offset from the code object's base address to the target instruction. */
  final int target;

  /** Comment (if any) associated with this jump. */
  final String comment;

  Jump(this.offset, this.opcode, this.target, [this.comment]);
}

/** Comment between instructions. */
class Comment {
  final String comment;

  Comment(this.comment);
}

/**
 * Utility class that allows to splice disassembly into intermediate
 * representation when displaying both.
 */
class CodeSplicer {
  /** Display disassembly after each separate IR-instruction. */
  static const CODE_MODE_INLINE = "inline asm";

  /** Display disassembly after each block. */
  static const CODE_MODE_SEPARATE = "separate asm";

  /** Don't display disassembly. */
  static const CODE_MODE_NONE = "no asm";

  /** All available way to splice disassembly. */
  static const CODE_MODES =
      const [CODE_MODE_INLINE, CODE_MODE_SEPARATE, CODE_MODE_NONE];

  /** [IRPane] used for rendering. */
  final pane;

  /** Current splicing mode. */
  final mode;

  /** Code object that will be spliced. */
  final Code code;

  /** Instructions for the current code region (block, prologue or epilogue). */
  final Iterator instructions;

  CodeSplicer(this.pane, this.code, List instructions, this.mode)
    : instructions = instructions.iterator;

  /**
   * If code is displayed inline ([mode] is [CODE_MODE_INLINE]) then display
   * instructions from the current code region until a comment containing
   * given textual marker is reached.
   *
   * Marker itself will not be displayed because it is assumed to contain the
   * same information that a displayed IR-instruction has.
   */
  emitUntil(String marker) {
    if (mode != CODE_MODE_INLINE) {
      return;
    }

    while (instructions.moveNext() && !_atMarker(marker)) {
      _display(instructions.current);
    }
  }

  /** Display all instructions that are still not displayed or skipped. */
  emitRest() {
    if (mode == CODE_MODE_NONE) return;

    while (instructions.moveNext()) {
      _display(instructions.current);
    }
  }

  /** Check if we reached a [Comment] containing given textual marker. */
  _atMarker(String marker) =>
    instructions.current is Comment &&
    instructions.current.comment.contains(marker);

  /** Output a single instruction to the [IRPane]. */
  _display(instr) {
    if (instr is Instruction) {
      pane.add("${instr.offset}",
               _formatInstruction(instr),
               id: "offset-${instr.offset}",
               klass: 'native-code');
    } else if (instr is Comment) {
      pane.add(" ",
               _em(";; ${instr.comment}"),
               klass: 'native-code');
    } else if (instr is Jump) {
      pane.add("${instr.offset}",
               _formatJump(instr),
               id: "offset-${instr.offset}",
               klass: 'native-code');
    }
  }


  /** Opcode mnemonic regular expression. Strips REX.W prefix. */
  final opcodeRe = new RegExp(r"^(REX.W\s+)?([\w()]+)(.*)$");

  /** Object address constant regular expression used to decode V8 comments. */
  final addressImmediateRe = new RegExp(r"^;; object: (0x[a-f0-9]+) (.*)$");

  /** Format a single [Instruction]. */
  _formatInstruction(instr) {
    final m = opcodeRe.firstMatch(instr.instr);

    final opcode = m[2];
    final operands = m[3];

    var formattedOperands;
    if (instr.comment != null) {
      // If there is a comment available for this instruction try to
      // extract an information about address immediate embedded into the
      // instruction.
      final immediateDef = addressImmediateRe.firstMatch(instr.comment);
      if (immediateDef != null) {
        final immAddress = immediateDef.group(1);
        final immValue = immediateDef.group(2);

        // Reformat instruction operands renaming immediate address to display
        // immediate value inline.
        final map = {};
        map[immAddress] = (_) =>
            span('native-code-constant', "${immAddress} (${immValue})");

        formattedOperands = formatting.makeFormatter(map)(operands);
      }
    }

    if (formattedOperands == null) {
      // Operands were not handled specially. Just wrap them into a SpanElement
      // and append emphasized comment (if any).
      formattedOperands = new SpanElement()..appendText(operands);
      if (instr.comment != null) {
        formattedOperands.append(_em(";; ${instr.comment}"));
      }
    }

    return new SpanElement()..append(span('boldy', opcode))
                            ..append(formattedOperands);
  }

  /** Format a single jump instruction. */
  _formatJump(instr) {
    final elem = new SpanElement()..append(span('boldy', instr.opcode))
                                  ..appendText(" ");

    if (0 <= instr.target && instr.target <= code.code.last.offset) {
      // Jump target belongs to this code object. Display it as an offset and
      // format it as a reference to enable navigation.
      final anchor = pane.href("offset-${instr.target}");
      elem.append(new AnchorElement(href: "#${anchor}")..appendText("${instr.target}"));
    } else {
      // Jump target does not belong to this code object. Display it as an
      // absolute address.
      elem.appendText("${code.start + instr.target}");
    }

    if (instr.comment != null) {  // Append emphasized comment if available.
      elem.append(_em(";; ${instr.comment}"));
    }

    return elem;
  }

  /** Wrap text into `em` tag. */
  static _em(text) => new Element.tag('em')..appendText(text);
}