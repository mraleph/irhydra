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

/** Parsing disassembly dumped by V8. */
library modes.v8.code_parser;

import 'package:irhydra/src/modes/code.dart';
import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:irhydra/src/modes/v8/name_parser.dart' as name_parser;
import 'package:irhydra/src/parsing.dart' as parsing;

/** Start of the optimized code dump. */
final CODE_MARKER = "--- Optimized code ---";
final DEOPT_MARKER = new RegExp(r"\[deoptimizing \(DEOPT \w+\): begin");
final SOURCE_MARKER = new RegExp(r"\-\-\- FUNCTION SOURCE \(");

canRecognize(String text) =>
  text.contains(CODE_MARKER) || DEOPT_MARKER.hasMatch(text) || SOURCE_MARKER.hasMatch(text);

/** Split [text] into separate optimized code dumps. */
List<IR.Method> preparse(String text) =>
    (new PreParser(text)..parse()).methods;

/** Parse given code dump. */
Code parse(Iterable<String> lines) =>
    lines != null ? (new Parser(lines)..parse()).code : new Code.empty();


/** Class that recognizes code disassembly and deoptimization events */
class PreParser extends parsing.ParserBase {
  final methods = <IR.Method>[];

  final optId = new Optional();

  IR.Method currentMethod;
  var timestamp = 0;

  PreParser(text) : super(text.split('\n'));

  enterMethod(name, optimizationId) {
    if (currentMethod != null && currentMethod.optimizationId == optimizationId) {
      return;
    }
    currentMethod = new IR.Method(name_parser.parse(name),
                                  optimizationId: optimizationId);
    methods.add(currentMethod);
  }

  leaveMethod() { currentMethod = null; }

  get patterns => {
    // Start of the dump.
    r"^\-\-\- Optimized code \-\-\-$": {
      r"^optimization_id = (\d+)$": (optId) {  // Function name.
        this.optId.put(optId);
      },

      r"^name = ([\w.]*)$": (name) {  // Function name.
        enterMethod(name, optId.take());
      },

      r"^Instructions": {  // Disassembly of the body.
        r"^\s+;;; Safepoint table": () {
          // Code is produced during the very last compilation phase.
          if (!optId.isEmpty) {
            enterMethod("", optId.take());
          }

          currentMethod.phases.add(new IR.Phase(currentMethod, "Z_Code generation", code: subrange()));
          leaveMethod();
          // Leave this (instructions) and outer (code) states.
          leave(nstates: 2);
        }
      }
    },

    // Start of source dump.
    r"^\-\-\- FUNCTION SOURCE \(([^)]*)\) id{(\d+),(\d+)} \-\-\-$": (name, optId, funcId) {
      enterMethod(name, optId);
      enter({
        r"^\-\-\- END \-\-\-$": () {
          final id = int.parse(funcId);
          assert(currentMethod.sources.length == id);
          currentMethod.sources.add(new IR.FunctionSource(id, name, subrange()));

          if (currentMethod.sources.length == 1) {
            assert(currentMethod.inlined.isEmpty);
            // This is the first source. Create an InlinedFunction for it.
            currentMethod.inlined.add(
                new IR.InlinedFunction(currentMethod, 0, currentMethod.sources.first, null));
          }

          leave();
        }
      });
    },

    // Start of source dump.
    r"^INLINE \(([^)]*)\) id{(\d+),(\d+)} AS (\d+) AT <(\?|\d+:\d+)>$": (name, optId, funcId, inlineId, pos) {
      inlineId = int.parse(inlineId);
      funcId = int.parse(funcId);
      assert(currentMethod.optimizationId == optId);
      assert(currentMethod.inlined.length == inlineId);

      if (pos == "?") {
        pos = null;
      } else {
        final s = pos.split(":").map(int.parse).toList();
        pos = new IR.SourcePosition(s[0], s[1]);
      }

      currentMethod.inlined.add(
          new IR.InlinedFunction(currentMethod, inlineId, currentMethod.sources[funcId], pos));
    },

    // Start of the deoptimization event (we drop no-name deopts)
    r"^\[deoptimizing \(DEOPT (\w+)\): begin 0x[a-f0-9]+ ([\w$.]*) \(opt #(\d+)\) @(\d+)": (type, methodName, optId, bailoutId) {
      var reason;
      enter({
        r"^\s+;;; deoptimize: (.*)$": (val) { reason = val; },

        r"^\[deoptimizing \(\w+\): end": () {
          final deopt =
              new IR.Deopt(timestamp++,
                           int.parse(bailoutId),
                           subrange(inclusive: true),
                           reason: reason,
                           type: type,
                           optimizationId: optId);

          for (var currentMethod in methods.reversed) {
            if (currentMethod.optimizationId == optId) {
              currentMethod.addDeopt(deopt);
              break;
            }
          }

          // TODO(vegorov): add warning about lost deopts.
          leave();
        }
      });
    },
  };
}

/** Disassembly parser. */
class Parser extends parsing.ParserBase {
  final _code = [];
  final blocks = {};

  /** Base address of the code object. */
  int start;

  /** Current basic block range. */
  Range block;

  Parser(lines) : super(lines);

  get patterns => {
    // Instruction.
    r"^0x([a-f0-9]+)\s+(\d+)\s+[a-f0-9]+\s+([^;]+)(;;.*)?$": (address,
                                                              offs,
                                                              instr,
                                                              [comment]) {
      parseInstruction(int.parse(address, radix: 16), instr, comment);
    },

    // Block start.
    r"^\s+;;; <@\d+,#\d+> \-+ (B\d+)": (name) {
      if (block != null) block.end = _code.length;
      blocks[name] = block = new Range(_code.length);
    },

    // Comment.
    r"^\s+;*\s*(.*)$": (text) => parseComment(text),
  };

  /** Matches local jumps in V8 disassembly. They are formatted with offset. */
  final localJumpRe = new RegExp(r"^(j\w+) (\d+) ");

  parseInstruction(addr, instr, comment) {
    if (start == null) start = addr;

    final offset = addr - start;

    if (comment != null) {
      // Drop comment's ;;-prefix.
      comment = comment.replaceAll(new RegExp(r"^;;\s+"), "");
    }

    // Check if instruction is formatted as a local jump to an offset inside
    // this code object.
    final localJump = localJumpRe.firstMatch(instr);
    if (localJump != null) {
      final opcode = localJump.group(1);
      final target = int.parse(localJump.group(2));
      _code.add(new Jump(offset, opcode, target, comment));
      return;
    }

    // Other instructions (inluding jumps to absolute addresses).
    _code.add(new Instruction(offset, instr, comment));
  }

  parseComment(comment) {
    // If the last instruction was a "gap" or "label" comment then drop it.
    // Empty labels and gaps do not carry any interesting information.
    if (_code.last is Comment) {
      final lastComment = _code.last.comment;
      if (lastComment.contains(": gap.") ||
          lastComment.contains(": label.")) {
        _code.removeLast();
      }
    }

    // Check if we reached code epilogue containing deferred code.
    if ((comment.startsWith("Deferred") ||
         comment.contains("-- Jump table --")) &&
        block != null) {
      block.end = _code.length;
      block = null;
    }

    _code.add(new Comment(comment));
  }

  get code {
    if (block != null) block.end = _code.length;  // Finalize last block.
    return new Code(start, _code, blocks);
  }
}

class Optional {
  var _value;

  put(value) {
    assert(_value == null);
    _value = value;
  }

  take() {
    var v = _value;
    _value = null;
    return v;
  }

  get isEmpty => _value == null;
}