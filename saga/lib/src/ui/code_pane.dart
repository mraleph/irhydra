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

library saga.ui.code_pane;

import 'dart:html';

import 'package:liquid/liquid.dart';
import 'package:liquid/vdom.dart' as v;
import 'package:ui_utils/bootstrap.dart' as bs;
import 'package:ui_utils/delayed_reaction.dart';
import 'package:ui_utils/xref.dart';

import 'package:saga/src/parser.dart' as parser;
import 'package:saga/src/util.dart';


render(Element pane, flowData, {keepScroll: false}) {
  final codePane = new CodePane()..flowData = flowData;
  if (keepScroll) {
    final scroll = pane.scrollTop;
    codePane.whenRendered = () => pane.scrollTop = scroll;
  }

  pane.nodes.clear();
  injectComponent(codePane, pane);
}

vLabel(txt) => v.span(classes: const ['asm-label'])(txt);
vKeyword(txt) => v.span(classes: const ['asm-opcode'])(txt);

final vCallTarget = v.componentFactory(CallTargetComponent);
class CallTargetComponent extends Component {
  @property() parser.CallTarget callTarget;

  create() {
    element = new SpanElement();
  }

  var menuVisible = false;
  final delayedHide = new DelayedReaction(delay: const Duration(milliseconds: 150));

  hideMenu() {
    delayedHide.schedule(() {
      bs.popover(element).destroy();
      menuVisible = false;
    });
  }

  init() {
    element.onMouseOver.listen((_) {
      if (!menuVisible) {
        var po = bs.popover(element, {
          "title": '',
          "content": parser.CallTargetAttribute.values.map((attr) => "<button class='${callTarget.attributes.contains(attr) ? 'set' : ''}' data-attr='${attr.name}'>((${attr}))</button>"),
          "trigger": "manual",
          "placement": "top",
          "html": true,
          "container": element
        })..show();
        po.tip.onMouseOver.listen((_) => delayedHide.cancel());
        po.tip.onMouseOut.listen((_) => hideMenu());
        menuVisible = true;
      } else {
        delayedHide.cancel();
      }
    });
    element.onMouseOut.listen((_) => hideMenu());

    element.onClick.listen((e) {
      final attrName = e.target.attributes['data-attr'];
      if (attrName != null) {
        final attr = parser.CallTargetAttribute.parse(attrName);
        callTarget.toggleAttribute(attr);
      }
    });
  }

  build() =>
    v.root(classes: const ['asm-call-target'])(callTarget.target);
}

class CodePane extends Component {
  var flowData;

  var whenRendered;
  rendered() {
    if (whenRendered != null) {
      whenRendered();
      whenRendered = null;
    }
  }

  var entities = {};
  var entitiesArray = [];

  void init() {
    lookup(def) {
      /*if (def is flow.Use) {
        return lookup(def.def);
      } if (def is flow.Phi) {
        return "<small>${def}</small>\n" + def.inputs.where((v) => v.def != def).map(lookup).join('\n');
      } else if (def is flow.Select) {
        return [lookup(def.thenValue),
                lookup(def.elseValue),
                lookup(def.inputs[0].def),
                "${def.origin} in ${def.block.origin.name}"].join('\n');
      } else if (def.origin != null) {
        return "${def.origin} in ${def.block.origin.name}";
      }*/
      return def.toString();
    }

    element.onMouseOver.listen((e) {
      final key = e.target.attributes['data-entity'];
      if (key != null) {
        final use = flowData.refUses[entities[key]];
        if (use != null && use.def != null) {
          final text = lookup(use.def);
          if (text != null) {
            POPOVER.show(e.target, "<pre>${text}</pre>");
          }
        }
      }
    });

    element.onMouseOut.listen((e) {
      final key = e.target.attributes['data-entity'];
      if (key != null) {
        POPOVER.destroy(e.target);
      }
    });
  }

  build() {
    entities.clear();
    var children = [];
    for (var block in flowData.blocks.values) buildBlock(children, block);
    return v.root()(children);
  }

  toEntity(ref) {
    final key = "${entities.length}";
    entities[key] = ref;
    return key;
  }

  List<v.VNode> formatOperand(val) {
    if (val is parser.RegRef) {
      return [v.span(classes: const ['asm-register'], attributes: {"data-entity": toEntity(val)})(val.name)];
    } else if (val is parser.Addr) {
      final List<v.VNode> result = [v.text("[")];
      if (val.base != null) result.addAll(formatOperand(val.base));
      if (val.index != null) {
        if (val.base != null) result.add(v.text(" + "));
        result.addAll(formatOperand(val.index));
        if (val.scale != 1) {
          result.add(v.text("*"));
          result.add(v.span(classes: const ['asm-immediate'])("${val.scale}"));
        }
      }
      if (val.offset != null && val.offset != 0) {
        final isAbsolute = val.base == null && val.index == null;
        var offset = val.offset;
        if (!isAbsolute) {
          var negative = false;
          if (offset.startsWith("-")) {
            negative = true;
            offset = offset.substring(1);
          }
          result.add(v.text(" ${negative ? '-' : '+'} "));
        }
        result.add(v.span(classes: const ['asm-immediate'])(offset));
      }
      result.add(v.text(']'));
      return result;
    } else if (val is parser.Imm) {
      return [v.span(classes: const ['asm-immediate'])(val.value)];
    } else if (val is parser.CallTarget) {
      return [vCallTarget(callTarget: val)];
    } else {
      throw "error: ${val.runtimeType}";
    }
  }

  List<v.VNode> format(op) {
    if (op.opcode.startsWith("j")) {
      return [vKeyword(op.opcode), v.text(" "), vLabel("->${op.operands.first}")];
    } else {
      return [vKeyword(op.opcode), v.text(" ")]
        ..addAll(intersperse(op.operands.reversed.map(formatOperand), () => [v.text(', ')]).expand((l) => l));
    }
  }

  buildBlock(List<v.VNode> result, block) {
    result.add(vLabel("${block.name}:"));
    if (block.predecessors.length > 1) {
      result.add(v.text(" ("));
      result.addAll(intersperse(block.predecessors.map((p) => vLabel("${p.name}")), () => v.text(", ")));
      result.add(v.text(")"));
    }
    result.add(v.text("\n"));
    for (var op in block.asm) {
      result
        ..add(v.text("  "))
        ..addAll(format(op))
        ..add(v.text("\n"));
    }
    result.add(v.text("\n"));
  }
}