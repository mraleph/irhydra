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
import 'package:observe/observe.dart';
import 'package:collection/equality.dart' show ListEquality;
import 'package:ui_utils/graph.dart' as graph;

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
  final Method method;

  /** Phase's name */
  final String name;

  /** Intermediate representation artifact produced by the phase. */
  var ir;

  /** Native code artifact produced by the phase. */
  var code;

  Phase(this.method, this.name, {this.ir, this.code});
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
  final Iterable<String> raw;

  final reason;

  /** Type of the deoptimization ("eager", "lazy", "soft"). */
  final String type;

  Deopt(this.timestamp, this.id, this.raw, { this.type: "eager", this.optimizationId, this.reason});

  static final _typesOrdering = const { "eager": 0, "lazy": 1, "soft": 2, "debugger": 3, "none": 4 };
  static final _types = _typesOrdering.keys.toList();

  static worst(type, deopt) =>
    _types[min(_typesOrdering[type], _typesOrdering[deopt.type])];
}

class FunctionSource {
  final int id;
  final String name;
  final Iterable source;
  final int startPos;

  FunctionSource(this.id, this.name, this.source, this.startPos);
}

class SourcePosition {
  final int inlineId;
  final int position;

  SourcePosition(this.inlineId, this.position);

  operator == (other) =>
    inlineId == other.inlineId && position == other.position;

  get hashCode =>
    inlineId.hashCode + position.hashCode;

  toString() => "<${inlineId}:${position}>";
}

/// Line is dead: no instructions were produced from it.
const LINE_DEAD = 0;

/// Line was moved by LICM: all produced instructions are outside of the
/// loop to which the line belongs syntactically.
const LINE_LICM = 1;

/// Line is live: instructions were produced from this line and not moved.
const LINE_LIVE = 3;

class InlinedFunction {
  final Method method;
  final int inlineId;
  final FunctionSource source;
  final SourcePosition position;

  var annotations;

  contains(SourcePosition other) =>
    other != null && other.inlineId == inlineId;

  InlinedFunction(this.method, this.inlineId, this.source, this.position);
}

/**
 * Method or function.
 *
 * A unit of granularity for the compilation pipeline.
 */
class Method extends Observable {
  /** Unique optimization identifier for this method. */
  final optimizationId;

  /** Method's name */
  final Name name;

  /** List of [Phase] artifacts associated with this method. */
  final List<Phase> phases = new ObservableList<Phase>();

  /** List of [Deopt] artifacts associated with this method. */
  @observable final List<Deopt> deopts = new ObservableList<Deopt>();

  /** List of function sources associated with this method. */
  final List<FunctionSource> sources = <FunctionSource>[];

  final List<InlinedFunction> inlined = <InlinedFunction>[];

  @observable var worstDeopt = 'none';

  @observable var perfProfile;

  var srcMapping;
  var interesting;

  Set<String> tags;

  Method(this.name, {this.optimizationId});

  addDeopt(deopt) {
    worstDeopt = Deopt.worst(worstDeopt, deopt);
    deopts.add(deopt);
  }

  isTagged(String tag) => tags != null && tags.contains(tag);

  tag(String t) {
    if (tags == null) tags = new Set<String>();
    tags.add(t);
  }

  toString() => "Method(${name.full}, id: ${optimizationId})";
}

class ParsedIr {
  final Method method;
  final mode;
  final Map<String, Block> blocks;
  final code;
  final deopts;

  // Attached profiling information (e.g. from perf annotate tool).
  var profile;

  get blockTicks => (profile != null) ? profile.blockTicks : null;

  ParsedIr(this.method, this.mode, this.blocks, this.code, this.deopts);
}

/** Block in the control flow graph. */
class Block extends graph.BasicBlock {
  /** Block's number in a sequence of blocks. */
  final hir = <Instruction>[];
  final lir = <Instruction>[];

  Block(id, name) : super(id, name);
}

class MultiId {
  final List<String> ids;

  MultiId(this.ids);

  operator == (other) {
    return (other is MultiId) && const ListEquality().equals(ids, other.ids);
  }

  toString() => ids.join(', ');
}

/** IR instruction. */
class Instruction {
  /** Unique identifier (e.g. SSA name). */
  final id;

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

  get tag;
  get text;
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




