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

library ui.util.switching_scope;

import 'dart:html';
import 'package:ui_utils/task.dart';
import 'package:polymer/polymer.dart';

/**
 * A component that applies `active` class to any distributed child that
 * has `when-x` attribute where `x` matches current [active] value.
 */
@CustomTag('switching-scope')
class SwitchingScope extends PolymerElement {
  @published var active;

  var renderTask;

  SwitchingScope.created() : super.created() {
    renderTask = new Task(render, frozen: true, type: MICROTASK);
  }

  attached() {
    super.attached();
    renderTask.unfreeze();
  }

  activeChanged() => renderTask.schedule();

  render() {
    for (var e in _query(".active")) {
      e.classes.remove("active");
    }

    for (var e in _query("[when-$active]")) {
      e.classes.add("active");
    }

    document.dispatchEvent(new CustomEvent("DisplayChanged"));
  }

  _query(sel) => (shadowRoot.querySelector("content") as ContentElement)
                            .getDistributedNodes()
                            .where((n) => n is Element && n.matches(sel));
}