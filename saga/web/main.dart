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

library saga.main;

import 'dart:html';

import 'package:saga/src/parser.dart' as parser;
import 'package:ui_utils/xref.dart';
import 'package:saga/src/flow.dart' as flow;
import 'package:saga/src/ui/ir_pane/ir_pane.dart' as ir_pane;
import 'package:ui_utils/graph_layout.dart' as graph_layout;
import 'package:saga/src/ui/code_pane.dart' as code_pane;

timeAndReport(action, name) {
  final stopwatch = new Stopwatch()..start();
  final result = action();
  print("${name} took ${stopwatch.elapsedMilliseconds} ms.");
  return result;
}

displayGraph(Element pane, blocks, ref) {
  final stopwatch = new Stopwatch()..start();
  graph_layout.display(pane, blocks, (label, blockId) {
    label.onMouseOver.listen((event) => ref.show(event.target, blockId));
    label.onMouseOut.listen((_) => ref.hide());
  });
  print("graph_layout took ${stopwatch.elapsedMilliseconds}");
}

render(code, {keepScroll: false}) {
  var flowData;
  timeAndReport(() {
    flowData = flow.build(code);
  }, "flow analysis");

  displayGraph(document.getElementById('graph'), flowData.blocks, new XRef((id) {
    return "<pre>" + flowData.blocks[id].asm.join('\n') + "</pre>";
  }));

  timeAndReport(() {
    code_pane.render(document.getElementById('code'), flowData, keepScroll: keepScroll);
    ir_pane.render(document.getElementById('ir'), flowData.blocks);
  } , "rendering");
}

main() {
  HttpRequest.getString("code.asm").then((text) {
    final code = timeAndReport(() => parser.parse(text), "parsing");
    render(code);

    code.changes.listen((_) => render(code, keepScroll: true));
  });
}