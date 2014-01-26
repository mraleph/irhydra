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

import 'package:irhydra/src/ui/code-mirror.dart' as code_mirror;
import 'package:js/js.dart' as js;
import 'package:polymer/polymer.dart';

@CustomTag('source-pane')
class SourcePaneElement extends PolymerElement {
  final applyAuthorStyles = true;

  @published var path;
  @observable var source;
  @observable var widgets;

  SourcePaneElement.created() : super.created();

  pathChanged() {
    final currentFunction = path.last;

    source = currentFunction.source.source;

    final inlineWidgets = currentFunction.method.inlined
      .where((f) => currentFunction.contains(f.position))
      .map((f) {
        final span = new html.Element.html('<span><i class="fa fa-chevron-circle-down inline-marker"></i></span>');
        js.context.jQuery(span).tooltip(js.map({
          "title": "View inlined function",
          "placement": "bottom",
          "container": 'body'
        }));
        span.onClick.listen((e) {
          js.context.jQuery(span).tooltip('destroy');
          path.add(f);
        });
        return new code_mirror.Widget(f.position.position, span);
      });

    final deoptWidgets = currentFunction.method.deopts
      .where((deopt) => currentFunction.contains(deopt.srcPos))
      .map((deopt) {
        final span = new html.Element.html('<span><i class="fa fa-exclamation-triangle deopt-bookmark deopt-bookmark-${deopt.type}"></i></span>');
        span.onClick.listen((_) => fire("deopt-click", detail: new DeoptClickDetail(span, deopt)));
        return new code_mirror.Widget(deopt.srcPos.position, span);
      });

    widgets = []..addAll(inlineWidgets)
                ..addAll(deoptWidgets);
  }
}

class DeoptClickDetail {
  final widget;
  final deopt;

  DeoptClickDetail(this.widget, this.deopt);
}