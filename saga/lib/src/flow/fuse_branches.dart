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

/// Fuse together instructions producing FLAGS and branches that branch
/// on these flags:
///
///     c = a - b
///     f = flagsOf(c)
///     BranchOn lt, c
///
/// becomes
///
///     BranchIf a < b
///
library saga.flow.fuse_branches;

import 'package:saga/src/flow/node.dart';
import 'package:saga/src/util.dart';

fuseBranches(blocks) {
  fusedSelect(select, left, right) =>
    Node.selectIf(select.op.condition, left, right, select.inputs[1].def, select.inputs[2].def);

  fusedBranch(branch, left, right) =>
    Node.branchIf(branch.op.condition, left, right, branch.op.thenTarget, branch.op.elseTarget);

  tryFuse(candidate, replacement) {
    final flags = candidate.inputs[0].def;
    assert(flags.op == FLAGS);
    if (flags.uses.length > 1) return;

    final op = flags.inputs[0].def;
    if (op.uses.length > 1) return;

    if (op.op == SUB) {
      candidate.replaceWith(replacement(candidate, op.inputs[0].def, op.inputs[1].def));
    } else if (op.op == AND) {
      if (op.inputs[0].def != op.inputs[1].def) {
        return;
      }

      candidate.replaceWith(replacement(candidate, op.inputs[0].def, Node.konst(0)));
    }
  }

  for (var block in blocks) {
    if (block.code.isEmpty) continue;

    for (var select in iterate(block.code).where((node) => node.op is OpSelect)) {
      tryFuse(select, fusedSelect);
    }

    final branch = block.code.last;
    if (branch.op is OpBranchOn) {
      tryFuse(branch, fusedBranch);
    }
  }
}