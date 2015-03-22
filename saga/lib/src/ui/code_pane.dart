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
import 'package:ui_utils/delayed_reaction.dart';

import 'package:saga/src/flow/node.dart' as node;
import 'package:saga/src/parser.dart' as parser;
import 'package:saga/src/util.dart';
import 'package:saga/src/ui/tooltip.dart';
import 'package:saga/src/ui/ir_pane/ir_pane.dart' as ir_pane;

vLabel(txt) => v.span(classes: const ['asm-label'])(txt);
vKeyword(txt) => v.span(classes: const ['asm-opcode'])(txt);

final vCallTarget = v.componentFactory(CallTargetComponent);
class CallTargetComponent extends Component {
  @property() parser.CallTarget callTarget;

  create() {
    element = new SpanElement();
  }

  final delayedHide = new DelayedReaction(delay: const Duration(milliseconds: 150));
  final tooltip = new Tooltip(placement: Placement.TOP);

  init() {
    element.onMouseEnter.listen((_) {
      if (!tooltip.isVisible) {
        tooltip.content = _buildButtons;
        tooltip.target = element;
        tooltip.isVisible = true;
      }
      delayedHide.cancel();
    });
    element.onMouseLeave.listen((_) {
      delayedHide.schedule(() {
        tooltip.isVisible = false;
      });
    });

    element.onClick.listen((e) {
      final attrName = e.target.attributes['data-attr'];
      if (attrName != null) {
        final attr = parser.CallTargetAttribute.parse(attrName);
        callTarget.toggleAttribute(attr);
      }
    });
  }

  _buildButtons() =>
    parser.CallTargetAttribute.values.map((attr) =>
      v.button(classes: callTarget.attributes.contains(attr) ? ['set'] : [],
               attributes: {"data-attr": attr.name})(attr.toString()));

  build() =>
    v.root(classes: const ['asm-call-target'])([
      v.text(callTarget.target),
      tooltip.build()
    ]);
}


class Formater {
  final entities;

  Formater(this.entities);

  toEntity(ref) {
    if (entities != null) {
      final key = "${entities.length}";
      entities[key] = ref;
      return key;
    } else {
      return "";
    }
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
}


final vCodePane = v.componentFactory(CodePaneComponent);
class CodePaneComponent extends Component {
  @property() var flowData;

  final formater = new Formater({});

  create() { element = new PreElement(); }

  var whenRendered;
  rendered() {
    if (whenRendered != null) {
      whenRendered();
      whenRendered = null;
    }
  }

  var tooltip;

  void init() {
    lookup(def) {
      if (def is node.Use) {
        return lookup(def.def);
      } if (def.op == node.PHI) {
        assert(false);
        // return "<small>${def}</small>\n" + def.inputs.where((v) => v.def != def).map(lookup).join('\n');
      } else if (def.op is node.OpSelectIf) {
        return [lookup(def.thenValue),
                lookup(def.elseValue),
                lookup(def.inputs[0].def),
                "${def.origin} in ${def.block.origin.name}"].join('\n');
      } else if (def.origin != null) {
        return [v.div()(ir_pane.vNode(node: ir_pane.Node.toPresentation(def)))]
            ..addAll(formater.format(def.origin))
            ..add(v.text(" in ${def.block.name}"));
      }
      return v.text(def.toString()); // [ir_pane.vNode(node: ir_pane.Node.toPresentation(def))];
    }

    element.onMouseOver.listen((e) {
      final key = e.target.dataset['entity'];
      if (key != null) {
        final use = flowData.refUses[formater.entities[key]];
        if (use != null && use.def != null) {
          final text = lookup(use.def);
          if (text != null) {
            tooltip.target = e.target;
            tooltip.content = () => text;
            tooltip.isVisible = true;
          }
        }
      }
    });

    element.onMouseOut.listen((e) {
      final key = e.target.attributes['data-entity'];
      if (key != null) {
        tooltip.isVisible = false;
      }
    });
  }

  build() {
    formater.entities.clear();
    var children = intersperse(flowData.blocks.values.map((block) =>
        vBlock(block: block, formater: formater)), () => v.text('\n')).toList(growable: true);

    tooltip = new Tooltip();
    children.add(vTooltip(data: tooltip));
    return v.root()(children);
  }
}


final vBlock = v.componentFactory(BlockComponent);
class BlockComponent extends Component {
  @property() var block;
  @property() var formater;

  build() {
    final f = formater != null ? formater : new Formater(null);

    List<v.VNode> result = [];
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
        ..addAll(f.format(op))
        ..add(v.text("\n"));
    }
    return v.root()(result);
  }
}