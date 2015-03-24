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

/** Parsing perf annotate output. */
library perf;

import 'dart:math' as math;

import 'package:irhydra/src/modes/code.dart' as code;
import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:ui_utils/parsing.dart' as parsing;

class MethodProfile {
  final name;
  final lastOffset;
  final Map<int, double> ticks;
  final totalTicks;

  MethodProfile(this.name, this.lastOffset, this.ticks, this.totalTicks);

  toString() => "${name}#${lastOffset}";
}

class IRProfile {
  final Map<String, double> blockTicks;
  final Map<IR.Instruction, double> hirTicks;
  final double maxHirTicks;

  IRProfile(this.blockTicks, hirTicks)
      : hirTicks = hirTicks, maxHirTicks = hirTicks.values.fold(0.0, math.max);
}

class Profile {
  final items = <MethodProfile>[];

  attachAll(mode, methods) {
    print("Attaching profile to methods.");
    print("  profile");
    for (var p in items) {
      print("   -- ${p.name} #${p.lastOffset}");
    }

    print("  methods");
    for (var method in methods) {
      if (method.phases.isEmpty || method.phases.last.code == null) continue;

      final lastOffset = mode.lastOffset(method.phases.last.code);
      final p = _lookup(method.name.full, lastOffset);
      print("   -- ${method.name.full} ${lastOffset} -> ${p != null ? 'found' : 'not-found'}");

      method.perfProfile = p;
    }
    print(" // done");
  }

  _lookup(name, lastOffset) {
    name = name.replaceAll(".dart", "")
               .replaceAll(":", ".");
    return items.firstWhere((p) {
      return (name.contains(p.name) ||
              name.contains(p.name.replaceAll(new RegExp(r"^[^_]*_"), ""))) &&
          lastOffset == p.lastOffset;
    }, orElse: () => null);
  }

  attachTo(IR.ParsedIr ir) {
    if (ir.code == null) {
      return;
    }

    final profile = _lookup(ir.method.name.full, ir.code.last.offset);
    if (profile == null) {
      return;
    }

    final hirTicks = <IR.Instruction, double>{};
    final blockTicks = <String, double>{};

    costOf(instr) {
      if (instr is IR.Instruction) {
        if (instr.code == null) {
          return 0.0;
        } else {
          return instr.code.map(costOf).fold(0.0, (total, ticks) => total + ticks);
        }
      } else if (instr is code.Instruction || instr is code.Jump) {
        final ticks = profile.ticks[instr.offset];
        return ticks == null ? 0.0 : ticks;
      } else {
        return 0.0;
      }
    }

    for (var blockKey in ir.blocks.keys) {
      var block = ir.blocks[blockKey];
      var currentBlockTicks = 0.0;
      for (var instr in block.hir) {
        final ticks = costOf(instr);
        if (ticks > 0.0) {
          hirTicks[instr] = ticks;
        }
        currentBlockTicks += ticks;
      }

      if (currentBlockTicks > 0.0) {
        blockTicks[blockKey] = currentBlockTicks;
      }
    }

    ir.profile = new IRProfile(blockTicks, hirTicks);
  }
}

parse(String source) {
  final p = new PerfParser(source);
  p.parse();
  return p.profile;
}

class PerfParser extends parsing.ParserBase {
  final profile = new Profile();

  PerfParser(String source) : super(source.split("\n"));

  var _lastSum;

  get patterns => {
    r"h\->sum: (\d+)": (total) {
      _lastSum = int.parse(total);
    },

    r"^\s+:\s+0+\s+<(\*?)([^>]+)>:": (opt, name) {
      final lazyCompileRe = new RegExp(r"LazyCompile:\*(\S+)");
      if (lazyCompileRe.hasMatch(name)) {
        final m = lazyCompileRe.firstMatch(name);
        name = m.group(1);
        opt = "*";
      }

      if (opt != "*") {
        return;  // For now we are interested only in optimized code.
      }

      var lastOffset;
      final ticks = new Map<int, double>();
      enter({
        r"^\s*(\d+.\d+)\s+:\s+([a-f0-9]+):": (percent, offset) {
          ticks[lastOffset = int.parse(offset, radix: 16)] = double.parse(percent);
        },

        r"": () {
          profile.items.add(new MethodProfile(name, lastOffset, ticks, _lastSum));
          leave(backtrack: 1);
        }
      });
    }
  };
}

