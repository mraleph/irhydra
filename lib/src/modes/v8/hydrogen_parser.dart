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
library hydrogen_parser;

import 'package:irhydra/src/formatting.dart' as formatting;
import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:irhydra/src/parsing.dart' as parsing;

bool canRecognize(String str) =>
  str.contains("begin_cfg") && str.contains("begin_compilation");

/**
 * Preparse the hydrogen.cfg file content extracting all compiled method
 * and phases.
 */
List<IR.Method> preparse(String str) {
  // Matches tags that start/end compilation and cfg records.
  final tagRe = new RegExp(r"(begin|end)_(compilation|cfg)\n");

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
      final name = nameRe.firstMatch(substr).group(1);

      // Create the method and make it current.
      method = new IR.Method(new IR.Name.fromFull(name));
      methods.add(method);
    } else if (tag == "end_cfg\n") {
      // This is the cfg record containing blocks. No need to create substring
      // right away: its content will be needed only when this phase is
      // displayed.
      final substr = _deferSubstring(str, start, match.start);

      // Extract phase's name from the first line of the cfg record.
      final firstLine = str.substring(start, str.indexOf("\n", start));
      final name = nameRe.firstMatch(firstLine).group(1);

      method.phases.add(new IR.Phase(name, ir: substr));
    }
  }

  return methods;
}

/** Create a substring thunk. */
_deferSubstring(str, start, end) =>
  () => str.substring(start, end);

/** Parse given phase IR stored in the deferred substring thunk. */
Map parse(IR.Method method, Function ir) {
  final stopwatch = new Stopwatch()..start();
  final parser = new CfgParser(ir())..parse();

  for (var deopt in method.deopts) {
    deopt.lirId = parser.bailouts[deopt.id];
    deopt.hirId = parser.lir2hir[deopt.lirId];
    print("${deopt.lirId} / ${deopt.hirId}");
  }
  print(parser.lir2hir);

  print("hydrogen_parser.parse took ${stopwatch.elapsedMilliseconds}");
  return parser.builder.blocks;
}

class CfgParser extends parsing.ParserBase {
  final builder = new IR.CfgBuilder();
  var block;

  var lirOperands;

  CfgParser(str) : super(str.split('\n')) {
    lirOperands = formatting.makeSplitter({
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

  /** Matches deopt_id data stored in lithium environment in hydrogen.cfg. */
  final deoptIdRe = new RegExp(r"deopt_id=(\d+)");

  recordDeopt(lirId, deoptId) =>
    bailouts[int.parse(deoptId)] = lirId;

  recordLir2Hir(lirId, hirId) =>
    lir2hir[lirId] = hirId;


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
    return new IR.Instruction(line, "$id", opcode, lirOperands(operands, context: lirId));
  }

  get patterns => {
    r"begin_block": {
      r'name "([^"]*)"': (name) {
        block = builder.block(name);
      },

      r"successors(.*)$": (successors) {
        final successorsRe = new RegExp(r'"(B\d+)"');
        for (var m in successorsRe.allMatches(successors)) {
          builder.edge(block.name, m.group(1));
        }
      },

      r"begin_locals": {  // Block phis.
        r"end_locals": () => leave(),

        r"^\s+\d+\s+(\w\d+)\s+(.*)$": (id, args) {
          final raw = " 0 0 $id Phi $args <|@";
          block.hir.add(new IR.Instruction(raw, id, "Phi", hirOperands(args)));
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
final hirLineRe = new RegExp(r"^\s+\d+\s+\d+\s+(\w\d+)\s+([-\w]+)\s*(.*)<");

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

  get changesAll => changes == "changes[*]";

  get tag => changesAll ? "changes-all" : "changes";
  get text => changes;
}

class Type extends IR.Operand {
  final text;
  Type(this.text);

  get tag => "type";
}

final hirOperands = formatting.makeSplitter({
  r"0x[a-f0-9]+": (val) => new Constant(val),
  r"B\d+\b": (val) => new IR.BlockRef(val),
  r"\w\d+\b": (val) => new IR.ValRef(val),
  r"range:(-?\d+)_(-?\d+)(_m0)?": (low, high, m0) => new Range(low, high, m0 != null),
  r"changes\[[^\]]+\]": (val) => new Changes(val),
  r"type:[-\w]+": (val) => new Type(val.split(':').last),
  r"uses:\w+": (_) => null,
});

/** Parses hydrogen instructions into SSA name, opcode and operands. */
parseHir(line) {
  final m = hirLineRe.firstMatch(line);
  if (m == null) return null;

  final id = m.group(1);
  final opcode = m.group(2);
  final operands = m.group(3);

  return new IR.Instruction(line, id, opcode, hirOperands(operands));
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
