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

import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:irhydra/src/parsing.dart' as parsing;

bool canRecognize(String str) =>
  str.contains("begin_cfg") && str.contains("begin_compilation");

List<IR.Method> parse(String str) =>
  (new HydrogenParser(str)..parse()).methods;

class HydrogenParser extends parsing.ParserBase {
  final methods = [];

  var method;
  var phase;

  var builder;
  var block;

  HydrogenParser(str) : super(str.split("\n"));

  get patterns => {
    "begin_compilation": {
      r'name "([^"]*)"': (name) {
        method = new IR.Method(new IR.Name.fromFull(name));
        methods.add(method);
      },

      "end_compilation": () => leave()
    },

    "begin_cfg": {
      r'name "([^"]*)"': (name) {
        phase = new IR.Phase(name);
        method.phases.add(phase);
        builder = new IR.CfgBuilder();
      },

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

          r"^\s+\d+\s+(\w\d+)\s+(.*)$": (name, args) {
            block.hir.add(" 0 0 $name Phi $args <|@");
          }
        },

        "begin_HIR": {  // Hydrogen IR.
          "end_HIR": () {
            block.hir.addAll(subrange());
            leave();
          }
        },

        "begin_LIR": {  // Lithium IR.
          "end_LIR": () {
            block.lir.addAll(subrange());
            leave();
          }
        },

        "end_block": () {
          block = null;
          leave();
        }
      },

      r"end_cfg": () {
        phase.ir = builder.blocks;
        builder = phase = null;
        leave();
      }
    }
  };
}
