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

/** Dart VM mode */
library modes.dartvm;

import 'package:irhydra/src/modes/dartvm/code_parser.dart' as code_parser;
import 'package:irhydra/src/modes/dartvm/ir_parser.dart' as ir_parser;
import 'package:irhydra/src/modes/dartvm/preparser.dart' as preparser;
import 'package:irhydra/src/modes/ir.dart' as ir;
import 'package:irhydra/src/modes/code.dart' show CodeCollector, Comment, Jump;
import 'package:irhydra/src/modes/mode.dart';

class _Descriptions {
  lookup(ns, value) => null;
}

class Mode extends BaseMode {
  final irs = const [const HIRDescriptor()];

  load(String str) {
    if (!preparser.canRecognize(str)) {
      return false;
    }

    methods = preparser.parse(str);
    return true;
  }

  final descriptions = new _Descriptions();

  toIr(method, phase, statusObject) {
    final blocks = ir_parser.parse(phase.ir);
    final code = code_parser.parse(phase.code);
    _attachCode(blocks, code);


    if (method.deopts.isNotEmpty) {
      final jumps = new Map<int, ir.Instruction>();

      for (var block in blocks.values) {
        for (var hirOp in block.hir) {
          if (hirOp.code == null) continue;
          for (var asmOp in hirOp.code) {
            if (asmOp is Jump) {
              jumps[asmOp.target] = hirOp;
            }
          }
        }
      }


      final deopts = new Map<int, ir.Deopt>.fromIterable(method.deopts, key: (deopt) => int.parse(deopt.id, radix: 16), value: (deopt) => deopt);

      var previous = null;
      code.epilogue.forEach((instr) {
        if (instr is Comment) return;

        final deopt = deopts[instr.offset + code.start];
        if (deopt != null) {
          deopt.hir = jumps[previous.offset];
        }
        previous = instr;
      });
    }

    return new ir.ParsedIr(method, this, blocks, code, method.deopts);
  }

  lastOffset(code) => code_parser.lastOffset(code());

  _attachCode(blocks, code) {
    for (var block in blocks.values) {
      final codeCollector = new CodeCollector(code.codeOf(block.name));

      var previous = block.hir.first;
      assert(previous.op == null);
      for (var instr in block.hir.skip(1)) {
        // TODO(mraleph) previously we used deoptid to improve matching quality.
        final marker = instr.id != null ? "${instr.id} <- ${instr.op}"
                                         : "${instr.op}";
        codeCollector.collectUntil(marker);

        if (!codeCollector.isEmpty) {
          if (previous.code == null) previous.code = [];
          previous.code.addAll(codeCollector.collected);
        }

        previous = instr;
      }

      codeCollector.collectRest();

      if (!codeCollector.isEmpty) {
        if (previous.code == null) previous.code = [];
        previous.code.addAll(codeCollector.collected);
      }
    }
  }
}