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
import 'package:irhydra/src/task.dart';
import 'package:polymer/polymer.dart';

/**
 * Primitive tabbed pane WebComponent.
 */
@CustomTag('tab-pane')
class TabPane extends PolymerElement {
  @published var disabled = {};

  /** List of tab bodies */
  @observable var tabs;

  /** Currently active tab */
  String _activeTab;

  var _panes;

  var renderTask;

  TabPane.created() : super.created() {
    renderTask = new Task(render, frozen: true, type: MICROTASK);
  }

  enteredView() {
    super.enteredView();
    _panes = $['tabs'].getDistributedNodes()
                      .where((e) => e is DivElement)
                      .toList();

    tabs = _panes.map((e) => new Tab(e.attributes['data-href'],
                                     e.attributes['data-title']))
                 .toList();
    if (!tabs.isEmpty) activeTab = tabs.first.href;

    renderTask.unfreeze();
  }

  @observable get activeTab => _activeTab;
  set activeTab (tab) {
    _activeTab = notifyPropertyChange(const Symbol("activeTab"), _activeTab, tab);
    renderTask.schedule();
  }

  disabledChanged() => renderTask.schedule();

  switchTabAction(event, detail, target) {
    activeTab = target.attributes["data-target"];
  }

  render() {
    if (tabs == null) {
      return;
    }

    for (var tab in tabs) tab.isDisabled = _isDisabled(tab.href);

    final active = tabs.firstWhere((tab) => tab.href == activeTab);
    if (active.isDisabled) {
      activeTab = tabs.firstWhere((tab) => !_isDisabled(tab.href)).href;
    }

    _panes.forEach((pane) => pane.style.display = _displayStyle(pane));

    for (var node in $['after-tabs'].getDistributedNodes()) {
      if (node.attributes.containsKey("data-when")) {
        final visible = node.attributes["data-when"].split("|").contains(_activeTab);
        node.style.display = visible ? "inline" : "none";
      }
    }

    document.dispatchEvent(new CustomEvent("DisplayChanged"));
  }

  /** Compute display property value for the given tab [pane] */
  _displayStyle(pane) => (pane.attributes["data-href"] == activeTab) ? "block" : "none";

  _isDisabled(href) => disabled[href] == true;
}

class Tab extends Observable {
  @observable final href;
  @observable final title;
  @observable var isDisabled = false;

  Tab(this.href, this.title);
}
