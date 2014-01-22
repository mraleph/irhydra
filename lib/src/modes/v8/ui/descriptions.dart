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

library descriptions;

import 'package:polymer/polymer.dart';

/**
 * A list of HIR/LIR insruction descriptions.
 *
 * Described as a polymer element for the sole purpose of storing it
 * modularly.
 */
@CustomTag('ir-descriptions-v8')
class Descriptions extends PolymerElement {
  Descriptions.created() : super.created();

  lookup(ns, opcode) {
    final elem = shadowRoot.querySelector("div[data-$ns=$opcode]");
    return (elem != null) ? elem.innerHtml : null;
  }
}
