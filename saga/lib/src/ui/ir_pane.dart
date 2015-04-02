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

library saga.ui.ir_pane;

import 'dart:async';
import 'dart:html' as html;

import 'package:observe/observe.dart';
import 'package:liquid/liquid.dart';
import 'package:liquid/vdom.dart' as v;

import 'package:saga/src/flow/cpu_register.dart';
import 'package:saga/src/flow/interference.dart' as interference;
import 'package:saga/src/flow/node.dart' as node;
import 'package:saga/src/ui/tooltip.dart';
import 'package:saga/src/util.dart';

final vIrPane = v.componentFactory(IrPaneComponent);
class IrPaneComponent extends Component<html.PreElement> {
  @property() var flowData;
  @property() var showOnly;

  var tooltip = new NodeRefTooltip();

  create() {
    element = new html.PreElement();
    element.onMouseOver.capture((e) {
      final ref = e.target.attributes['data-ref'];
      if (ref != null) {
        tooltip.show(e.target, Node.nodes[int.parse(ref)]);
      }
    });
    element.onMouseOut.capture((e) {
      final ref = e.target.attributes['data-ref'];
      if (ref != null) tooltip.hide();
    });
  }

  build() {
    Node.setFlowData(flowData);

    final children = intersperseWith(flowData.blocks.values.where(_shouldShow).map((block) =>
        vBlock(block: block,
               key: "B${block.id}",
               attributes: { 'data-block': block.name })), (i) => v.text('\n', key: "T${i}")).toList(growable: true);

    children.add(tooltip.build(key: "Tooltip"));
    return v.root()(children);
  }

  _shouldShow(block) => showOnly == null || showOnly.contains(block.id);
}

class NodeRefTooltip extends Tooltip {
  Node def;

  show(el, def) {
    this.def = def;
    this.target = el;
    this.isVisible = true;
  }

  hide() {
    this.isVisible = false;
  }

  get content => def != null ? v.pre()(vNode(node: def)) : v.pre();
}

class Operator {
  final String symbol;
  final int precedence;
  final bool tight;

  const Operator(this.symbol, this.precedence, {this.tight: false});

  static const ATOM = const Operator('', 0);
  static const DOT = const Operator('.', 2, tight: true);
  static const INDEX = const Operator('[]', 2);
  static const DEREF = const Operator("*", 3);
  static const MUL = const Operator("*", 5);
  static const ADD = const Operator("+", 6);
  static const SUB = const Operator("-", 6);
  static const LT = const Operator("<", 8);
  static const LE = const Operator("<=", 8);
  static const GT = const Operator(">", 8);
  static const GE = const Operator(">=", 8);
  static const AE = const Operator("\u00E6", 8);
  static const EQ = const Operator("==", 9);
  static const NE = const Operator("!=", 9);
  static const BIT_AND = const Operator("&", 10);
  static const BIT_XOR = const Operator("^", 11);
  static const BIT_OR = const Operator("|", 12);
  static const ASSIGN = const Operator("<-", 15);

  static const BINARY_OPERATORS = const {
    "+": ADD,
    "-": SUB,
    "*": MUL,
    "&": BIT_AND,
    "^": BIT_XOR,
    "|": BIT_OR,
    "==": EQ,
    "!=": NE,
    "<": LT,
    ">": GT,
    "<=": LE,
    ">=": GE,
    "ae": AE
  };

  static const BINARY_OPERATOR_NAMES = const {
    "==": "eq",
    "!=": "ne",
    "<": "lt",
    ">": "gt",
    "<=": "le",
    ">=": "ge",
    "ae": "ae"
  };
}

class ContextualRef {
  final ref;
  final needsParens;

  ContextualRef(this.ref, this.needsParens);
}

class Result {
  final Operator operator;
  final chunks;

  Result(this.operator, this.chunks) {
    assert(chunks is List || chunks is Node || chunks is String || chunks is v.VHtmlElement);
  }

  static join(op, arr) {
    return arr.reduce((lhs, rhs) => binary(lhs, op, rhs));
  }

  static withParen(result, value, bool cond(Operator op)) {
    if (value is Node) {
      result.add(new ContextualRef(value, cond));
      return;
    }
    assert(value is Result);
    final needsParen = cond(value.operator);
    if (needsParen) {
      result.add('(');
    }
    result.add(value);
    if (needsParen) {
      result.add(')');
    }
  }

  static binary(lhs, op, rhs) {
    final result = [];

    withParen(result, lhs, (refOp) => refOp.precedence > op.precedence);
    result.add(vKeyword(op.tight ? op.symbol : " ${op.symbol} "));
    withParen(result, rhs, (refOp) => refOp.precedence >= op.precedence && refOp != op);

    return new Result(op, result);
  }

