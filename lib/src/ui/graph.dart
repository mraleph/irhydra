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

/** Rendering control flow graph using SVG. */
library graph;

import 'dart:html';
import 'dart:math' as math;
import 'dart:svg';

import 'package:irhydra/src/draw2d/graph.dart' as graph;

/** Size of the block in pixels when rendered */
const BLOCK_SIZE = 40;

/** Block margin when rendered in pixels */
const BLOCK_MARGIN = 10;

/** Default font-family for blocks' labels */
const LABEL_STYLE = "font-family: Monaco, Menlo, Consolas, "
                    "\"Courier New\", monospace;";

/**
 * Renders the given control flow graph [blocks] on the [pane].
 *
 * Attaching cross-references to individual blocks using [attachRef].
 */
display(pane, blocks, attachRef, {blockTicks}) {
  // Convert blocks into Draw2d DirectedGraph and layout it.
  final g = _toDirectedGraph(blocks);
  _layoutDirectedGraph(g);

  // Compute loop nesting depth for each block. It will be used to
  // select appropriate fill color from the Brewer's palette.
  final loopNesting = _computeLoopNesting(blocks);

  var hotness = loopNesting;
  if (blockTicks != null) {
    hotness = new List(blocks.length);

    final maxPercentage = blockTicks.values.fold(0.0, math.max);
    for (var block in blockTicks.keys) {
      hotness[blocks[block].id] = (blockTicks[block] / maxPercentage * 5).ceil();
    }
  }

  // Clear the pane and create root svg element.
  pane.nodes.clear();

  final svg = new SvgElement.tag('svg');
  svg.attributes = {
    "height": "${g.size.height + 50}",
    "width": "${g.size.width + 50}",
    "version": "1.1"
  };

  final deadGroup = new SvgElement.tag('g');
  deadGroup.attributes = {
    "fill-opacity": "0.4",
    "stroke-opacity": "0.4",
  };
  svg.nodes.add(deadGroup);

  // Render all blocks. The bigger block's loop depth is the more intense color
  // will be used to fill it.

  for (var node in g.nodes) {
    final block = node.data;

    final rect = _createRect(x: node.x,
                             y: node.y,
                             width: node.width,
                             height: node.height,
                             r: 0,
                             fill: _selectFill(block, hotness[block.id]),
                             stroke: _selectStroke(block));

    final label = _createLabel(x: node.x + (node.width ~/ 2),
                               y: node.y + (node.height ~/ 2),
                               text: block.name,
                               href: "#ir-${block.name}");
    attachRef(label, block.name);

    if (block.marks.contains("dead")) {
      deadGroup.nodes.add(rect);
      deadGroup.nodes.add(label);
    } else {
      svg.nodes.add(rect);
      svg.nodes.add(label);
    }
  }

  // Render edges marking known backedges with color.
  for (var edge in g.edges) {
    final color = edge.isFeedback ? "red" : "black";

    final path = _pathFromPoints(edge.points, color);
    if (edge.source.data.marks.contains("dead")) {
      deadGroup.nodes.add(path);
    } else {
      svg.nodes.add(path);
    }
  }

  // Add SVG root to the pane.
  pane.nodes.add(svg);
  pane.style.width = "${svg.attributes['width']}px";
}

/** Creates draw2d DirectedGraph from the map of blocks */
_toDirectedGraph(blocks) {
  final g = new graph.DirectedGraph();

  // Create a node for each block.
  for (var block in blocks.values) {
    final node = new graph.Node(data: block);
    node.width = node.height = BLOCK_SIZE;
    node.padding = new graph.Insets.round(BLOCK_MARGIN);
    g.nodes.add(node);
  }

  // Create an Edge for each edge. Invert known backedges to help layout
  // algorithm as it will try to break loops heuristically leading to strangely
  // looking control flow graphs.
  for (var from_block in blocks.values) {
    for (var to_block in from_block.successors) {
      final from = from_block.id;
      final to = to_block.id;

      final edge = new graph.Edge(g.nodes[from], g.nodes[to]);
      g.edges.add(edge);

      if (from > to) {
        edge.invert();
        edge.isFeedback = true;
      }
    }
  }

  return g;
}

_layoutDirectedGraph(g) => new graph.DirectedGraphLayout().visit(g);

/**
 * Convert [graph.PointList] into SVG path connecting two graph blocks.
 *
 * The path is finished with an arrowhead.
 */
