// Copyright 2014 Google Inc. All Rights Reserved.
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

library graph_pane;

import 'dart:html';
import 'package:ui_utils/task.dart';
import 'package:ui_utils/graph_layout.dart' as graphview;
import 'package:polymer/polymer.dart';

class HoverDetail {
  final label;
  final blockId;
  HoverDetail(this.label, this.blockId);
}

/**
 * Two column WebComponent used to display IRs and native code line by line.
 *
 * Individual lines or whole ranges can have an identifier associated with them
 * that allows to access these lines content as HTML, apply styles or reference
 * them by an [AnchorElement].
 *
 * First column *gutter* is used to display identifier e.g. block name,
 * SSA name or instruction's offset.
 *
 * Second column is for line's content e.g. instruction body itself.
 */
@CustomTag('graph-pane')
class GraphPane extends PolymerElement {
  @published var ir;

  var _renderTask;

  GraphPane.created() : super.created() {
    _renderTask = new Task(render, frozen: true);
  }

  attached() {
    super.attached();
    _renderTask.unfreeze();
  }

  irChanged() => _renderTask.schedule();

  clear() => $["graph"].nodes.clear();

  showLegend() {
    $["legend"].open();
  }

  render() {
    if (ir == null) {
      return;
    }

    final stopwatch = new Stopwatch()..start();
    graphview.display($["graph"], ir.blocks, (label, blockId) {
      label.onMouseOver.listen((event) => fire("block-mouse-over", detail: new HoverDetail(event.target, blockId)));
      label.onMouseOut.listen((_) => fire("block-mouse-out"));
      label.onClick.listen((event) {
        // TODO(mraleph): Shadow DOM polyfill seems to be interfering with links in SVG. Have to switch manually.
        (document.window.location as Location).hash = "ir-${blockId}";
      });
    }, blockTicks: ir.blockTicks);
    print("GraphPane.render() took ${stopwatch.elapsedMilliseconds}");
  }
}