  static unary(op, Node val) {
    return new Result(op, [op.symbol, new ContextualRef(val, (refOp) => op.precedence < refOp.precedence)]);
  }

  static mixfix(op, Node lhs, openSymbol, Node rhs, closeSymbol) {
    final result = [];

    result.add(new ContextualRef(lhs, (refOp) => refOp.precedence > op.precedence));
    result.add(openSymbol);
    result.add(rhs);
    result.add(closeSymbol);

    return new Result(op, result);
  }

  static atom(chunks) {
    return new Result(Operator.ATOM, chunks);
  }

  static flattenChunk(f, chunks) {
    if (chunks is List) {
      for (var chunk in chunks) {
        flattenChunk(f, chunk);
      }
    } else if (chunks is Result) {
      flattenChunk(f, chunks.chunks);
    } else {
      f(chunks);
    }
  }

  flattenWith(f) => flattenChunk(f, chunks);

  toString() => chunks is String ? chunks : chunks.join('');
}

Node renderRef(def) => Node.toPresentation(def);

Node renderUse(use) => renderRef(use.def);

Result renderNode(def) {
  final cb = nodeRendering[def.op.typeTag];
  if (cb != null) {
    return cb(def);
  }
  return Result.atom("{$def}");
}

vKonstant(txt) => v.span(classes: const ['ir-node-konstant'])(txt);
vOp(txt) => v.span(classes: const ['ir-node-op'])(txt);
vKeyword(txt) => v.span(classes: const ['ir-node-keyword'])(txt);
vBlockName(bb) => v.span(classes: const ['ir-block-name'])("${bb}");

final nodeRendering = {
  "OpKonstant": (node) {
    return Result.atom(vKonstant(node.op.value.toString()));
  },
  "OpArg": (node) {
    return Result.atom(CpuRegister.kNames[node.op.n]);
  },
  "OpPhi": (node) {
    return Result.atom([vOp("\u03C6"), "("]..addAll(intersperseValue(node.inputs.map(renderUse), ", "))..add(")"));
  },
  "OpAddr": (node) {
    final result = [];

    final base = node.inputs[0].def;
    final index = node.inputs[1].def;

    if (base != null) result.add(renderRef(base));
    if (index != null) {
      if (node.op.scale != 1) {
        result.add(Result.binary(renderRef(index), Operator.MUL, Result.atom(vKonstant(node.op.scale.toString()))));
      } else {
        result.add(renderRef(index));
      }
    }

    if (result.length == 0) {
      return Result.atom(vKonstant(node.op.offset.toString()));
    } else {
      final offset = node.op.offset;
      final negate = offset < 0;
      return Result.binary(Result.join(Operator.ADD, result),
          negate ? Operator.SUB : Operator.ADD,
          Result.atom(vKonstant(negate ? (-offset).toString() : offset.toString())));
    }

    return Result.join(Operator.ADD, result);
  },
  "OpBinaryArith": (node) {
    final lhs = renderUse(node.inputs[0]);
    final op = Operator.BINARY_OPERATORS[node.op.opkind];
    final rhs = renderUse(node.inputs[1]);
    if (op == null) {
      return Result.atom([vOp(node.op.opkind), "(", lhs, ", " , rhs, ")"]);
    }
    return Result.binary(lhs, op, rhs);
  },
  "OpLoad": (node) {
    return Result.unary(Operator.DEREF, renderUse(node.inputs[0]));
  },
  "OpStore": (node) {
    return Result.binary(Result.unary(Operator.DEREF, renderUse(node.inputs[0])), Operator.ASSIGN, renderUse(node.inputs[1]));
  },
  "OpReturn": (node) {
    return Result.atom([vKeyword("return "), renderUse(node.inputs[0])]);
  },
  "OpBranchIf": (node) {
    final condition = Result.binary(renderUse(node.inputs[0]),
                                    Operator.BINARY_OPERATORS[node.op.condition],
                                    renderUse(node.inputs[1]));
    if (node.op.elseTarget != null) {
      return Result.atom([vKeyword("if "), condition, vKeyword(" then "), vBlockName(node.op.thenTarget), vKeyword(" else "), vBlockName(node.op.elseTarget)]);
    } else {
      return Result.atom([vKeyword("if "), condition, vKeyword(" then "), vBlockName(node.op.thenTarget)]);
    }
  },
  "OpGoto": (node) {
    return Result.atom([vKeyword("goto "), vBlockName(node.op.target)]);
  },
  "OpSelectIf": (node) {
    final condition = Result.binary(renderUse(node.inputs[0]),
                                    Operator.BINARY_OPERATORS[node.op.condition],
                                    renderUse(node.inputs[1]));
    return Result.atom([vKeyword("if "), condition, vKeyword(" then "), renderUse(node.inputs[2]), vKeyword(" else "), renderUse(node.inputs[3])]);
  },
  "OpSelect": (node) {
    final condition = Result.binary(renderUse(node.inputs[0]),
                                    Operator.DOT,
                                    Result.atom(Operator.BINARY_OPERATOR_NAMES[node.op.condition]));
    return Result.atom([vKeyword("if "), condition, vKeyword(" then "), renderUse(node.inputs[1]), vKeyword(" else "), renderUse(node.inputs[2])]);
  },
  "OpUnpack": (node) {
    return Result.atom([vOp("unpack"), "(", renderUse(node.inputs[0]), ")"]);
  },
  "OpFlags": (node) {
    return Result.atom([vOp("flags"), "(", renderUse(node.inputs[0]), ")"]);
  },
  "OpLoadElement": (node) {
    return Result.mixfix(Operator.INDEX, renderUse(node.inputs[0]), "[", renderUse(node.inputs[1]), "]");
  },
  "OpLoadField": (node) {
    return Result.binary(renderUse(node.inputs[0]), Operator.DOT, Result.atom(node.op.field.name));
  }
};

