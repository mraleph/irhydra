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

/// Compute interference graph.
library saga.flow.interference;

import 'dart:math' as math;

import 'package:saga/src/flow/liveness.dart' as liveness;

class Edge {
  final from;
  final to;

  Edge(from, to) : from = math.min(from, to), to = math.max(from, to);

  toString() => "(${from}, ${to})";

  operator==(other) => from == other.from && to == other.to;
  get hashCode => from ^ to;
}

reversed(list) sync* {
  if (list.isEmpty) return;

  for (var node = list.last; node != null; node = node.previous) {
    yield node;
  }
}

build(blocks) {
  final stopwatch = new Stopwatch()..start();
  final liveOutSets = liveness.build(blocks);

  final interference = new Set();
  final alive = new liveness.NodeSet();
  for (var block in blocks) {
    alive.setFrom(liveOutSets[block.id]);

    for (var node in reversed(block.code)) {
      for (var live in alive) {
        if (live != node.id) interference.add(new Edge(node.id, live));
      }
      alive.remove(node);
      for (var input in node.inputs) {
        if (input.def != null) alive.add(input.def);
      }
    }

    for (var node in block.phis) {
      for (var live in alive) {
        if (live != node.id) interference.add(new Edge(node.id, live));
      }
    }
  }

  print("interference graph has ${interference.length} edges, took ${stopwatch.elapsedMilliseconds} ms to build.");

  return interference;
}