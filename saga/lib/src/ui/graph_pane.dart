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

library saga.ui.graph_pane;

import 'dart:html';
import 'dart:js' as js;

import 'package:liquid/liquid.dart';
import 'package:liquid/vdom.dart' as v;
import 'package:ui_utils/delayed_reaction.dart';
import 'package:ui_utils/graph_layout.dart' as graph_layout;

import 'package:saga/src/ui/code_pane.dart' as code_pane;
import 'package:saga/src/ui/ir_pane.dart' as ir_pane;
import 'package:saga/src/ui/tooltip.dart';

class BlockTooltip extends Tooltip {
  final flowData;

  final _delayed = new DelayedReaction(delay: const Duration(milliseconds: 100));

  BlockTooltip(this.flowData);


  var block;
  show(el, id) {
    _delayed.schedule(() {
      block = flowData.blocks[id];
      target = el;
      isVisible = true;
    });
  }

  hide() {
    _delayed.cancel();
    isVisible = false;
  }

  get content =>
    v.pre()(block != null ? [
      code_pane.vBlock(block: block, flowData: flowData),
      v.text('\n'),
      ir_pane.vBlock(block: block)
    ] : const []);
}


final vGraphPane = v.componentFactory(GraphPaneComponent);
class GraphPaneComponent extends Component {
  @property() var flowData;

  var graphPane;
  var tooltip;

  build() =>
    v.root()([
      graphPane = v.div(classes: const ['graph-pane']),
      (tooltip = new BlockTooltip(flowData)).build()
    ]);

  update() async {
    await writeDOM();
    displayGraph(graphPane.ref, flowData.blocks, tooltip);
  }

  static displayGraph(pane, blocks, ref) {
    final stopwatch = new Stopwatch()..start();
    graph_layout.display(pane, blocks, (label, blockId) {
      label.onMouseOver.listen((e) => ref.show(e.target, blockId));
      label.onMouseOut.listen((_) => ref.hide());
      label.onClick.listen((e) {
        for (var el in document.querySelectorAll('[data-block=${blockId}]')) {
          el.scrollIntoView();
          js.context.callMethod('jQuery', [el]).callMethod('effect', ['highlight', new js.JsObject.jsify({ 'color': 'rgba(203, 75, 22, 0.5)' }), 500]);
        }
        e.stopPropagation();
        e.preventDefault();
      });
    });
    print("graph_layout took ${stopwatch.elapsedMilliseconds}");
  }
}
