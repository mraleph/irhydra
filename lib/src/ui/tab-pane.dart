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

library tab_pane;

import 'dart:html';

import 'package:polymer/polymer.dart';

/**
 * Primitive tabbed pane WebComponent.
 */
@CustomTag('tab-pane')
class TabPane extends PolymerElement {
  // get applyAuthorStyles => true;

  /** List of tab bodies */
  @observable var tabs;

  /** Currently active tab */
  String _activeTab;

  var _panes;

  TabPane.created() : super.created();

  enteredView() {
    super.enteredView();
    _panes = $['tabs'].getDistributedNodes()
                      .where((e) => e is DivElement)
                      .toList();

    tabs = _panes.map((e) => new Tab(e.attributes['data-href'],
                                     e.attributes['data-title']))
                 .toList();
    if (!tabs.isEmpty) activeTab = tabs.first.href;
  }

  @observable get activeTab => _activeTab;
  set activeTab (tab) {
    _activeTab = notifyPropertyChange(const Symbol("activeTab"), _activeTab, tab);
    _panes.forEach((pane) => pane.style.display = _displayStyle(pane));

    for (var node in $['after-tabs'].getDistributedNodes()) {
      if (node.attributes.containsKey("data-when")) {
        final visible = node.attributes["data-when"].split("|").contains(_activeTab);
        node.style.display = visible ? "inline" : "none";
      }
    }

    document.dispatchEvent(new CustomEvent("DisplayChanged"));
  }

  switchTabAction(event, detail, target) {
    switchTo(target.attributes["data-target"]);
  }

  /** Switch to the tab that has `data-href` equal to the given [href]. */
  switchTo(href) {
    activeTab = href;
  }

  /** Compute display property value for the given tab [pane] */
  _displayStyle(pane) => (pane.attributes["data-href"] == activeTab) ? "block" : "none";
}

@observable
class Tab {
  final href;
  final title;
  Tab(this.href, this.title);
}
