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

/// Abstract SSA construction algorithm.
library saga.flow.ssa;

import 'package:saga/src/flow/node.dart';
import 'package:saga/src/util.dart';

class SSABuilder {
  final blocks;
  final state;

  var currentBlock;
  final pendingPhis = <_PendingPhi>[];

  SSABuilder(blocks)
    : blocks = blocks,
      state = blocks.length == 0 ? []
                                 : new List(blocks.length);

  startBlock(block) {
    assert(currentBlock == null || currentBlock.id < block.id);
    currentBlock = block;
    while (state.length <= block.id) state.add(null);
    state[block.id] = makeState();
  }

  finish() {
    currentBlock = null;
    for (var pp in pendingPhis) {
      final preds = pp.phi.block.predecessors;
      for (var input in pp.phi.inputs) {
        input.bindTo(useAt(blocks[preds[input.idx].id], pp.id));
      }
    }

    _eliminateRedundantPhis();
  }

  _eliminateRedundantPhis() {
    for (var bb in blocks) {
      outer: for (var phi in iterate(bb.phis)) {
        if (!phi.hasUses) {
          phi.remove();
          continue;
        }

        if (bb.predecessors.isEmpty) continue;

        var value = null;
        final worklist = [phi];
        final worklistSet = new Set.from(worklist);

        for (var i = 0; i < worklist.length; i++) {
          final xphi = worklist[i];
          for (var input in xphi.inputs) {
            final def = input.def;
            if (def.op == PHI) {
              if (!worklistSet.contains(def)) {
                worklistSet.add(def);
                worklist.add(def);
              }
            } else if (value == null) {
              value = def;
            } else if (value != def) {
              continue outer;
            }
          }
        }

        assert(value != null);
        for (var xphi in worklist) {
          xphi.replaceUses(value);
        }
      }
    }

    {
      bool changed;
      do {
        changed = false;
        for (var bb in blocks) {
          for (var phi in iterate(bb.phis)) {
            if (!phi.hasUses) {
              phi.remove();
              changed = true;
            }
          }
        }
      } while (changed);
    }
  }

  useAt(block, id) {
    final blockState = state[block.id];
    var value = blockState[id];
    if (value == null) {
      if (block.id == 0) {
        print("id = ${id}");
      }

      // Not defined locally.
      if (currentBlock != null &&
          !block.predecessors.every((block) => block.id < currentBlock.id)) {
        // Block has unvisited predecessesors.
        // Just insert a phi and come back to fill it later.
        value = blockState[id] = phi(block);
        pendingPhis.add(new _PendingPhi(value, id));
      } else if (block.predecessors.length == 1) {
        // Single predecessor which is already visited. Recurse.
        value = blockState[id] = useAt(block.predecessors.first, id);
      } else {
        // Multiple visited predecessors. Insert a phi and fill it in.
        value = blockState[id] = phi(block);
        for (var input in value.inputs) {
          input.bindTo(useAt(block.predecessors[input.idx], id));
        }
      }
    }
    return value;
  }

  Node use(id) => useAt(currentBlock, id);

  define(id, Node val) {
    state[currentBlock.id][id] = val;
  }

  phi(block) {
    final phi = Node.phi(block.predecessors.length);
    phi.block = block;
    block.phis.add(phi);
    return phi;
  }

  makeState() => new Map<int, Node>();
}

class _PendingPhi {
  final phi;
  final id;
  _PendingPhi(this.phi, this.id);
}
