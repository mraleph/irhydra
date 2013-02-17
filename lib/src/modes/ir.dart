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

/** Object model for IR compilation artifacts. */
library ir;

/** Method name. */
class Name {
  /**
   * Full form of the method name.
   * Might include URI describing file or class defining the method.
   */
  final String full;

  /** Source file definining a method if known. */
  final String source;

  /** Short version of method's name. */
  final String short;

  Name(String this.full, String this.source, String this.short);

  /** Create a [Name] that has no short form. */
  Name.fromFull(String full) : this(full, null, full);

  /** Two names are equal if they have equal full forms. */
  operator ==(other) => other.full == full;
}

/**
 * Compilation phase.
 *
 * Usually a single named step in the compilation pipeline.
 */
class Phase {
  /** Phase's name */
  final String name;

  /** Intermediate representation artifact produced by the phase. */
  var ir;

  /** Native code artifact produced by the phase. */
  var code;

  Phase(this.name, {this.ir, this.code});
}

/**
 * Deoptimization event occured to a method.
 */
class Deopt {
  /** Unique identifier that maps deoptimization to a place in the IR */
  final id;

  /** Additional textual information about the deoptimization. */
  final raw;

  Deopt(this.id, this.raw);
}

/**
 * Method or function.
 *
 * A unit of granularity for the compilation pipeline.
 */
class Method {
  /** Method's name */
  final Name name;

  /** List of [Phase] artifacts associated with this method. */
  final phases = <Phase>[];

  /** List of [Deopt] artifacts associated with this method. */
  final deopts = [];

  Method(this.name);
}

/** Block in the control flow graph. */
class Block {
  /** Block's number in a sequence of blocks. */
  final int id;

  final String name;
  final successors = <Block>[];
  final predecessors = <Block>[];

  final hir = [];
  final lir = [];

  Block(this.id, this.name) {
    assert(id >= 0);
  }

  /** Creates an edge from this [Block] to the block [to]. */
  edge(Block to) {
    to.predecessors.add(this);
    successors.add(to);
  }
}

/** IR instruction. */
class Instruction {
  /** Raw representation of the instruction in the textual artifact. */
  final String raw;

  /** Unique identifier (e.g. SSA name). */
  final String id;

  /** Opcode */
  final String op;

  /** Arguments */
  final String args;

  Instruction(this.raw, this.id, this.op, this.args);
}

/** Branch instruction in the IR */
class Branch extends Instruction {
  /** Name of the successor for the [true] case. */
  final true_successor;

  /** Name of the successor for the false case. */
  final false_successor;

  Branch(raw, op, args, this.true_successor, this.false_successor)
      : super(raw, null, op, args);
}

/** Auxiliary class for control flow graph building */
class CfgBuilder {
  final _blocks = <String, Block>{};
  final _edges = <_Edge>[];

  /** Create a new block with name [name] */
  block(name) =>
    _blocks[name] = new Block(_blocks.length, name);

  /** Create a pending edge between blocks named [from] and [to]. */
  edge(from, to) =>
    _edges.add(new _Edge(from, to));

  /**
   * Return all blocks collected so far.
   * Resolve all pending edges assuming that all destination blocks were
   * created.
   */
  get blocks {
    for (var edge in _edges) {
      _blocks[edge.from].edge(_blocks[edge.to]);
    }
    _edges.clear();
    return _blocks;
  }
}

/** Control flow edge between two blocks. Used only by a IRBuilder. */
class _Edge {
  final String from, to;

  _Edge(this.from, this.to);
}




