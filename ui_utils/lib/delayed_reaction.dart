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

/// Scheduling actions with a delay.
library;

import 'dart:async';

/// Utility class that allows to schedule an action callback with a fixed delay.
/// Scheduling an action before scheduled one fired evicts pending action.
class DelayedReaction {
  /// Default delay
  static const Duration defaultDelay = Duration(milliseconds: 500);

  final Duration delay;

  /// Timer for the currently pending action.
  Timer? timer;

  DelayedReaction({this.delay = defaultDelay});

  /// Schedule an [action] callback. If there is already an action pending
  /// it will be evicted.
  schedule(action) => _setTimer(Timer(delay, () => action()));

  /// Cancel pending action if any.
  cancel() => _setTimer(null);

  /// Replace the currently pending timer.
  void _setTimer(Timer? newTimer) {
    timer?.cancel();
    timer = newTimer;
  }
}
