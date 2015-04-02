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

/// IR description.
library saga.flow.node;

import 'dart:collection';

import 'package:ui_utils/graph.dart' as graph;

part 'fold.dart';

class BB extends graph.BasicBlock {
  final asm;

  final code = new LinkedList<Node>();
  final phis = new LinkedList<Node>();

  BB(id, this.asm) : super(id, "");

  printBlock() {
    print("${name}:");
    for (var phi in phis) {
      print(phi);
    }
    for (var node in code) {
      print(node);
    }
    print("");
  }

  append(Node node) {
    node.block = this;
    code.add(node);
  }

  prepend(Node node) {
    node.block = this;
    code.addFirst(node);
  }

  get name => "B${id}";

  toString() => "${name}";
}


/// compact_likely pass cheats and produces MergedBB instead of normal BB.
class MergedBB extends graph.BasicBlock implements BB {
  final List<BB> blocks;

  get asm => blocks.expand((b) => b.asm);
  get code => blocks.expand((b) => b.code);
  get phis => blocks.first.phis;

  MergedBB(id, this.blocks) : super(id, "") { }

  prepend(n) => throw "unsupported";
  append(n) => throw "unsupported";
  printBlock() => throw "unsupported";

  get origin => this;

  get name => blocks.first.name;
}

class Node extends LinkedListEntry<Node> {
  var origin;

  final int id;
  final Op op;
  final List<Use> inputs;

  var type;

  final LinkedList<Use> uses = new LinkedList<Use>();

  BB block;

  Node._(this.op, vals, {this.type}) : id = maxId++, inputs = new List<Use>(vals.length) {
    for (var i = 0; i < vals.length; i++) {
      inputs[i] = new Use(this, i)..setTo(vals[i]);
    }
  }

  factory Node(Op op, inputs, {type}) {
    return fold(new Node._(op, inputs, type: type));
  }

  static phi(int n) {
    return new Node(PHI, new List(n));
  }

  static BB entryBlock = null;
  static Map<int, Node> konsts = <int, Node>{};
  static konst(int val, {origin}) {
    var k = origin == null ? konsts[val] : null;
    if (k == null) {
      k = new Node(new OpKonstant(val), []);
      k.origin = origin;
      entryBlock.prepend(k);

      if (origin == null) konsts[val] = k;
    }
    return k;
  }

  static store(addr, value) {
    return new Node(STORE, [addr, value]);
  }

  static load(addr) {
    return new Node(LOAD, [addr]);
  }

  static flags(val) {
    return new Node(FLAGS, [val]);
  }

  static addr({base, index, int scale: 1, int offset: 0}) {
    return new Node(new OpAddr(scale, offset), [base, index]);
  }

  static select(opkind, flags, thenValue, elseValue) {
    return new Node(new OpSelect(opkind), [flags, thenValue, elseValue]);
  }

  static selectIf(opkind, left, right, thenValue, elseValue) {
    return new Node(new OpSelectIf(opkind), [left, right, thenValue, elseValue]);
  }

  static branchOn(opkind, flags, thenTarget, elseTarget) {
    return new Node(new OpBranchOn(opkind, thenTarget, elseTarget), [flags]);
  }

  static branchIf(opkind, lhs, rhs, thenTarget, elseTarget) {
    return new Node(new OpBranchIf(opkind, thenTarget, elseTarget), [lhs, rhs]);
  }

  static goto(target) {
    return new Node(new OpGoto(target), []);
  }

  static returnValue(val) {
    return new Node(RETURN, [val]);
  }

  static call(target) =>
    new Node(new OpCall(target), []);

  static binary(Op op, left, right) =>
    new Node(op, [left, right]);

  static phantom() =>
    new Node(PHANTOM, []);

  static unpack(narrowOop) =>
    new Node(UNPACK, [narrowOop]);

  static arg(int n, String name, type) =>
    new Node(new OpArg(n, name), [], type: type);

  toString() {
    return hasUses ? "v${id} <- ${op.format(inputs)}" : "${op.format(inputs)}";
  }

  get hashCode => id ^ op.hashCode;

  get hasUses => uses.isNotEmpty;

  get nonPhantomUses => uses.where((use) => use.at.op != PHANTOM);

  get hasNonPhantomUses => nonPhantomUses.isNotEmpty;

  replaceUses(def) {
    if (uses.isEmpty) return;

    for (var use = uses.first, next; use != null; use = next) {
      next = use.next;
      use.bindTo(def);
    }
  }

  remove() {
    assert(!hasUses);
    for (var input in inputs) {
      input.bindTo(null);
    }
    unlink();
    block = null;
  }

