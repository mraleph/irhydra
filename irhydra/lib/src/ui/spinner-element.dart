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

library spinner_element;

import 'dart:js' as js;
import 'package:polymer/polymer.dart';

/**
 * Primitive tabbed pane WebComponent.
 */
@CustomTag('spinner-element')
class SpinnerElement extends PolymerElement {
  js.JsObject _spinner;

  SpinnerElement.created() : super.created();

  /** Start spinner. */
  start() {
    stop();  // Ensure that spinner is stopped.

    final opts = new js.JsObject.jsify({
      "lines": 13, // The number of lines to draw
      "length": 7, // The length of each line
      "width": 4, // The line thickness
      "radius": 8, // The radius of the inner circle
      "corners": 1, // Corner roundness (0..1)
      "rotate": 0, // The rotation offset
      "color": '#fff', // #rgb or #rrggbb
      "speed": 1, // Rounds per second
      "trail": 60, // Afterglow percentage
      "shadow": false, // Whether to render a shadow
      "hwaccel": false, // Whether to use hardware acceleration
      "className": 'spinner', // The CSS class to assign to the spinner
      "zIndex": 2e9, // The z-index (defaults to 2000000000)
      "top": '0px', // Top position relative to parent in px
      "left": '0px' // Left position relative to parent in px
    });
    _spinner = new js.JsObject(js.context['Spinner'], [opts]).callMethod('spin', [this]);
  }

  /** Stop spinner. */
  stop() {
    if (_spinner != null) {
      _spinner.callMethod('stop');
      _spinner = null;
    }
  }
}