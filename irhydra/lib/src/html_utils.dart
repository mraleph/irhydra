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

/** Simple helpers for HTML building. */
library html_utils;

import 'dart:html';

/** Wrap [text] into a [SpanElement] with the given [klass]. */
span(String klass, String text) =>
  new SpanElement()..classes.add(klass)..appendText(text);

/** Escape special HTML characters in the given [text] string. */
escapeHtml(String text) =>
  (new SpanElement()..appendText(text)).innerHtml;

/** Get HTML representation of the given [Element] [e]. */
toHtml(Element e) {
  final parent = e.parent;
  if (parent != null && parent.nodes.length == 1) {
    return parent.innerHtml;
  }
  final insertable = parent == null ? e : e.clone(true);
  return (new DivElement()..append(insertable)).innerHtml;
}