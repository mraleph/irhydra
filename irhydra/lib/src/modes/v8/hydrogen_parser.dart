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

/** Parser for hydrogen.cfg files. */
library modes.v8.hydrogen_parser;

import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:irhydra/src/modes/v8/name_parser.dart' as name_parser;
import 'package:irhydra/src/modes/v8/source_annotator.dart' as source_annotator;
import 'package:ui_utils/parsing.dart' as parsing;

bool canRecognize(String str) =>
  str.contains("begin_cfg") && str.contains("begin_compilation");

/**
 * Preparse the hydrogen.cfg file content extracting all compiled method
 * and phases.
 */
List<IR.Method> preparse(String str) {
  // Restore trailing newline if it was stripped somehow e.g. by copy-paste.
  if (str[str.length - 1] != '\n') str += '\n';

  // Matches tags that start/end compilation and cfg records.
  final tagRe = new RegExp(r"(begin|end)_(compilation|cfg)\n");

  // Matches line containing method name and optimization id.
  final compilationRe = new RegExp(r'name "([^"]*)"\n\s+method "([^"]*)"');

  // Matches line containing the name field.
  final nameRe = new RegExp(r'name "([^"]*)"');

  // Current method and the list of all methods.
  var method, methods = [];

  // Start position of the current record.
  var start;

  // Find all tags in the string.
  for (var match in tagRe.allMatches(str)) {
    final tag = match.group(0);

    if (tag.startsWith("begin_")) {
      start = match.end;  // Just remember the start and wait for the end tag.
    } else if (tag == "end_compilation\n") {
      // This is the compilation record for the method.
      // Extract the name from the record.
      final substr = str.substring(start, match.start);
      parsing.match(substr, compilationRe, (name, methodName) {
        // Create the method and make it current.
        final m = new RegExp(r':(\d+)$').firstMatch(methodName);
        var optId;
        if (m != null) optId = m.group(1);
        method = new IR.Method(name_parser.parse(name),
                               optimizationId: optId);
        methods.add(method);
      });
    } else if (tag == "end_cfg\n") {
      // This is the cfg record containing blocks. No need to create substring
      // right away: its content will be needed only when this phase is
      // displayed.
      final substr = _deferSubstring(str, start, match.start);

      // Extract phase's name from the first line of the cfg record.
      final firstLine = str.substring(start, str.indexOf("\n", start));
      final name = nameRe.firstMatch(firstLine).group(1);

      method.phases.add(new IR.Phase(method, name, ir: substr));
    }
  }

  return methods;
}

/** Create a substring thunk. */
_deferSubstring(str, start, end) =>
  () => str.substring(start, end);

/** Parse given phase IR stored in the deferred substring thunk. */
Map parse(IR.Method method, Function ir, statusObject) {
  final stopwatch = new Stopwatch()..start();
  final parser = new CfgParser(method, ir())..parse();

  for (var deopt in method.deopts) {
    if (deopt.id == null) {
      continue;
    }

    final lirId = parser.bailouts[deopt.id];
    deopt.lir = parser.id2lir[lirId];

    final hirId = parser.lir2hir[lirId];
    deopt.hir = parser.id2hir[hirId];

    deopt.srcPos = parser.hir2pos[hirId];
  }

  final blocks = parser.builder.blocks;

  for (var block in blocks.values) {
    if (block.lir != null && block.hir != null) {
      for (var lirIns in block.lir) {
        final hirId = parser.lir2hir[lirIns.id];
        if (hirId != null) {
          final hirIns = parser.id2hir[hirId];
          if (hirIns.code == null) {
            hirIns.code = [];
          }
          hirIns.code.add(lirIns);
        }
      }
    }
  }

  isDead(block) =>
    block.predecessors.every((pred) => pred.marks.contains("dead") ||
                                       pred.marks.contains("deoptimizes"));

  final worklist = parser.deoptimizing;
  while (!worklist.isEmpty) {
    final block = worklist.removeLast();
    if (!block.marks.contains("dead")) {
      if (isDead(block)) {
        block.mark("dead");
      } else if (block.marks.contains("deoptimizes")) {
        loop: for (var instr in block.hir) {
          switch (instr.op) {
            case "BlockEntry":
            case "Constant":
            case "Simulate":
            case "Phi":
              break;

            case "Deoptimize":
              block.mark("dead");
              break loop;

            default:
              break loop;
          }
        }
      }
    }

    for (var succ in block.successors) {
      if (!succ.marks.contains("dead") && isDead(succ)) {
        succ.mark("dead");
        worklist.add(succ);
      }
    }
  }

  try {
    source_annotator.annotate(method, blocks, parser);
  } catch (e, stack) {
    print("""ERROR: source_annotator.annotate failed.
There is a mismatch between the source and source positions recorded.
This can be caused by the presence of CRLF line endings.
IRHydra assumes LF-only endings. Contact @mraleph for troubleshooting.
""");
    print(e);
    print(stack);
    statusObject.sourceAnnotatorFailed = true;
    for (var f in method.inlined)
        f.annotations = null;
  }

  print("hydrogen_parser.parse took ${stopwatch.elapsedMilliseconds}");
  return blocks;
}

