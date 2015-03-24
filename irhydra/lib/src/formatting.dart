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

/**
 * Turn text into HTML elements by applying formatting rules to regular
 * expression matches.
 */
library formatting;

import 'dart:html';
import 'package:ui_utils/parsing.dart' as parsing;

/** Formatting function that turns text into HTML element based on some rules */
typedef Element Formatter(String text);

/**
 * Make a formatter for the given [map] of rules.
 *
 * Each rule is a pair of regular expression and an associated formatter that
 * will be applied to regular expression's match. Regular expression will not
 * be tried for a match in the middle of the word.
 *
 * Parts of text that do not match any rule will be wrapped into [Text].
 */
makeFormatter(Map<String, Formatter> map) {
  final actions = map.values.toList();
  final patterns = map.keys.map((re) => new RegExp("^${re}")).toList();

  final split = parsing.makeSplitter(map, other: (val) => new Text(val));

  return (text) =>
    new SpanElement()..nodes.addAll(split(text));
}

