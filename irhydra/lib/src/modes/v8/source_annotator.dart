// Copyright 2014 Google Inc. All Rights Reserved.
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

/** Anotates source with information derived from IR. */
library modes.v8.source_annotator;

import 'dart:js' as js;
import 'package:irhydra/src/modes/ir.dart' as IR;

class _Range {
  final start;
  final end;

  _Range(this.start, this.end);

  contains(srcPos) =>
    start <= srcPos.position && srcPos.position < end;

  toString() => "($start, $end)";
}

class RangedLine {
  final str;
  final range;
  final column;

  RangedLine(this.str, this.range, this.column);
}

typedef dynamic TraversalCallback(js.JsObject node, js.JsObject parent);

class _AST {
  static const PREFIX = "(function ";
  static const SUFFIX = ")";

  static const GLOBAL_PREFIX = "(function () {";
  static const GLOBAL_SUFFIX = "})";

  static final VISIT_SKIP = js.context['estraverse']['VisitorOption']['Skip'];
  static final VISIT_BREAK = js.context['estraverse']['VisitorOption']['Break'];

  final js.JsObject body;
  final int prefixLength;

  _AST.withBody(this.body, this.prefixLength);

  traverse({TraversalCallback onEnter, TraversalCallback onLeave}) =>
    js.context['estraverse'].callMethod('traverse', [body, new js.JsObject.jsify({
      'enter': onEnter,
      'leave': onLeave
    })]);


  // Helper function that accomondates for prefix length in ranges returned by Esprima.
  rangeOf(n) => new _Range(n['range'][0] - prefixLength, n['range'][1] - prefixLength);

  static js.JsObject tryParse(prefix, body, suffix) {
    try {
      return js.context['esprima'].callMethod('parse', [prefix + body + suffix, new js.JsObject.jsify({'range': true})]);
    } catch (e) {
      return null;
    }
  }

  factory _AST(lines) {
    // Source is dumped in the form (args) { body }. We prepend SUFFIX and PREFIX
    // to make it parse as FunctionExpression: (function (args) { body }).
    // Sometime V8 also includes trailing comma into the source dump. Strip it.
    lines = lines.join('\n');
    lines = lines.substring(0, lines.lastIndexOf('}') + 1);
    js.JsObject ast = null;
    var prefix = null;

    prefix = PREFIX;
    ast = tryParse(PREFIX, lines, SUFFIX);
    if (ast == null) {
      prefix = GLOBAL_PREFIX;
      ast = tryParse(GLOBAL_PREFIX, lines, GLOBAL_SUFFIX);
      if (ast == null) {
        return null;
      }
    }

    final body = ast['body'][0]['expression']['body'];

    return new _AST.withBody(body, prefix.length);
  }

}

class LoopId {
  final inlineId;
  final loopId;

  final parent;

  toString() => "(${inlineId}, ${loopId})";

  LoopId(this.inlineId, this.loopId, this.parent);

  isOutsideOf(other) {
    while (other.inlineId != 0 && inlineId != other.inlineId) {
      other = other.parent();
    }


    if (this.inlineId == other.inlineId) {
      return this.loopId < other.loopId;
    }

    return false;
  }
}


