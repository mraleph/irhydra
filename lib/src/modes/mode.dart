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

/** Base mode related functionality */
library mode;

import 'dart:html' as html;

import 'package:irhydra/src/modes/code.dart' show CodeSplicer;
import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:irhydra/src/modes/llprof.dart' as llprof;

/**
 * Modes encapsulate the way to parse and display compilation artifacts.
 *
 * Individual modes don't have to inherit from [BaseMode] but must implement
 * at least [canRecognize], [parse], [displayMethod] methods.
 *
 * [BaseMode] exists to provide some common infrastructure to support choice
 * of code rendering mode.
 */
abstract class BaseMode {
  /** Currently displayed IR. */
  var ir;

  /** Currently displayed code. */
  var _code;

  /** Ticks information for the currently displayed code. */
  var ticks;

  /** Aggregated ticks information for each block. */
  var blockTicks;

  /** Profiling data. */
  var profile;

  /** Determines if the mode can recognize and handle given textual artifact. */
  bool canRecognize(String text);

  /** Parses textual artifact into the list of [IR.Method] */
  List<IR.Method> parse(String text);

  /** Load output of the llprof.py script. */
  loadProfile(data) {
    //llprof.parse(data);
  }
}
