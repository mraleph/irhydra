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

import 'dart:math' show min;

// Prevent tree shaking of this library.
@MirrorsUsed(targets: const['*'])
import 'dart:mirrors';

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

  get display => short != "" ? short : "<anonymous>";

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
  /** An abstract timestamp that allows to figure which deopt happened before which. */
  final timestamp;

  /** ID of the code object that deoptimized. */
  final optimizationId;

  /** Unique identifier that maps deoptimization to a place in the IR. */
  final id;

  /** HIR/LIR/Source positions for the instruction that deoptimized. Resolved after IR is parsed. */
  var hir, lir, srcPos;

  /** Additional textual information about the deoptimization. */
  final raw;

  final reason;

  /** Type of the deoptimization ("eager", "lazy", "soft"). */
  final String type;

  Deopt(this.timestamp, this.id, this.raw, { this.type: "eager", this.optimizationId, this.reason});

  static final _typesOrdering = const { "eager": 0, "lazy": 1, "soft": 2 };
  static final _types = _typesOrdering.keys.toList();

  static worstType(deopts) {
    if (deopts.isEmpty) {
      return "none";
    }

    return _types[deopts.map((deopt) => _typesOrdering[deopt.type]).reduce(min)];
  }
}

class FunctionSource {
  final String name;
  final Iterable source;

  FunctionSource(this.name, this.source);
}

class SourcePosition {
  final int inlineId;
  final int position;

  SourcePosition(this.inlineId, this.position);

  toString() => "<${inlineId}:${position}>";
}

class InlinedFunction {
  final Method method;
  final int inlineId;
  final FunctionSource source;
  final SourcePosition position;

  contains(SourcePosition other) =>
    other != null && other.inlineId == inlineId;

  InlinedFunction(this.method, this.inlineId, this.source, this.position);
}

/**
 * Method or function.
 *
 * A unit of granularity for the compilation pipeline.
 */
class Method {
  /** Unique optimization identifier for this method. */
  final optimizationId;

  /** Method's name */
  final Name name;

  /** List of [Phase] artifacts associated with this method. */
  final List<Phase> phases = <Phase>[];

  /** List of [Deopt] artifacts associated with this method. */
  final List<Deopt> deopts = <Deopt>[];

  /** List of function sources associated with this method. */
  final List<FunctionSource> sources = <FunctionSource>[];

  final List<InlinedFunction> inlined = <InlinedFunction>[];

  get hasDeopts => deopts.length > 0;
  get hasSinglePhase => phases.length == 1;
  get worstDeopt => Deopt.worstType(deopts);

  Method(this.name, {this.optimizationId});
}

class ParsedIr {
  final mode;
  final Map<String, Block> blocks;
  final code;
  final deopts;

  ParsedIr(this.mode, this.blocks, this.code, this.deopts);
}

/** Block in the control flow graph. */
class Block {
  /** Block's number in a sequence of blocks. */
  final int id;

  final String name;
  final successors = <Block>[];
  final predecessors = <Block>[];

  final hir = <Instruction>[];
  final lir = <Instruction>[];

  static final EMPTY_MARKS = new Set();

  Set<String> marks = EMPTY_MARKS;

  Block(this.id, this.name) {
    assert(id >= 0);
  }

  /** Creates an edge from this [Block] to the block [to]. */
  edge(Block to) {
    to.predecessors.add(this);
    successors.add(to);
  }

  mark(tag) {
    if (marks == EMPTY_MARKS) {
      marks = new Set();
    }
    marks.add(tag);
  }
}

/** IR instruction. */
class Instruction {
  /** Unique identifier (e.g. SSA name). */
  final String id;

  /** Opcode */
  final String op;

  /** Arguments */
  final List args;

  /** Native code generated from the instruction */
  var code;

  Instruction(this.id, this.op, this.args);

  toString() => id != null ? "${id} <- ${op}(${args.join(', ')})"
                            : "${op}(${args.join(', ')})";
}

/** Branch instruction in the IR */
class Branch extends Instruction {
  /** Name of the successor for the [true] case. */
  final true_successor;

  /** Name of the successor for the false case. */
  final false_successor;

  Branch(op, args, this.true_successor, this.false_successor)
      : super(null, op, args);
}

abstract class Operand {
  toHtml(pane) => pane.formatOperand(this.tag, this.text);
}

class Ref extends Operand {
  final target;
  Ref(this.target);

  get tag => "ref";
  get text => target;
}

class BlockRef extends Ref {
  BlockRef(target) : super(target);

  toHtml(pane) => pane.makeBlockRef(target);
}

class ValRef extends Ref {
  ValRef(target) : super(target);

  toHtml(pane) => pane.makeValueRef(target);
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