class Node extends Observable {
  final node.Node origin;
  final int useCount;
  final bool isHidden;

  @observable String name;
  @observable bool isInline = false;

  Node(origin, this.name)
    : origin = origin,
      useCount = origin.nonPhantomUses.length,
      isHidden = origin.op is node.OpArg {
    isInline = origin.op is node.OpKonstant ||
        origin.op is node.OpAddr;
    if (origin.op is node.OpArg) {
      if (origin.op.name != null) {
        this.name = origin.op.name;
      } else {
        this.name = CpuRegister.kNames[origin.op.n].toLowerCase();
      }
    }
  }

  get canBeInlined {
    return origin.op != node.PHI && !isHidden;
  }

  get canBeOutlined {
    return origin.op is! node.OpKonstant &&
        origin.op is! node.OpAddr;
  }

  get hasSingleUse => useCount == 1;

  get isUsed => useCount > 0;

  get isNamed => !isInline && isUsed;

  get isVisible => !isInline && !isHidden && (isUsed || origin.hasEffect);

  interferesWith(otherId) =>
    flowData.interference.contains(new interference.Edge(origin.id, otherId));

  bool canRenameTo(newName) {
    if (name == newName) {
      return true;
    }

    final conflicts = names[newName];
    if (conflicts == null) {
      return true;
    }

    if (conflicts is num) {
      return !interferesWith(conflicts);
    }

    for (var otherId in conflicts) {
      if (interferesWith(otherId)) {
        return false;
      }
    }

    return true;
  }

  renameTo(newName) {
    if (name == newName) {
      return;
    }

    assert(canRenameTo(newName));
    final oldConflicts = names[name];
    if (oldConflicts is num) {
      assert(oldConflicts == origin.id);
      names[name] = null;
    } else {
      oldConflicts.remove(origin.id);
    }

    final newConflicts = names[newName];
    if (newConflicts == null) {
      names[newName] = origin.id;
    } else if (newConflicts is num) {
      names[newName] = new Set.from([origin.id, newConflicts]);
    } else {
      names[newName].add(origin.id);
    }

    name = newName;
  }

  static var flowData;
  static final Map<String, dynamic> names = new Map<String, dynamic>();
  static final Map<int, Node> nodes = new Map<int, Node>();

  static setFlowData(fd) {
    flowData = fd;
    names.clear();
    nodes.clear();
  }

  static toPresentation(node.Node n) {
    return nodes.putIfAbsent(n.id, () {
      final node = new Node(n, "v${n.id}");
      names["v${n.id}"] = n.id;
      return node;
    });
  }
}

final vEditableName = v.componentFactory(EditableName);
class EditableName extends Component {
  @property() var refId;
  @property() var entity;

  bool editing = false;

  void create() { element = new html.SpanElement(); }

  void init() {
    element.onDoubleClick.listen((e) => startEditing());

    element.onKeyDown.listen((e) {
      if (e.keyCode == html.KeyCode.ENTER) {
        if (!isValidName) {
          e.preventDefault();
          e.stopPropagation();
          element.focus();
          return;
        }

        endEditing();
      } else if (e.keyCode == html.KeyCode.ESC) {
        element.classes.remove("invalid-name");
        endEditing(apply: false);
      }
    });

    element.onBlur.capture((e) {
      if (!isValidName) {
        e.preventDefault();
        e.stopPropagation();
        element.focus();
        return;
      }

      endEditing();
    });

    element.onInput.listen((e) {
      element.classes.toggle("invalid-name", !isValidName);
    });
  }

  get isValidName => entity.canRenameTo(element.text);

