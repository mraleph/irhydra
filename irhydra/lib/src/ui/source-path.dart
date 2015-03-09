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

library source_path;

import 'package:polymer/polymer.dart';

@CustomTag('source-path')
class SourcePathElement extends PolymerElement {
  @published var path;
  @observable var isEmpty;

  SourcePathElement.created() : super.created();

  switchAction(event, detail, target) {
    final index = int.parse(target.attributes["data-target"]);
    path.removeRange(index + 1, path.length);
    event.preventDefault();
  }
}