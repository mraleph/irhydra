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

library code_mirror;

import 'package:js/js.dart' as js;
import 'package:polymer/polymer.dart';
import 'dart:html' as html;

class Widget {
  final position;
  final element;

  Widget(this.position, this.element);
}

/**
 * Primitive tabbed pane WebComponent.
 */
@CustomTag('code-mirror')
class CodeMirrorElement extends PolymerElement {
  final applyAuthorStyles = true;

  CodeMirrorElement.created() : super.created();

  var _instance;

  @published var lines;
  var _lines;

  @published List<Widget> widgets;
  List<_Widget> _widgets = const <_Widget>[];

  linesChanged() {
    _lines = lines.toList();

    if (_instance != null) {
      _instance.setValue(_lines.join('\n'));
    }
  }

  _toWidget(Widget w) {
    var line = 0;
    var ch = w.position;
    while ((line < _lines.length) && (ch > _lines[line].length)) {
      ch -= _lines[line].length + 1;
      line++;
    }

    print("_Widget($line, $ch, ${w.element})");
    return new _Widget(line, ch, w.element);
  }

  widgetsChanged() {
    print("widgetsChanged ${widgets}");
    _widgets.forEach((w) => w.remove());
    _widgets = widgets.map(_toWidget).toList();
    _widgets.forEach((w) => w.insertInto(_instance));
  }

  enteredView() {
    super.enteredView();
    _instance = js.context.CodeMirror($["editor"], js.map({"readOnly": true}));

    if (_lines != null)
      _instance.setValue(_lines.join('\n'));

    html.document.addEventListener("DisplayChanged", (_) => _refresh(), false);
  }

  _refresh() {
    _instance.refresh();
    _widgets.forEach((w) => w.remove());
    _widgets.forEach((w) => w.insertInto(_instance));
  }

  leftView() {
    _instance = null;
    super.leftView();
  }
}

class _Widget {
  final line;
  final ch;
  final element;

  var _bookmark;

  _Widget(this.line, this.ch, this.element);

  insertInto(cm) {
    final pos = js.map({"line": line, "ch": ch});
    _bookmark = cm.setBookmark(pos, js.map({"widget": element}));
  }
  remove() {
    if (_bookmark != null) {
      _bookmark.clear();
      _bookmark = null;
    }
  }
}