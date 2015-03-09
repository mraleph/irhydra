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

library ui.compilation_timeline;

import 'dart:html';
import 'dart:svg';
import 'package:polymer/polymer.dart';

import 'package:ui_utils/html_utils.dart' show toHtml;
import 'package:irhydra/src/modes/ir.dart' as ir;
import 'package:ui_utils/xref.dart' as xref;

@CustomTag('compilation-timeline')
class CompilationTimeline extends PolymerElement {
  @published List events;

  CompilationTimeline.created() : super.created();

  eventsChanged() {
    shadowRoot.nodes.clear();

    if (events == null) {
      return;
    }

    final methods = new Map<String, ir.Method>
        .fromIterable(events.where((ev) => ev is ir.Method),
                      key: (ir.Method m) => m.optimizationId,
                      value: (ir.Method m) => m);
    final targets = <String, List<int>>{};

    for (var i = 0; i < events.length; i++) {
      targets.putIfAbsent(events[i].optimizationId, () => [])
             .add(i);
    }

    const R = 5;
    const DX = R * 6;
    const Y0 = R * 3;
    const STROKE = const ["black", "red", "orange"];

    final svg = new SvgSvgElement();

    svg.nodes.add(_line(x1: 0, y1: Y0, x2: events.length * DX, y2: Y0));

    var x = R * 2;
    var circles;

    final ref = new xref.XRef((ev) {
      if (ev is ir.Method) {
        return "${ev.name.full}";
      } else if (ev is ir.Deopt) {
        return toHtml(new DivElement()
          ..nodes.addAll([
            new HeadingElement.h3()
              ..text = "${methods[ev.optimizationId].name.full} deopt",
            new PreElement()
              ..text = ev.raw.join('\n')]));
      }
    });

    final clicked = new List.filled(events.length, false);

    event(ev) {
      final c = _circle(cx: x, cy: Y0, r: R, stroke: _strokeFor(ev));
      svg.nodes.add(c);

      c.onClick.listen((_) {
        targets[ev.optimizationId].forEach((idx) {
          clicked[idx] = !clicked[idx];
          final f = clicked[idx] ? 2 : 1;
          circles[idx].attributes["r"] = "${f * R}";
        });
      });

      c.onMouseEnter.listen((_) {
        ref.show(c, ev);
        targets[ev.optimizationId].forEach((idx) {
          circles[idx].attributes["r"] = "${2 * R}";
        });
      });

      c.onMouseLeave.listen((_) {
        ref.hide();
        targets[ev.optimizationId].forEach((idx) {
          final f = clicked[idx] ? 2 : 1;
          circles[idx].attributes["r"] = "${f * R}";
        });
      });

      x += DX;

      return c;
    }

    circles = events.map(event).toList();

    svg.attributes['width'] = "${x}";
    svg.attributes['height'] = "${R * 6}";

    shadowRoot.nodes.add(svg);
  }
}

_strokeFor(ev) {
  if (ev is ir.Method) {
    return "black";
  } else if (ev is ir.Deopt) {
    switch (ev.type) {
      case "lazy":
        return "#F39C12";
      case "soft":
        return "#8E44AD";
      case "eager":
      default:
        return "#C0392B";
    }
  }
}

_line({x1, y1, x2, y2}) =>
  new LineElement()..attributes = {
    "x1": "${x1}", "y1": "${y1}",
    "x2": "${x2}", "y2": "${y2}",
    "stroke": "black",
  };

_circle({cx, cy, r, stroke}) =>
  new CircleElement()..attributes = {
    "cx": "${cx}", "cy": "${cy}", "r": "${r}",
    "stroke": stroke,
    "fill": stroke
  };

_indexOf(list, p) {
  var idx = 0;
  for (var el in list) {
    if (p(el)) return idx;
    idx++;
  }
  return null;
}