  insertAfter(other) {
    super.insertAfter(other);
    other.block = block;
  }

  replaceWith(def) {
    if (origin != null && def.origin == null) {
      def.origin =  origin;
    }
    insertAfter(def);
    replaceUses(def);
    remove();
  }

  get hasEffect => op.hasEffect;

  get alive => list != null;

  static var maxId = 0;

  static start(BB block) {
    entryBlock = block;
    maxId = 0;
    konsts.clear();
  }
}

class Use extends LinkedListEntry<Use> {
  final Node at;
  final int idx;
  Node def;

  Use(this.at, this.idx);

  bind() {
    if (def != null) {
      def.uses.addFirst(this);
      assert(list == def.uses);
    }
  }

  unbind() {
    if (def != null) {
      unlink();
      def = null;
    }
  }

  bindTo(Node def) {
    assert(def == null || def is Node);
    this.unbind();
    this.def = def;
    this.bind();
    assert(def == this.def && (def == null || this.def.uses == list));
  }

  setTo(Node node) {
    assert(def == null);
    bindTo(node);
  }

  toString() => def != null ? "v${def.id}" : "_";
}

abstract class Op {
  const Op();

  format(inputs) {
    final args = []..addAll(attrs)..addAll(inputs);
    return "${tag}(${args.join(', ')})";
  }

  get tag => typeTag;
  get typeTag;
  get attrs => const [];
  get hasEffect => false;
}

class SingletonOp extends Op {
  final typeTag;
  final hasEffect;

  const SingletonOp(this.typeTag, {this.hasEffect: false});
}

const PHI = const SingletonOp("OpPhi");
const STORE = const SingletonOp("OpStore", hasEffect: true);
const LOAD = const SingletonOp("OpLoad", hasEffect: true);
const FLAGS = const SingletonOp("OpFlags");
const RETURN = const SingletonOp("OpReturn", hasEffect: true);
const PHANTOM = const SingletonOp("OpPhantom", hasEffect: true);
const UNPACK = const SingletonOp("OpUnpack");

class OpKonstant extends Op {
  final int value;

  OpKonstant(this.value);
  get typeTag => "OpKonstant";

  format(_) => value;
}

class OpAddr extends Op {
  final int scale;
  final int offset;

  OpAddr(this.scale, this.offset);
  get typeTag => "OpAddr";

  format(inputs) => "[${inputs[0]} + ${inputs[1]} * ${scale} + ${offset}]";
}

class OpBinaryArith extends Op {
  final opkind;

  const OpBinaryArith(this.opkind);
  get typeTag => "OpBinaryArith";

  format(inputs) =>
    "${inputs[0]} ${opkind} ${inputs[1]}";

  get tag => opkind;
}

const ADD = const OpBinaryArith("+");
const SUB = const OpBinaryArith("-");
const AND = const OpBinaryArith("&");
const XOR = const OpBinaryArith("^");
const SHL = const OpBinaryArith("<<");
const MIN = const OpBinaryArith("min");
const MAX = const OpBinaryArith("max");

class OpSelect extends Op {
  final condition;

  OpSelect(this.condition);
  get typeTag => "OpSelect";

  get attrs => [condition];
}

class OpSelectIf extends Op {
  final condition;

  OpSelectIf(this.condition);
  get typeTag => "OpSelectIf";

  format(inputs) =>
    "if ${inputs[0]} ${condition} ${inputs[1]} then ${inputs[2]} else ${inputs[3]}";
}

class OpGoto extends Op {
  var target;

  OpGoto(this.target);
  get typeTag => "OpGoto";

  get hasEffect => true;
}

class OpBranchOn extends Op {
  final condition;
  var thenTarget;
  var elseTarget;

  OpBranchOn(this.condition, this.thenTarget, this.elseTarget);
  get typeTag => "OpBranchOn";

  get hasEffect => true;
}

class OpBranchIf extends Op {
  final condition;
  var thenTarget;
  var elseTarget;

  OpBranchIf(this.condition, this.thenTarget, this.elseTarget);
  get typeTag => "OpBranchIf";

  format(inputs) =>
    "if ${inputs[0]} ${condition} ${inputs[1]} then ${thenTarget} else ${elseTarget}";

  get hasEffect => true;
}

class OpArg extends Op {
  final n;
  final name;

  OpArg(this.n, this.name);
  get typeTag => "OpArg";

  get attrs => [n];

  format(_) => name;
}

class OpCall extends Op {
  final target;

  OpCall(this.target);
  get typeTag => "OpCall";

  get hasEffect => true;
}
