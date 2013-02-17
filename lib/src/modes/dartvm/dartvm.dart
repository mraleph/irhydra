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
library dartvm;

import 'package:irhydra/src/modes/dartvm/code_parser.dart' as code_parser;
import 'package:irhydra/src/modes/dartvm/ir_parser.dart' as ir_parser;
import 'package:irhydra/src/modes/dartvm/preparser.dart' as preparser;
import 'package:irhydra/src/modes/dartvm/view.dart' as view;
import 'package:irhydra/src/modes/mode.dart';
import 'package:irhydra/src/ui/graph.dart' as graphview;
import 'package:irhydra/src/xref.dart' as xref;

class Mode extends BaseMode {
  canRecognize(text) =>
    preparser.canRecognize(text);

  parse(String str) =>
    preparser.parse(str);

  displayPhase(method, phase) {
    ir = ir_parser.parse(phase.ir);
    code = code_parser.parse(phase.code);

    updateIRView();

    final attachRef =
        xref.makeAttachableReferencer(pane.rangeContentAsHtmlFull);
    graphview.display(graphPane, ir, attachRef);
  }

  updateIRView() {
    pane.clear();
    view.display(pane, ir, code, codeMode);
  }
}