class CfgParser extends parsing.ParserBase {
  final builder = new IR.CfgBuilder();
  IR.Block block;

  var lirOperands, hirOperands;

  CfgParser(IR.Method method, str) : super(str.split('\n')) {
    hirOperands = parsing.makeSplitter({
      r"0x[a-f0-9]+": (hirId, val) => new Constant(val),
      // This is to highlight %p formatted pointers on Win64.
      r"\b[A-F0-9]{16}\b": (hirId, val) => new Constant(val),
      r"B\d+\b": (hirId, val) => new IR.BlockRef(val),
      r"[a-zA-Z]+\d+\b": (hirId, val) => new IR.ValRef(val),
      r"range:(-?\d+)_(-?\d+)(_m0)?": (hirId, low, high, m0) => new Range(low, high, m0 != null),
      r"changes\[[^\]]+\]": (hirId, val) {
        final changes = new Changes(val);
        if (changes.all) block.mark("changes-all");
        return changes;
      },
      r"type:[-\w]+": (hirId, val) => new Type(val.split(':').last),
      r"uses:\w+": (hirId, _) => null,
      r"pos:(\d+)(_(\d+))?": (hirId, inliningId, _, pos) {
        if (pos == null) {
          pos = int.parse(inliningId);
          inliningId = 0;
          if (method.sources.isNotEmpty && method.sources[0].startPos != null) {
            pos -= method.sources[0].startPos;
          }
        } else {
          pos = int.parse(pos);
          inliningId = int.parse(inliningId);
        }
        hir2pos[hirId] = new IR.SourcePosition(inliningId, pos);
      },
      r"pos:inlining\((\d+)\),(\d+)": (hirId, inliningId, pos) {
        pos = int.parse(pos);
        inliningId = int.parse(inliningId) + 1;
        if (method.inlined.isNotEmpty &&
            method.inlined[inliningId].source.startPos != null) {
          pos -= method.inlined[inliningId].source.startPos;
        }
        hir2pos[hirId] = new IR.SourcePosition(inliningId, pos);
      }
    });

    lirOperands = parsing.makeSplitter({
      r"\[id=.*?\](?= )": (lirId, val) {
        parsing.match(val, deoptIdRe, (deoptId) => recordDeopt(lirId, deoptId));
        return new DeoptEnv(val);
      },
      r"{[^}]+}": (_, val) => new StackMap(val),
      r"B\d+\b": (_, val) => new IR.BlockRef(val),
      r"\[hir:(\w\d+)\]": (lirId, hirId) {
        recordLir2Hir(lirId, hirId);
        return null;
      }
    });
  }

  final bailouts = new Map<int, String>();

  final lir2hir = new Map<String, String>();

  final hir2pos = new Map<String, IR.SourcePosition>();

  final id2hir = new Map<String, IR.Instruction>();
  final id2lir = new Map<String, IR.Instruction>();

  final id2block = new Map<String, IR.Block>();

  final deoptimizing = [];

  /** Matches deopt_id data stored in lithium environment in hydrogen.cfg. */
  final deoptIdRe = new RegExp(r"deopt_id=(\d+)");

  recordDeopt(lirId, deoptId) =>
    bailouts[int.parse(deoptId)] = lirId;

  recordLir2Hir(lirId, hirId) =>
    lir2hir[lirId] = hirId;

