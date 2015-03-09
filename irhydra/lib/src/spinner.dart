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

/** Simple wrapper around spin.js that creates spinner at navbar. */
library spinner;

import "dart:html" as html;
import "dart:js" as js;

/** Current instance of spinner. */
js.JsObject _spinner;

/** Start spinner. */
start() {
  stop();  // Ensure that spinner is stopped.

  final target = html.document.querySelector(".navbar-inner > .container");
  final opts = new js.JsObject.jsify({
    "lines": 13, // The number of lines to draw
    "length": 7, // The length of each line
    "width": 4, // The line thickness
    "radius": 8, // The radius of the inner circle
    "corners": 1, // Corner roundness (0..1)
    "rotate": 0, // The rotation offset
    "color": '#000', // #rgb or #rrggbb
    "speed": 1, // Rounds per second
    "trail": 60, // Afterglow percentage
    "shadow": false, // Whether to render a shadow
    "hwaccel": false, // Whether to use hardware acceleration
    "className": 'spinner', // The CSS class to assign to the spinner
    "zIndex": 2e9, // The z-index (defaults to 2000000000)
    "top": 'auto', // Top position relative to parent in px
    "left": 'auto' // Left position relative to parent in px
  });
  _spinner = new js.JsObject(js.context['Spinner'], [opts]).callMethod('spin', [target]);
}

/** Stop spinner. */
stop() {
  if (_spinner != null) {
    _spinner.callMethod('stop');
    _spinner = null;
  }
}
