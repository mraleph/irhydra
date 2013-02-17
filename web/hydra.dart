// Copyright 2013 Google Inc. All Rights Reserved.
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

import "dart:async" as async;
import "dart:html" as html;
import "dart:uri";

import "package:irhydra/src/modes/v8/v8.dart" as v8;
import "package:irhydra/src/modes/dartvm/dartvm.dart" as dartvm;

import "package:js/js.dart" as js;

import "package:web_ui/watcher.dart" as watchers;

/** All supported modes. */
final MODES = [new dartvm.Mode(), new v8.Mode()];

/** Currently active mode. */
var currentMode;

/** Methods that were recovered from parsed compilation artifacts. */
var methods = [];

/** Currently displayed phase. */
var currentPhase;

/** Display given phase using active mode. */
displayPhase(method, phase) {
  currentPhase = phase;
  watchers.dispatch();  // Notify web_ui.
  currentMode.displayPhase(method, phase);
}

/** Load data from the given textual artifact if any mode can handle it. */
loadData(text) {
  // Select mode that can handle it.
  currentMode = null;
  for (var mode in MODES) {
    if (mode.canRecognize(text)) {
      currentMode = mode;
      break;
    }
  }

  // Parse and notify web_ui.
  methods = currentMode.parse(text);
  watchers.dispatch();
}

main () {
  // Connect file input and "Open IR" button.
  html.InputElement compilation_artifact = html.query('#compilation-artifact');
  compilation_artifact.onChange.listen((event) {
    for (var file in compilation_artifact.files) {
      final reader = new html.FileReader();
      reader.onLoad.listen((e) => loadData(reader.result));
      reader.readAsText(file);
    }
  });

  html.query("#open-compilation-artifact").onClick.listen((event) {
    js.scoped(() {
      js.context.jQuery(compilation_artifact).click();
    });
  });

  // Listen for onHashChange events to allow cross-references between ir and
  // graph tabs.
  html.window.onHashChange.listen((e) {
    final from = new Uri(e.oldUrl).fragment;
    final to = new Uri(e.newUrl).fragment;

    // If we are on the same tab then there is nothing to do.
    if (from == to ||
        from.startsWith("ir") == to.startsWith("ir") ||
        from.startsWith("graph") == to.startsWith("graph")) {
      return;
    }

    // Activate the tab.
    final tabs = html.document.query("#tabs").xtag;
    if (to.startsWith("ir")) {
      tabs.switchTo("ir");
    } else if (to.startsWith("graph")) {
      tabs.switchTo("graph");
    }

    // Scroll to the now visible anchor.
    final anchor = html.document.query("a[name='$to']");
    if (anchor != null) {
      anchor.scrollIntoView();
    }

    watchers.dispatch();  // Notify web_ui to keep tabs state in sync.
  });
}
