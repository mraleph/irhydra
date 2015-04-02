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
import 'package:saga/src/ui/ir_pane.dart' as ir_pane;

vLabel(txt) => v.span(classes: const ['asm-label'])(txt);
vKeyword(txt) => v.span(classes: const ['asm-opcode'])(txt);

final vCallTarget = v.componentFactory(CallTargetComponent);
class CallTargetComponent extends Component {
  @property() parser.CallTarget callTarget;

  create() {
    element = new SpanElement();
  }

  final delayedHide = new DelayedReaction(delay: const Duration(milliseconds: 150));
  final tooltip = new TooltipWithContent(placement: Placement.TOP);

  init() {
    tooltip.contentBuilder = _buildButtons;
    element.onMouseEnter.listen((_) {
      if (!tooltip.isVisible) {
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
  final pane;
  final entities;

  Formater(this.pane, this.entities);

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
      return [vKeyword(op.opcode), v.text(" "), vLabel("->${pane.flowData.blockMap[op.operands.first]}")];
    } else {
      return [vKeyword(op.opcode), v.text(" ")]
        ..addAll(intersperse(op.operands.reversed.map(formatOperand), () => [v.text(', ')]).expand((l) => l));
    }
  }
}


class EntityTooltip extends Tooltip {
  final pane;

  EntityTooltip(this.pane);

  node.Node def;

  attach(root) {
    root.onMouseOver.listen((e) {
      final key = e.target.dataset['entity'];
      if (key != null) {
        final use = pane.flowData.refUses[pane.formater.entities[key]];
        if (use != null && use.def != null) {
          def = use.def;
          target = e.target;
          isVisible = true;
        }
      }
    });

    root.onMouseOut.listen((e) {
      final key = e.target.attributes['data-entity'];
      if (key != null) {
        isVisible = false;
      }
    });
  }

  show(el, id) {
    target = el;
    isVisible = true;
  }

  hide() {
    isVisible = false;
  }

  get content => def != null ? v.pre()(format(def, new Set())) : v.pre();

  format(node.Node def, visited) {
    if (def.op == node.PHI) {
      final result = [];
      visited.add(def);
      for (var input in def.inputs) {
        if (!visited.contains(input.def)) {
          visited.add(input.def);
          if (result.isNotEmpty) result.add(v.text('\n'));
          result.addAll(format(input.def, visited));
        }
      }
      return result;
    } else if (def.origin != null) {
      final result = pane.showIr ?
          [v.div(classes: const ['tooltip-def'])(ir_pane.vNode(node: ir_pane.Node.toPresentation(def)))] :
          [];
      return result
          ..addAll(pane.formater.format(def.origin))
          ..add(v.text(" in ${def.block.name}"));
    } else if (def.op is node.OpArg) {
      return [v.text("<argument>")];
    }
    return [v.text(def.toString())]; // [ir_pane.vNode(node: ir_pane.Node.toPresentation(def))];
  }
}


final vCodePane = v.componentFactory(CodePaneComponent);
class CodePaneComponent extends Component {
  @property() var flowData;
  @property() var showOnly;
  @property() bool showIr = true;

  Formater formater;
  EntityTooltip tooltip;

  create() { element = new PreElement(); }

  void init() {
    formater = new Formater(this, {});
    tooltip = new EntityTooltip(this);
    tooltip.attach(element);
  }

  build() {
    formater.entities.clear();
    var children = intersperse(flowData.blocks.values.where(_shouldShow).map((block) =>
        vBlock(block: block,
               formater: formater,
               attributes: {'data-block': block.name})), () => v.text('\n')).toList(growable: true);

    children.add(tooltip.build());
    return v.root()(children);
  }

  _shouldShow(block) => showOnly == null || showOnly.contains(block.id);
}


final vBlock = v.componentFactory(BlockComponent);
class BlockComponent extends Component {
  @property() var block;
  @property() var flowData;
  @property() var formater;

  build() {
    final f = formater != null ? formater : new Formater(this, null);

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