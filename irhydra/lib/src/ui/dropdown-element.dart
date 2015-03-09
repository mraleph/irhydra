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

library dropdown_element;

import 'dart:html' as html;
import 'dart:js' as js;
import 'package:ui_utils/task.dart';
import 'package:polymer/polymer.dart';

@CustomTag('dropdown-element')
class DropdownElement extends PolymerElement {
  @published var selected;
  @observable var valueText;

  var _texts;
  var renderTask;

  selectedChanged(from, to) => renderTask.schedule();

  DropdownElement.created() : super.created() {
    renderTask = new Task(render, frozen: true, type: MICROTASK);
  }

  attached() {
    super.attached();
    js.context['jQuery']['fn']['dropdown'].callMethod('install', [shadowRoot]);

    _texts = new Map.fromIterable(
      (shadowRoot.querySelector("content") as html.ContentElement)
                 .getDistributedNodes()
                 .where((node) => (node is html.Element && node.attributes.containsKey("data-value"))),
      key: (node) => node.attributes["data-value"],
      value: (node) => node.text
    );

    renderTask.unfreeze();
  }

  selectAction(event, detail, target) {
    final attrs = event.target.attributes;
    if (attrs.containsKey('data-value')) {
      selected = attrs['data-value'];
    }
    event.preventDefault();
  }

  render() {
    valueText = _texts[selected];
  }

  detached() {
    js.context['jQuery']['fn']['dropdown'].callMethod('remove', [shadowRoot]);
    super.detached();
  }
}