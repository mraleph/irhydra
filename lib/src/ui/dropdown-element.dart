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

import 'package:js/js.dart' as js;
import 'package:polymer/polymer.dart';

/**
 * Primitive tabbed pane WebComponent.
 */
@CustomTag('dropdown-element')
class DropdownElement extends PolymerElement {
  final applyAuthorStyles = false;

  @published var value;
  @observable var valueText;

  var _texts;

  valueChanged() {
    valueText = _texts[value];
  }

  DropdownElement.created() : super.created();

  enteredView() {
    super.enteredView();
    js.context.jQuery.fn.dropdown.install(shadowRoot);

    _texts = new Map.fromIterable(
      shadowRoot.querySelector("content")
                .getDistributedNodes()
                .where((node) => node is! html.Text)
                .map((node) => node.querySelector("[data-value]")),
      key: (node) => node.attributes["data-value"],
      value: (node) => node.text
    );
  }

  selectAction(event, detail, target) {
    if (event.target.attributes.containsKey('data-value')) {
      value = event.target.attributes['data-value'];
      fire("changed", detail: value);
    }
  }

  leftView() {
    js.context.jQuery.fn.dropdown.remove(shadowRoot);
    super.leftView();
  }
}