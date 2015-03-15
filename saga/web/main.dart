
import 'dart:html';

import 'package:saga/src/parser.dart' as parser;
import 'package:ui_utils/xref.dart';
import 'package:saga/src/flow.dart' as flow;
import 'package:saga/src/ui/ir_pane/ir_pane.dart' as ir_pane;
import 'package:ui_utils/graph_layout.dart' as graph_layout;
import 'package:saga/src/ui/code_pane.dart' as code_pane;

class Graph {
  final blocks;
  final blockTicks = null;

  Graph(this.blocks);
}

timeAndReport(action, name) {
  final stopwatch = new Stopwatch()..start();
  final result = action();
  print("${name} took ${stopwatch.elapsedMilliseconds} ms.");
  return result;
}

displayGraph(Element pane, Graph graph, ref) {
  final stopwatch = new Stopwatch()..start();
  graph_layout.display(pane, graph.blocks, (label, blockId) {
    label.onMouseOver.listen((event) => ref.show(event.target, blockId));
    label.onMouseOut.listen((_) => ref.hide());
  }, blockTicks: graph.blockTicks);
  print("graph_layout took ${stopwatch.elapsedMilliseconds}");
}

class SagaApp {
  var blockRef;
  var flowData;

  HtmlElement get code => document.getElementById('code');

  /// Called when main-app has been fully prepared (Shadow DOM created,
  /// property observers set up, event listeners attached).
  ready() {
    HttpRequest.getString("code.asm").then((text) {
      final code = timeAndReport(() => parser.parse(text), "parsing");
      render(code);

      code.changes.listen((_) => render(code, keepScroll: true));
    });
  }

  render(code, {keepScroll: false}) {
    timeAndReport(() {
      flowData = flow.build(code);
    }, "flow analysis");

    displayGraph(document.getElementById('graph'), new Graph(flowData.blocks), new XRef((id) {
      return "<pre>" + flowData.blocks[id].asm.join('\n') + "</pre>";
    }));

    timeAndReport(() {
      code_pane.render(document.getElementById('code'), flowData, keepScroll: keepScroll);
      ir_pane.render(document.getElementById('ir'), flowData.blocks);
    } , "rendering");
  }
}


main() {
  new SagaApp().ready();
}