// TODO(mraleph): we pass parser as [irInfo] make a real IRInfo class.
annotate(IR.Method method, Map<String, IR.Block> blocks, irInfo) {
  if (method.sources.isEmpty) {
    // TODO(mraleph) should some fluffy status notification about this.
    print("source_annotator.annotate failed: sources not available (code.asm not loaded?)");
    return;  // Sources not loaded.
  }

  final sources = method.sources.map((f) => f.source.toList()).toList();

  sourceId(IR.SourcePosition srcPos) => method.inlined[srcPos.inlineId].source.id;

  /// Compute positions ranges corresponding to the for/while loops in the source.
  /// We will later use this information to detected instructions moved by LICM.
  findLoops(_AST ast) {
    if (ast == null) {
      return [];
    }

    final loops = [];
    ast.traverse(onEnter: (node, parent) {
      switch (node['type']) {
        case 'FunctionExpression':
        case 'FunctionDeclaration':
          return _AST.VISIT_SKIP;

        case 'ForStatement':
          final loopRange = ast.rangeOf(node);
          if (node['init'] != null) {
            // Strip range covering init-clause of the for-loop from the
            // computed range of the loop. It is executed only once.
            final initRange = ast.rangeOf(node['init']);
            loops.add(new _Range(initRange.end, loopRange.end));
          } else {
            loops.add(loopRange);
          }
          break;

        case 'WhileStatement':
        case 'DoWhileStatement':
          final range = ast.rangeOf(node);
          // TODO(vegorov): this is a serious hack just to workaround the
          // fact of how V8 assigns positions for while loop.
          loops.add(new _Range(range.start + 1, range.end));
          break;
      }
    });
    return loops;
  }

  final asts = sources.map((lines) => new _AST(lines)).toList();

  final loops = asts.map(findLoops).toList();

  rangeOf(srcPos) {
    final ast = asts[sourceId(srcPos)];
    if (ast == null) {
      return null;
    }

    var range = null;
    ast.traverse(
      onEnter: (node, parent) {
        switch (node['type']) {
          case 'FunctionExpression':
          case 'FunctionDeclaration':
            return _AST.VISIT_SKIP;
        }

        if (!ast.rangeOf(node).contains(srcPos)) {
          return _AST.VISIT_SKIP;
        }
      },
      onLeave: (node, parent) {
        if (ast.rangeOf(node).contains(srcPos)) {
          range = ast.rangeOf(node);
          return _AST.VISIT_BREAK;
        }
      });
    return range;
  }

  final _loopOfCache = new List.filled(method.inlined.length, null);

  /// Return the innermost loop covering given source position.
  loopOf(IR.SourcePosition srcPos) {
    if (srcPos == null) {  // First couple of blocks in the graph don't have positions attached.
      return new LoopId(0, -1, null);
    }

    final ls = loops[sourceId(srcPos)];
    // Loop ranges are sorted according to nesting by construction.
    // Iterate backwards to hit innermost loop first.
    for (var i = ls.length - 1; i >= 0; i--) {
      final range = ls[i];
      if (range.contains(srcPos)) {
        return new LoopId(srcPos.inlineId, i, () => loopOf(method.inlined[srcPos.inlineId].position));
      }
    }

    if (_loopOfCache[srcPos.inlineId] != null) {
      return _loopOfCache[srcPos.inlineId];
    }

    final f = method.inlined[srcPos.inlineId];
    return _loopOfCache[srcPos.inlineId] = loopOf(f.position);
  }

  /// Return line number for the given source position.
  lineNum(IR.SourcePosition srcPos) {
    final lines = sources[sourceId(srcPos)];

    var line = 0, ch = srcPos.position;
    while ((line < lines.length) && (ch > lines[line].length)) {
      ch -= lines[line].length + 1;
      line++;
    }
    return line;
  }

  columnNum(IR.SourcePosition srcPos) {
    final lines = sources[sourceId(srcPos)];

    var line = 0, ch = srcPos.position;
    while ((line < lines.length) && (ch > lines[line].length)) {
      ch -= lines[line].length + 1;
      line++;
    }

    return ch;
  }

  lineStr(IR.SourcePosition srcPos) {
    final lines = sources[sourceId(srcPos)];
    final n = lineNum(srcPos);
    return n < lines.length ? lines[n] : null;
  }

  rangeStr(srcPos) {
    final lineNo = lineNum(srcPos);
    final line = lineStr(srcPos);

    final range = rangeOf(srcPos);
    if (range == null) {
      return new RangedLine(line, new _Range(0, line.length), columnNum(srcPos));
    }

    final startLn = lineNum(new IR.SourcePosition(srcPos.inlineId, range.start));
    final endLn = lineNum(new IR.SourcePosition(srcPos.inlineId, range.end));

    final startCh = startLn == lineNo ?
        columnNum(new IR.SourcePosition(srcPos.inlineId, range.start)) :
        0;

    final endCh = endLn == lineNo ?
        columnNum(new IR.SourcePosition(srcPos.inlineId, range.end)) :
        line.length;

    final chRange = new _Range(startCh, endCh);

    return new RangedLine(line, chRange, columnNum(srcPos));
  }

  final mapping = {};
  final interesting = {};

  if (method.isTagged('turbofan')) {
    for (var block in blocks.values) {
      if (block.hir != null) {
        var previous;
        for (var ir in block.hir) {
          final hirId = ir.id;
          interesting[hirId] = true;
          final srcPos = irInfo.hir2pos[hirId];
          if (srcPos == null || previous == srcPos) continue;
          final line = rangeStr(srcPos);
          if (line == null || line.str.isEmpty) {
            print("can't map ${hirId}");
            continue;
          }
          mapping[hirId] = line;
          previous = srcPos;
        }
      }
    }

    for (var f in method.inlined) {
      f.annotations = null;
    }
  } else {
    // We assume that anything that is not TurboFan is Crankshaft
    for (var block in blocks.values) {
      if (block.lir != null) {
        var previous = null;
        for (var instr in block.lir.where(_isInterestingOp)) {
          final hirId = irInfo.lir2hir[instr.id];
          if (hirId == null) continue;

          interesting[hirId] = true;

          final srcPos = irInfo.hir2pos[hirId];
          if (srcPos == null || previous == srcPos) continue;

          mapping[hirId] = rangeStr(srcPos);
          previous = srcPos;
        }

        for (var instr in block.hir) {
          if (instr.op == "Phi") interesting[instr.id] = true;
        }
      }
    }

    // Attach annotation arrays to all inlined functions.
    final annotations = method.inlined.map((f) =>
    f.annotations = new List.filled(sources[f.source.id].length, IR.LINE_DEAD))
        .toList();

    findBlockEntry(block) =>
        block.hir
            .firstWhere((instr) => instr.op == "BlockEntry")
            .id;

    findBlockLoop(block) {
      final blockEntry = findBlockEntry(block);
      final blockPos = irInfo.hir2pos[blockEntry];

      // Sometimes V8 produces incorrect positions for the first loop body block:
      // it points to the loops init clause instead of pointing past it.
      // This confuses our loop finding algorithm that skips init clause.
      // Try working around this by looking at our predecessor: if its a direct
      // fall-through and it's position is further ahead compared to ours than
      // something went wrong - take its position.
      if (block.predecessors.length == 1 &&
          block.predecessors.first.id < block.id &&
          block.predecessors.first.predecessors.length == 1 &&
          block.predecessors.first.successors.length == 1) {
        final predBlockEntry = findBlockEntry(block.predecessors.first);
        final predBlockPos = irInfo.hir2pos[predBlockEntry];
        if (blockPos == null ||
            (predBlockPos != null &&
                predBlockPos.inlineId == blockPos.inlineId &&
                predBlockPos.position > blockPos.position)) {
          return loopOf(predBlockPos);
        }
      }

      return loopOf(blockPos);
    }


    // Process IR and mark lines according to IR instructions that were generated from them.
    for (var block in blocks.values) {
      if (block.lir != null) {
        final blockLoop = findBlockLoop(block);

        // When processing LIR skip all artificial instructions (gap moves,
        // labels, gotos and stack-checks). Even if they have position falling
        // into some line, that does not make that line alive.
        for (var instr in block.lir.where(_isInterestingOp)) {
          final hirId = irInfo.lir2hir[instr.id];
          if (hirId == null) continue;

          final srcPos = irInfo.hir2pos[hirId];
          if (srcPos == null) continue;

          // Before marking the line alive check if instruction was hoisted by
          // LICM from its loop.
          final instrLoop = loopOf(srcPos);
          if (instrLoop != null && blockLoop.isOutsideOf(instrLoop)) {
            // Instruction was hoisted from its loop. Mark the line as LICMed.
            annotations[srcPos.inlineId][lineNum(srcPos)] |= IR.LINE_LICM;
          } else {
            annotations[srcPos.inlineId][lineNum(srcPos)] |= IR.LINE_LIVE;
          }
        }
      }
    }


    var worklist = []..addAll(method.inlined);
    while (!worklist.isEmpty) {
      final f = worklist.removeLast();
      if (f.position != null && f.annotations.contains(IR.LINE_LIVE)) {
        annotations[f.position.inlineId][lineNum(f.position)] |= IR.LINE_LIVE;

        final outer = method.inlined[f.position.inlineId];
        if (!worklist.contains(outer)) worklist.add(outer);
      }
    }
  }
  
  // Commit mappings.
  if (!mapping.isEmpty) {
    method.srcMapping = mapping;
    if (!interesting.isEmpty) {
      method.interesting = interesting;
    }
  }
}

/// Returns "true" is instruction is not one of artificial instructions
/// produced for internal reasons.
_isInterestingOp(instr) {
  switch (instr.op) {
    case "gap":  // Gap move produced by regalloc.
    case "label":  // Branch target.
    case "goto":   // Unconditional branch.
    case "stack-check":  // Interrupt check.
    case "lazy-bailout":  // Post call lazy deoptimization point.
    case "constant-t":
    case "constant-d":
      return false;
    default:
      return true;
  }
}
