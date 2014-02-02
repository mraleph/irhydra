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

library task;

import 'dart:async';

const MICROTASK = const _TypeMicrotask();
const TASK = const _TypeTask();

/** Simple one time task. */
class Task {
  var type;
  final _callback;
  var _scheduled = false;

  var frozen;

  Task(this._callback, {this.frozen: false, this.type: TASK});

  /**
   * Schedule execution of the callback in the microtask queue.
   * If the task is already scheduled does nothing.
   */
  schedule() {
    if (!_scheduled && !frozen) {
      type.schedule(_execute);
      _scheduled = true;
    }
  }

  unfreeze() {
    frozen = false;
    schedule();
  }

  _execute() {
    _scheduled = false;
    _callback();
  }
}

class _TypeMicrotask {
  const _TypeMicrotask();
  schedule(cb) => scheduleMicrotask(cb);
}

class _TypeTask {
  const _TypeTask();
  schedule(cb) => new Timer(const Duration(milliseconds: 1), cb);
}