_pathFromPoints(points, color) {
  var path = ["M", points[0].x, points[0].y];  // Start.

  for (var i = 1; i < points.length - 1; i++) {
    path.addAll(["L", points[i].x, points[i].y]);  // Middle points.
  }

  // Draw an arrow between the last two points.
  final prev = points[points.length - 2];
  final end = points[points.length - 1];

  var x1 = prev.x;
  var y1 = prev.y;
  var x2 = end.x;
  var y2 = end.y;

  // Angle of the vector connecting last two points.
  final angle = math.atan2(y2 - y1, x2 - x1);

  // Angle between the line and arrowhead's line.
  final headAngle = math.PI / 10;

  // Arrowhead's lines vectors.
  var v1_x = 10 * math.cos(angle + headAngle);
  var v1_y = 10 * math.sin(angle + headAngle);

  var v2_x = 10 * math.cos(angle - headAngle);
  var v2_y = 10 * math.sin(angle - headAngle);

  path.addAll(["L", x2, y2,
               "L", (x2 - v1_x), (y2 - v1_y),
               "M", (x2 - v2_x), (y2 - v2_y),
               "L", x2, y2]);

  return _createPath(path, color);
}

/** Create SVG rect element */
_createRect({x, y, width, height, r: 0, fill: "white", stroke}) {
  return new SvgElement.tag('rect')..attributes = {
    "x": "${x}",
    "y": "${y}",
    "width": "${width}",
    "height": "${height}",
    "r": "${r}",
    "rx": "${r}",
    "ry": "${r}",
    "fill": fill,
    "stroke": stroke.color,
    "stroke-width": stroke.width,
    "stroke-opacity": stroke.opacity,
    "stroke-dasharray": stroke.dashArray
  };
}

const _XLINK_NAMESPACE = "http://www.w3.org/1999/xlink";

/** Create SVG text element. If [href] is supplied wrap text in an SVG anchor */
_createLabel({x, y, text, fill: "black", stroke: "black", href}) {
  final label = new SvgElement.tag('text')
      ..attributes = {
        "dominant-baseline": "middle",
        "text-anchor": "middle",
        "x": "${x}",
        "y": "${y}",
        "fill": fill,
        "stroke": stroke
      }
      ..text = text
      ..style.cssText = LABEL_STYLE;

  if (href != null) {
    final ref = new SvgElement.tag("a");
    ref.getNamespacedAttributes(_XLINK_NAMESPACE)["href"] = href;
    ref.nodes.add(label);
    return ref;
  }

  return label;
}

/** Create SVG path element. */
_createPath(path, color) {
  return new SvgElement.tag('path')..attributes = {
    "d": path.map((val) => val is num ? val.toStringAsFixed(3) : val).join(' '),
    "style": "stroke: ${color};",
    "fill": "none"
  };
}

/** Compute loop nesting depth for every block */
List<int> _computeLoopNesting(blocks) {
  final loopNesting = new List.filled(blocks.length, 0);

  final worklist = [];
  for (var block in blocks.values) {
    if (_isLoopHeader(block)) {
      final marked = new List.filled(blocks.length, false);
      loopNesting[block.id]++;
      marked[block.id] = true;

      for (var pred in block.predecessors) {
        if (block.id < pred.id) {
          worklist.add(pred);
        }
        marked[pred.id] = true;
      }

      while (!worklist.isEmpty) {
        final curr = worklist.removeLast();
        loopNesting[curr.id]++;
        for (var pred in curr.predecessors) {
          if (!marked[pred.id]) {
            marked[pred.id] = true;
            worklist.add(pred);
          }
        }
      }
    }
  }

  return loopNesting;
}

_isLoopHeader(block) {
  for (var pred in block.predecessors) {
    if (block.id < pred.id) return true;
  }
  return false;
}

class _Stroke {
  final color;
  final width;
  final opacity;
  final dashArray;

  const _Stroke({this.color: "", this.width: "", this.opacity: "", this.dashArray: ""});
}

_selectStroke(block) {
  if (block.marks.contains("deoptimizes")) {
    return const _Stroke(color: "#8E44AD", width: "4px");
  } else if (block.marks.contains("changes-all")) {
    return const _Stroke(color: "red", width: "3px", dashArray: "10,5");
  } else {
    return const _Stroke(color: "black");
  }
}

/** Palette generated by http://www.colorbrewer2.org/. */
final BREWER_PALETTE = [
  /* "#FFF5F0", "#FEE0D2" ,*/ "#FCBBA1", "#FC9272", "#FB6A4A",
  "#EF3B2C", "#CB181D", "#A50F15", "#67000D"
];

_selectFill(block, hotness) {
  if (block.marks.contains("deoptimizes")) {
    return "white";
  } else if (block.marks.contains("changes-all")) {
    return "white";
  } else {
    final idx = math.min(hotness, BREWER_PALETTE.length) - 1;
    return (hotness == 0) ? "white" : BREWER_PALETTE[idx];
  }
}
