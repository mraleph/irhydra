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

import 'package:liquid/liquid.dart';
import 'package:liquid/vdom.dart' as v;
import 'package:observe/observe.dart';

import 'package:saga/src/parser.dart' as parser;
import 'package:saga/src/flow/flow.dart' as flow;
import 'package:saga/src/ui/ir_pane.dart' as ir_pane;
import 'package:saga/src/ui/code_pane.dart' as code_pane;
import 'package:saga/src/ui/graph_pane.dart' as graph_pane;
import 'package:saga/src/util.dart' show timeAndReport;

class SagaApp extends Observable {
  @observable var flowData;

  render(code) {
    flowData = timeAndReport(() => flow.build(code), "flow analysis");
  }

  display(text) {
    final code = timeAndReport(() => parser.parse(text), "parsing");
    render(code);

    code.changes.listen((_) => render(code));
  }
}

class SagaAppComponent extends Component {
  var app;

  init() {
    app.changes.listen((_) => invalidate());
  }

  build() =>
    v.root(classes: const ["saga-app", "saga-root"])(app.flowData == null ? const [] : [
      code_pane.vCodePane(flowData: app.flowData),
      graph_pane.vGraphPane(flowData: app.flowData),
      ir_pane.vIrPane(flowData: app.flowData)
    ]);
}

injectStylesheets(hrefs) {
  document.head.children.addAll(hrefs.map((href) => new LinkElement()
    ..rel = 'stylesheet'
    ..href = href));
}

main() {
  injectStylesheets(['packages/ui_utils/assets/tooltip.css', 'packages/ui_utils/assets/xref.css', 'styles.css']);

  final app = new SagaApp();
  injectComponent(new SagaAppComponent()..app = app, document.querySelector("body"));

  HttpRequest.getString("code.asm").then(app.display);
}