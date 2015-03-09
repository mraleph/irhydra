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

import 'dart:js' as js;
import 'package:ui_utils/task.dart';
import 'package:polymer/polymer.dart';
import 'dart:html' as html;

class Widget {
  final position;
  final element;

  Widget(this.position, this.element);

  toString() => "${element} @ ${position}";
}

class LineClass {
  final lineNum;
  final className;

  LineClass(this.lineNum, this.className);
}

/**
 * Primitive tabbed pane WebComponent.
 */
@CustomTag('code-mirror')
class CodeMirrorElement extends PolymerElement {
  CodeMirrorElement.created() : super.created() {
    renderTask = new Task(render, frozen: true);
  }

  js.JsObject _instance;

  @published var lines = [];
  var _lines;

  @published List<Widget> widgets = [];
  List<_Widget> _widgets = const <_Widget>[];

  @published var lineClasses = [];
  var _appliedLineClasses = [];

  var _pendingScroll;
  var _pendingScrollDelayed;

  var _refresher;

  var renderTask;

  attached() {
    super.attached();
    _instance = js.context.callMethod('CodeMirror', [$["editor"], new js.JsObject.jsify({"readOnly": true})]);
    _instance.callMethod('setSize', [null, 600]);
    _refresher = (_) => _refresh();

    html.document.addEventListener("DisplayChanged", _refresher, false);
    renderTask.unfreeze();
  }

  linesChanged() => renderTask.schedule();
  widgetsChanged() => renderTask.schedule();

  scrollTo(position, delayed, {force: false}) {
    _pendingScroll = position;
    _pendingScrollDelayed = delayed;
    if (force) {
      _executePendingScroll(forceRefresh: true);
    }
  }

  _executePendingScroll({forceRefresh: false}) {
    if (forceRefresh) {
      _instance.callMethod('refresh');
    }
    _instance.callMethod('scrollIntoView', [_toCMPosition(_pendingScroll)]);
    _pendingScroll = null;
  }

  _toCMPosition(offset) {
    var line = 0, ch = offset;
    while ((line < _lines.length) && (ch > _lines[line].length)) {
      ch -= _lines[line].length + 1;
      line++;
    }
    return new js.JsObject.jsify({"line": line, "ch": ch});
  }

  _toWidget(Widget w) =>
    new _Widget(_toCMPosition(w.position), w.element);

  render() {
    _appliedLineClasses.forEach((handle) => _instance.callMethod('removeLineClass', [handle, "wrap"]));
    _lines = lines.toList();
    _instance.callMethod('setValue', [_lines.join('\n')]);
    _widgets.forEach((w) => w.remove());
    _widgets = widgets.map(_toWidget).toList();
    _widgets.forEach((w) => w.insertInto(_instance));
    _appliedLineClasses = lineClasses.map((line) => _instance.callMethod('addLineClass', [line.lineNum, "wrap", line.className])).toList();

    if (_pendingScroll != null && !_pendingScrollDelayed) {
      _executePendingScroll(forceRefresh: true);
    }
  }

  _refresh() {
    _instance.callMethod('refresh');
    _widgets.forEach((w) => w.remove());
    _widgets.forEach((w) => w.insertInto(_instance));
    if (_pendingScroll != null) {
      _executePendingScroll();
    }
  }

  detached() {
    _instance = null;
    html.document.removeEventListener("DisplayChanged", _refresher, false);
    super.detached();
  }
}

class _Widget {
  final position;
  final element;

  var _bookmark;

  _Widget(this.position, this.element);

  insertInto(js.JsObject cm) {
    _bookmark = cm.callMethod('setBookmark', [position, new js.JsObject.jsify({"widget": element})]);
  }

  remove() {
    if (_bookmark != null) {
      _bookmark.callMethod('clear');
      _bookmark = null;
    }
  }
}