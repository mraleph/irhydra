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

/** Parsing llprof.py output. */
library llprof;

import 'package:irhydra/src/parsing.dart' as parsing;

parse(String source) {
  final p = new LLProfParser(source);
  p.parse();
  return p.items;
}

class MethodProfile {
  final name;
  final ticksTotal;
  final lastOffset;
  final ticks;

  MethodProfile(this.name, this.ticksTotal, this.lastOffset, this.ticks);

  toString() => "${name}#${lastOffset} (${ticksTotal})";
}

class LLProfParser extends parsing.ParserBase {
  final items = <MethodProfile>[];

  LLProfParser(String source) : super(source.split("\n"));

  get patterns => {
    r"^\s+(\d+)\s+(\d+\.\d+)%\s+(\*?)([^ ]+)\s+\[(.+)\]": (ticksTotal, percent, opt, name, lib) {
      if (lib != "js" || opt != "*") {
        return;  // For now we are interested only in optimized Dart code.
      }

      var lastOffset;
      final ticks = new Map<int, double>();
      enter({
        r"\s+(\d+\.\d+)\s+([a-f0-9]+):": (percent, offset) {
          ticks[int.parse(offset, radix: 16)] = double.parse(percent);
          lastOffset = offset;
        },

        r"\s+([a-f0-9]+):": (offset) {
          lastOffset = offset;
        },

        r"": () {
          if (lastOffset != null) {
            lastOffset = int.parse(lastOffset, radix: 16);
          }

          items.add(new MethodProfile(name, int.parse(ticksTotal), lastOffset, ticks));
          leave(backtrack: 1);
        }
      });
    }
  };
}

