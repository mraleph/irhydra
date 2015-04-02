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

/// Merge blocks together assuming that branches leading to NORETURN calls
/// are "unlikely" and are almost never taken.
library saga.flow.compact_likely;

import 'package:saga/src/flow/node.dart' as node;
import 'package:saga/src/parser.dart' as parser;

compact(blocks) {
  final throws = new Set<node.BB>.identity();

  mark(block) {
    if (!throws.add(block)) {
      return;
    }

    for (var pred in block.predecessors) {
      if (pred.successors.every(throws.contains)) {
        mark(pred);
      }
    }
  }

  for (var block in blocks) {
    final last = block.code.isNotEmpty ? block.code.last : null;
    if (last != null &&
        last.op is node.OpCall &&
        last.op.target.attributes.contains(parser.CallTargetAttribute.NORETURN)) {
      mark(block);
    }
  }


  final visited = new List<node.MergedBB>(blocks.length);
  var result = <node.MergedBB>[];
  for (var block in blocks) {
    if (visited[block.id] != null) {
      continue;
    }

    final merged = new node.MergedBB(result.length, [block]);
    result.add(merged);
    visited[block.id] = merged;

    final last = block.code.isNotEmpty ? block.code.last : null;
    if (last != null &&
        (last.op is node.OpBranchIf ||
         last.op is node.OpBranchOn) &&
        throws.contains(block.successors[1]) &&
        (visited[block.successors.first.id] == null) &&
        block.successors.first.predecessors.length == 1) {
      visited[block.successors.first.id] = merged;
      merged.blocks.add(block.successors.first);
    }
  }

  redirect(target) =>
    (target is node.BB) ? visited[target.id] : target;

  for (var block in result) {
    final lastBlock = block.blocks.last;
    for (var innerBlock in block.blocks) {
      for (var succ in innerBlock.successors) {
        if (visited[succ.id] != block || innerBlock == lastBlock) {
          block.edge(visited[succ.id], unlikely: innerBlock != lastBlock || throws.contains(succ));
          assert(visited[succ.id].blocks.first == succ);
        }
      }

      if (innerBlock.code.isNotEmpty) {
        final last = innerBlock.code.last;
        if (last.op is node.OpGoto) {
          last.op.target = redirect(last.op.target);
        } else if (last.op is node.OpBranchIf || last.op is node.OpBranchOn) {
          last.op.thenTarget = redirect(last.op.thenTarget);
          last.op.elseTarget = innerBlock == lastBlock ? redirect(last.op.elseTarget) : null;
        }
      }
    }
  }

  return new Map<String, node.BB>.fromIterable(result, key: (block) => block.name);
}