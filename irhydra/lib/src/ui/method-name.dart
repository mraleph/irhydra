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

library ui.method_name;

import 'package:polymer/polymer.dart';

@CustomTag('method-name')
class MethodName extends PolymerElement {
  @published var method;
  @published var demangle = true;
  @published var targetHref;

  MethodName.created() : super.created();

  @ComputedProperty("demangle")
  get source => demangle ? method.name.source : null;

  @ComputedProperty("demangle")
  get name => demangle ? method.name.display : method.name.full;
}