  /** Parses hydrogen instructions into SSA name, opcode and operands. */
  parseHir(line) {
    final m = hirLineRe.firstMatch(line);
    if (m == null) return null;

    final id = m.group(1);
    final opcode = m.group(2);
    final operands = m.group(3);

    id2block[id] = block;
    if (opcode == "Deoptimize") {
      block.mark("deoptimizes");
      deoptimizing.add(block);
    }

    return id2hir[id] = new IR.Instruction(id, opcode, hirOperands(operands, context: id));
  }

  parseLir(line) {
    final m = lirLineRe.firstMatch(line);
    if (m == null) return null;

    // Lithium ids are multiplied by 2 in the hydrogen.cfg (artifact of
    // the register allocation architecture).
    final id = int.parse(m.group(1)) ~/ 2;
    final opcode = m.group(2);

    var operands = m.group(3);
    if (opcode == "label" || opcode == "gap") {
      operands = operands.replaceAll(lirLineIgnoredMovesRe, "")
                         .replaceAll("()", "")
                         .replaceAllMapped(lirLineRedundantMovesRe,
                                           (m) => m.group(1))
                         .replaceAll(new RegExp(r"\s+"), " ");
      if (!operands.contains("=")) return null;  // No moves left?
    }

    final lirId = "$id";
    return id2lir[lirId] = new IR.Instruction("$id", opcode, lirOperands(operands, context: lirId));
  }

  get patterns => {
    r"begin_block": {
      r'name "([^"]*)"': (name) {
        block = builder.block(name);
      },

      r'flags "dead"': () {
        block.mark("dead");
        block.mark("v8.dead");
      },

      r"successors(.*)$": (successors) {
        final successorsRe = new RegExp(r'"(B\d+)"');
        for (var m in successorsRe.allMatches(successors)) {
          builder.edge(block.name, m.group(1));
        }
      },

      r"begin_locals": {  // Block phis.
        r"end_locals": () => leave(),

        r"^\s+\-?\d+\s+(\w+\d+)\s+(.*)$": (id, args) {
          block.hir.add(new IR.Instruction(id, "Phi", hirOperands(args, context: id)));
        }
      },

      "begin_HIR": {  // Hydrogen IR.
        "end_HIR": () {
          block.hir.addAll(subrange().map(parseHir)
                                     .where((instr) => instr != null));
          leave();
        }
      },

      "begin_LIR": {  // Lithium IR.
        "end_LIR": () {
          block.lir.addAll(subrange().map(parseLir)
                                     .where((instr) => instr != null));
          leave();
        }
      },

      "end_block": () {
        block = null;
        leave();
      }
    },
  };
}

/** Single HIR instruction from the hydrogen.cfg. */
final hirLineRe = new RegExp(r"^\s+\d+\s+\d+\s+(\w+\d+)\s+([-\w]+)\s*(.*)<");

class Constant extends IR.Operand {
  final text;
  Constant(this.text);

  get tag => "constant";
}

class Range extends IR.Operand {
  final low;
  final high;
  final m0;
  Range(this.low, this.high, this.m0);

  get tag => "range";
  get text => "[${low}, ${high}]" + (m0 ? "\u222A{-0}" : "");
}

class Changes extends IR.Operand {
  final changes;
  Changes(this.changes);

  get all => changes == "changes[*]";

  get tag => all ? "changes-all" : "changes";
  get text => changes;
}

class Type extends IR.Operand {
  final text;
  Type(this.text);

  get tag => "type";
}

/** Single LIR instruction from hydrogen.cfg. */
final lirLineRe = new RegExp(r"^\s+(\d+)\s+([-\w]+)\s*(.*)<");

/** Matches ignored gap moves inserted by lithium-allocator. */
final lirLineIgnoredMovesRe = new RegExp(r"\(0\) = \[[^\]]+\];");

/** Matches redundant gap moves inserted by lithium-allocator. */
final lirLineRedundantMovesRe = new RegExp(r"(\(|; )\[[^\]]+\];");

class DeoptEnv extends IR.Operand {
  final text;
  DeoptEnv(this.text);

  get tag => "env";
}

class StackMap extends IR.Operand {
  final text;
  StackMap(this.text);

  get tag => "map";
}