  startEditing() {
    if (!editing) {
      element.contentEditable = "true";
      element.focus();
      editing = true;
    }
  }

  endEditing({apply: true}) {
    if (editing) {
      editing = false;
      element.contentEditable = "false";
      if (apply) {
        entity.renameTo(element.text);
      } else {
        element.text = entity.name;
      }
    }
  }

  build() => v.root(attributes: refId != null ? {'data-ref': refId} : null)(entity.name);
}

abstract class InvalidationMixin {
  var subscriptions;

  Iterable<StreamSubscription> subscribe() =>
    dependencies.map((obj) => obj.changes.listen((_) => invalidate()));

  _unsubscribe() {
    if (subscriptions != null) {
      for (var subscription in subscriptions)
        subscription.cancel();
      subscriptions = null;
    }
  }

  _resubscribe() {
    subscriptions = subscribe().toList(growable: false);
  }

  get dependencies => [];

  void invalidate();

  init() => _resubscribe();

  updated() {
    _unsubscribe();
    _resubscribe();
  }

  detached() {
    _unsubscribe();
  }
}

final vNodeRef = v.componentFactory(NodeRef);
class NodeRef extends Component with InvalidationMixin {
  @property() Node node;
  @property() var parens;

  get dependencies => [node];

  void create() { element = new html.SpanElement(); }

  void init() {
    super.init();
    element.onClick.matches('.inline-marker').listen((e) {
      node.isInline = true;
    });
  }


  build() {
    if (node.isInline) {
      return v.root()(vNodeBody(node: node, parens: parens));
    } else {
      final children = [vEditableName(entity: node, classes: ['ir-node-name'], refId: "${node.origin.id}")];
      if (node.canBeInlined) {
        final classes = ['inline-marker'];
        if (node.hasSingleUse) classes.add('single-use');
        children.add(v.span(classes: classes)("\u25BC"));
      }
      return v.root()(children);
    }
  }
}

final vNodeBody = v.componentFactory(NodeBodyComponent);
class NodeBodyComponent extends Component {
  @property() Node node;
  @property() var parens;

  create() { element = new html.SpanElement(); }

  init() {
    element.onMouseOver.listen((e) {
      element.classes.add("node-body-hover");
      e.stopPropagation();
    });
    element.onMouseOut.listen((e) {
      element.classes.remove("node-body-hover");
      e.stopPropagation();
    });
    element.onClick.matches(".outline-marker").listen((e) {
      if (node.canBeOutlined) node.isInline = false;
      e.stopPropagation();
    });
  }

  updated() {
    element.classes.remove("node-body-hover");
  }

  build() {
    final children = [];

    if (node.canBeOutlined && node.isInline) {
      children.add(v.span(classes: ['outline-marker'])("\u25B2"));
    }

    final res = renderNode(node.origin);
    final needsParen = parens != null && parens(res.operator);

    var str = null;
    append(suffix) { str = (str == null) ? suffix : str + suffix; }
    flush() {
      if (str != null) {
        children.add(v.text(str));
        str = null;
      }
    }

    if (needsParen) append('(');
    res.flattenWith((val) {
      if (val is String) {
        append(val);
      } else if (val is Node) {
        flush();
        children.add(vNodeRef(node: val, classes: ["ir-use"]));
      } else if (val is ContextualRef) {
        flush();
        children.add(vNodeRef(node: val.ref, parens: val.needsParens, classes: ["ir-use"]));
      } else {
        flush();
        children.add(val);
      }
    });
    if (needsParen) append(')');
    flush();

    return v.root(classes: [])(children);
  }
}

final vNode = v.componentFactory(NodeComponent);
class NodeComponent extends Component with InvalidationMixin {
  @property() Node node;

  get dependencies => [node];

  create() { element = new html.SpanElement(); }

  build() =>
    v.root()(node.isNamed ? [
      vEditableName(entity: node, classes: ['ir-node-name']),
      vKeyword(" <- "),
      vNodeBody(node: node)
    ] : [
      vNodeBody(node: node)
    ]);
}

final vBlock = v.componentFactory(BlockComponent);
class BlockComponent extends Component with InvalidationMixin {
  @property() node.BB block;

  var nodes;

  subscribe() => nodes == null ? const [] :
    nodes.map((node) => onPropertyChange(node, #isInline, invalidate));

  build() {
    nodes = []
      ..addAll(block.phis.map(Node.toPresentation))
      ..addAll(block.code.map(Node.toPresentation));

    final vnodes = intersperse(nodes.where((node) => node.isVisible).map(buildNode), () => v.text('\n'));
    return v.root()([
      v.span(classes: const ['ir-block-name'])("${block.name}:\n"),
      v.div(classes: const ['ir-block-body'])(vnodes),
    ]);
  }

  static buildNode(Node node) => vNode(node: node);
}
