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

/// Forward loads/stores through RSP relative slots.
/// Assumes stack operations are well-behaved and all stack operations are
/// implicit in the IR.
library saga.flow.locals;

import 'package:saga/src/flow/node.dart';
import 'package:saga/src/flow/cpu_register.dart';
import 'package:saga/src/flow/ssa.dart';
import 'package:saga/src/util.dart';

findLocals(state, blocks) {
  final entrySp = state.entryState[CpuRegister.RSP];

  final offsets = new Map<Node, int>();

  rewire(def, int offset) {
    for (Use use in iterate(def.uses)) {
      final node = use.at;
      if (node.op == ADD || (node.op == SUB && use.idx == 0)) {
        final otherVal = node.inputs[1 - use.idx].def;
        if (otherVal.op is OpKonstant) {
          final int offs = otherVal.op.value;
          final int new_offset = offset + (node.op == SUB ? -offs : offs);
          if (def != entrySp) {
            final new_addr = Node.binary(ADD, entrySp, Node.konst(new_offset));
            node.replaceWith(new_addr);
            rewire(new_addr, new_offset);
          } else {
            rewire(node, new_offset);
          }
          continue;
        }
      } else if (node.op is OpAddr) {
        assert(use.idx == 0);
        assert(node.inputs[1].def == null);
        if (def != entrySp) {
          final new_addr = Node.addr(
              base: entrySp,
              offset: node.op.offset + offset);
          node.replaceWith(new_addr);
          rewire(new_addr, new_addr.op.offset);
        } else {
          rewire(node, node.op.offset);
        }
        continue;
      } else if (node.op == LOAD || node.op == STORE) {
        offsets[node] = offset;
        continue;
      } else if (node.op == PHANTOM) {
        continue;  // ignore phantoms
      }

      throw "can't establish the flow of RSP: ${def.opcode}";
    }
  }

  rewire(entrySp, 0);

  final ssa = new SSABuilder(blocks);
  for (var block in blocks) {
    ssa.startBlock(block);
    for (var node in iterate(block.code)) {
      final offset = offsets[node];
      if (offset != null) {
        if (node.op == STORE) {
          ssa.define(offset, node.inputs[1].def);
        } else {
          node.replaceUses(ssa.use(offset));
          node.remove();
        }
      }
    }
  }

  ssa.finish();
}