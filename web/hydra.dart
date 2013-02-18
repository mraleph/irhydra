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

import "package:irhydra/src/modes/dartvm/dartvm.dart" as dartvm;
import "package:irhydra/src/modes/v8/v8.dart" as v8;
import "package:irhydra/src/spinner.dart" as spinner;

import "package:js/js.dart" as js;

import "package:web_ui/watcher.dart" as watchers;

/** All supported modes. */
final MODES = [new dartvm.Mode(), new v8.Mode()];

/** Currently loaded set of files. */
var currentFiles;

/** Currently active mode. */
var currentMode;

/** Methods that were recovered from parsed compilation artifacts. */
var methods = [];

/** Currently displayed phase. */
var currentPhase;

/** Resets state to the initial empty one. */
resetUI() {
  currentMode = currentPhase = null;
  methods = [];
  watchers.dispatch();  // Notify web_ui.
}

/** Returns names of currently loaded files. */
currentFileNames() =>
  currentFiles.map((file) => file.name).join(', ');

/** Reloads set of files. */
reloadCurrentFiles() {
  resetUI();
  for (var file in currentFiles) {
    final reader = new html.FileReader();
    reader.onLoad.listen((e) => loadData(reader.result));
    reader.readAsText(file);
  }
}

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

/** Load compilation artifact from the remote location with a [HttpRequest]. */
loadUrl(url) =>
  html.HttpRequest.getString(url).then(loadData);

/** Available demos. Files expected to reside in demos/ directory. */
const DEMO_FILES = const {
  "demo-1": const ["1.v8.hydrogen.cfg", "1.v8.code.asm"]
};

/** Load demo files for the given [demoId]. */
loadDemo(demoId) {
  if (DEMO_FILES.containsKey(demoId)) {
    final files = DEMO_FILES[demoId].map((file) => "demos/$file");
    spinner.start();
    async.Future.forEach(files, loadUrl).whenComplete(spinner.stop);
  }
}

main () {
  // Connect file input and "Open IR" button.
  html.InputElement compilation_artifact = html.query('#compilation-artifact');
  compilation_artifact.onChange.listen((event) {
    currentFiles = compilation_artifact.files;
    reloadCurrentFiles();
  });

  html.query("#open-compilation-artifact").onClick.listen((event) {
    html.query("#compilation-artifact-form").reset();
    js.scoped(() {
      js.context.jQuery(compilation_artifact).click();
    });
  });

  // Listen for onHashChange events to allow cross-references between ir and
  // graph tabs.
  html.window.onHashChange.listen((e) {
    final from = new Uri(e.oldUrl).fragment;
    final to = new Uri(e.newUrl).fragment;

    if (to.startsWith("demo-")) {
      loadDemo(to);
      return;
    }

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

  final currentFragment = new Uri(html.window.location.href).fragment;
  if (currentFragment.startsWith("demo-")) {
    // Wait until web_ui is fully initialized.
    new async.Timer(const Duration(milliseconds: 10), (timer) {
      loadDemo(currentFragment);
    });
  }
}
