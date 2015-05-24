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

library modes.v8.name_parser;

import 'package:irhydra/src/modes/ir.dart' show Name;

Name parse(String text) {
  if (text.indexOf(r"$") < 0) {
    return new Name.fromFull(text);
  }

  if (text.length > 1 &&
      text.startsWith(r"$") &&
      text.endsWith(r"$")) {
    text = text.substring(1, text.length - 1);
  }

  final lastIdx = text.lastIndexOf(r"$");
  if (lastIdx == 0 || lastIdx == text.length - 1) {
    return new Name.fromFull(text);
  }

  final source = text.substring(0, lastIdx - ((text[lastIdx - 1] == r"$") ? 1 : 0));
  final short = text.substring(lastIdx + 1);

  return new Name(text, source.replaceAll(r"$", "."), short);
}
