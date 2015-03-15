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

library flow.liveness;

import 'package:saga/src/flow/node.dart';

import 'dart:typed_data';

class NodeSet {
  final Int32List data;

  NodeSet() : data = new Int32List(lengthFor(Node.maxId));

  static const cellShift = 5;
  static const indexMask = (1 << cellShift) - 1;

  add(Node n) {
    final bit = n.id;
    final cellIndex = bit >> cellShift;
    final bitIndex = bit & indexMask;
    data[cellIndex] |= 1 << bitIndex;
  }

  remove(Node n) {
    final bit = n.id;
    final cellIndex = bit >> cellShift;
    final bitIndex = bit & indexMask;
    data[cellIndex] &= ~(1 << bitIndex);
  }

  contains(Node n) {
    final bit = n.id;
    final cellIndex = bit >> cellShift;
    final bitIndex = bit & indexMask;
    return (data[cellIndex] & (1 << bitIndex)) != 0;
  }

  setFrom(NodeSet from) {
    for (var i = 0; i < data.length; i++) {
      data[i] |= from.data[i];
    }
  }

  addAll(NodeSet from) {
    for (var i = 0; i < data.length; i++) {
      data[i] |= from.data[i];
    }
  }

  addAllWithout(NodeSet from, NodeSet killing) {
    var changed = 0;
    for (var i = 0; i < data.length; i++) {
      final val = data[i];
      final newval = val | (from.data[i] & ~killing.data[i]);
      changed |= val ^ newval;
      data[i] = newval;
    }
    return changed != 0;
  }

  clear() {
    for (var i = 0; i < data.length; i++) data[i] = 0;
  }

  asIterable() sync* {
    for (var i = 0; i < data.length; i++) {
      final val = data[i];
      if (val == 0) continue;
      for (var j = 0; j <= indexMask; j++) {
        if (val & (1 << j) != 0) yield ((i << cellShift) + j);
      }
    }
  }

  get iterator => asIterable().iterator;

  toString() {
    var result = [];
    for (var i in this) result.add("v$i");
    return result.toString();
  }

  static lengthFor(bitCount) =>
    (bitCount + indexMask) >> cellShift;
}

build(List<BB> blocks) {
  final liveOutSets = new List<NodeSet>.generate(blocks.length, (idx) => new NodeSet(), growable: false);
  final definedSets = new List<NodeSet>.generate(blocks.length, (idx) => new NodeSet(), growable: false);

  // Compute initial sets.
  final upwardsExposed = new NodeSet();
  for (var block in blocks) {
    upwardsExposed.clear();

    final defined = definedSets[block.id];
    for (var op in block.phis) {
      defined.add(op);
    }

    for (var op in block.code) {
      for (var input in op.inputs) {
        if (input.def != null && !defined.contains(input.def))
          upwardsExposed.add(input.def);
      }

      defined.add(op);
    }

    for (var i = 0; i < block.predecessors.length; i++) {
      final pred = block.predecessors[i];
      final liveOut = liveOutSets[pred.id];

      liveOut.addAll(upwardsExposed);
      for (var phi in block.phis) {
        liveOut.add(phi.inputs[i].def);
      }
    }
  }

  // Fix point.
  var changed;
  do {
    changed = false;
    for (var block in blocks.reversed) {
      final liveOut = liveOutSets[block.id];
      for (var succ in block.successors) {
        if(liveOut.addAllWithout(liveOutSets[succ.id], definedSets[succ.id])) {
          assert(!liveOut.addAllWithout(liveOutSets[succ.id], definedSets[succ.id]));
          changed = true;
        }
      }
    }
  } while (changed);

  return liveOutSets;
}