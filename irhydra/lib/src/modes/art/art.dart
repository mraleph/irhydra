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

/** Mode for parsing ART's art.cfg */
library modes.art;

import 'dart:html' as html;

import 'package:irhydra/src/modes/ir.dart' as ir;
import 'package:irhydra/src/modes/code.dart' show Code;
import 'package:irhydra/src/modes/mode.dart';
import 'package:irhydra/src/modes/art/cfg_parser.dart' as cfg_parser;

class _ARTHIRDescriptor extends HIRDescriptor {
  const _ARTHIRDescriptor() : super();

  codeOf(instr, {skipComment: false}) => instr.code;
}

/**
 * Mode for viewing of ART's compilation artifacts.
 *
 * Data arrives in the form of a single C1Visualizer CFG file.
 *
 */
class Mode extends BaseMode {
  final irs = const [const _ARTHIRDescriptor()];

  load(text) {
    if (cfg_parser.canRecognize(text)) {
      methods = cfg_parser.preparse(text);
      return true;
    } else {
      return false;
    }
  }

  toIr(method, phase, statusObject) {
    final blocks = cfg_parser.parse(method, phase.ir, statusObject);
    final code = hasCode(blocks) ? new Code.empty() : null;
    return new ir.ParsedIr(method, this, blocks, code, method.deopts);
  }

  static bool hasCode(blocks) {
    for (var block in blocks.values) {
      for (var instr in block.hir) {
        if (instr.code != null && !instr.code.isEmpty) {
          return true;
        }
      }
    }
    return false;
  }
}
