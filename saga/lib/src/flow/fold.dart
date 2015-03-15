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

part of flow.node;

fold(Node n) {
  final rule = rules[n.op.tag];

  if (rule != null) {
    final folded = rule(n);
    if (folded != n) {
      assert(!n.hasUses);
      for (var input in n.inputs) input.bindTo(null);
      return folded;
    }
  }

  return n;
}

final rules = {
  "^": (node) {
    if (node.inputs[0].def == node.inputs[0].def) {
      return Node.konst(0);
    }
    return node;
  },

  "+": (node) {
    if (node.inputs[1].def.op is OpKonstant &&
        node.inputs[1].def.op.value < 0) {
      return Node.binary(SUB, node.inputs[0].def,
        Node.konst(-node.inputs[1].def.op.value));
    }
    return node;
  },

  "OpSelectIf": (node) {
    final left = node.inputs[0].def;
    final right = node.inputs[1].def;
    final thenValue = node.inputs[2].def;
    final elseValue = node.inputs[3].def;

    if (left == thenValue && right == elseValue) {
      switch (node.op.condition) {
        case "<":
        case "<=":
          return Node.binary(MIN, left, right);

        case ">":
        case ">=":
          return Node.binary(MAX, left, right);
      }
    } else if (left == elseValue && right == thenValue) {
      switch (node.op.condition) {
        case ">":
        case ">=":
          return Node.binary(MIN, left, right);
        case "<":
        case "<=":
          return Node.binary(MAX, left, right);
      }
    }

    return node;
  },
};