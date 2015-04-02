// Copyright 2015 Google Inc. All Rights Reserved.
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

library saga.util;

intersperseValue(it, val) sync* {
  var comma = false;
  for (var v in it) {
    if (comma) yield val; else comma = true;
    yield v;
  }
}

intersperse(it, f) sync* {
  var comma = false;
  for (var v in it) {
    if (comma) yield f(); else comma = true;
    yield v;
  }
}

intersperseWith(it, f) sync* {
  var i = 0;
  for (var v in it) {
    if (i != 0) {
      yield f(i);
      i++;
    }

    yield v;
    i++;
  }
}

timeAndReport(action, name) {
  final stopwatch = new Stopwatch()..start();
  final result = action();
  print("${name} took ${stopwatch.elapsedMilliseconds} ms.");
  return result;
}

iterate(list) sync* {
  if (list.isEmpty) return;

  for (var curr = list.first, next;
       curr != null;
       curr = next) {
    next = curr.next;
    yield curr;
  }
}