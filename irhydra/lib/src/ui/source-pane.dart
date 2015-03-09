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

library source_pane;

import 'dart:html' as html;

import 'package:ui_utils/bootstrap.dart' as bs;
import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:irhydra/src/ui/util/code-mirror/code-mirror.dart' as code_mirror;
import 'package:polymer/polymer.dart';

@CustomTag('source-pane')
class SourcePaneElement extends PolymerElement {
  @published var path;
  @observable var source;
  @observable var widgets;
  @observable var lineClasses;

  var _pendingScroll;

  get currentFunction => path.last;

  SourcePaneElement.created() : super.created();

  scrollTo(deopt, delayed) {
    _pendingScroll = new _PendingScroll(deopt.srcPos, delayed);
    if (!delayed && currentFunction.contains(deopt.srcPos)) {
      executePendingScroll(force: true);
    }
  }

  executePendingScroll({force: false}) {
    if (_pendingScroll != null) {
      final scroll = _pendingScroll;
      _pendingScroll = null;

      if (currentFunction.contains(scroll.position)) {
        ($["editor"] as code_mirror.CodeMirrorElement).scrollTo(
          scroll.position.position, scroll.delayed, force: force);
      }
    }
  }

  pathChanged() {
    if (path.isEmpty) {
      source = [];
      widgets = [];
      return;
    }

    source = currentFunction.source.source;
    executePendingScroll();
    final inlineWidgets = currentFunction.method.inlined
      .where((f) => currentFunction.contains(f.position))
      .map((f) {
        final span = new html.Element.html('<span><i class="fa fa-chevron-circle-down inline-marker"></i></span>');
        bs.tooltip(span, {
          "title": "View inlined function",
          "placement": "bottom",
          "container": 'body',
          "trigger": "hover click",
        });
        span.onClick.listen((e) {
          path.add(f);
        });
        return new code_mirror.Widget(f.position.position, span);
      });

    final deoptWidgets = currentFunction.method.deopts
      .where((deopt) => currentFunction.contains(deopt.srcPos))
      .map((deopt) {
        final span = new html.Element.html('<span><i class="fa fa-warning deopt-bookmark deopt-bookmark-${deopt.type}"></i></span>');
        span.onMouseEnter.listen((_) => fire("deopt-enter", detail: new DeoptHoverDetail(deopt, span)));
        span.onMouseLeave.listen((_) => fire("deopt-leave", detail: new DeoptHoverDetail(deopt, span)));
        return new code_mirror.Widget(deopt.srcPos.position, span);
      });

    widgets = []..addAll(inlineWidgets)
                ..addAll(deoptWidgets);

    // Annotate lines.
    lineClasses = const [];
    if (currentFunction.annotations != null) {
      lineClasses = [];
      for (var i = 0; i < currentFunction.annotations.length; i++) {
        switch (currentFunction.annotations[i]) {
          case IR.LINE_DEAD:
            lineClasses.add(new code_mirror.LineClass(i, "line-dead"));
            break;
          case IR.LINE_LICM:
            lineClasses.add(new code_mirror.LineClass(i, "line-licm"));
            break;
        }
      }
    }
  }
}

class DeoptHoverDetail {
  final deopt;
  final target;

  DeoptHoverDetail(this.deopt, this.target);
}

class _PendingScroll {
  final position;
  final delayed;

  _PendingScroll(this.position, this.delayed);
}