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

import 'dart:html' as html;

import 'package:observe/observe.dart';
import 'package:liquid/liquid.dart';
import 'package:liquid/vdom.dart' as v;

import 'package:saga/src/flow/cpu_register.dart';
import 'package:saga/src/flow/node.dart' as node;
import 'package:saga/src/util.dart';

render(html.Element pane, Map<String, node.BB> blocks) {
  pane.children.clear();
  injectComponent(new App()..blocks = blocks.values.toList(), pane);
}

class App extends Component {
  List<node.BB> blocks;

  void init() {
    Node.nodes.clear();
  }

  build() {
    return v.root()(blocks.map((block) {
      return vBlock(block: block, key: "B${block.id}");
    }));
  }
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


/*
renderRef(def) {
  final node = Node.toPresentation(def);
  if (node.isInline) {
    return renderNode(def);
  } else {
    return Result.atom(node);
  }
}
 */

Node renderRef(def) => Node.toPresentation(def);

Node renderUse(use) => renderRef(use.def);

Result renderNode(def) {
  final cb = nodeRendering[def.op.typeTag];
  if (cb != null) {
    return cb(def);
  }
  return Result.atom("{$def}");
}

final vKonstant = (txt) => v.span(classes: ['ir-node-konstant'])(txt);
final vOp = (txt) => v.span(classes: ['ir-node-op'])(txt);
final vKeyword = (txt) => v.span(classes: ['ir-node-keyword'])(txt);

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
      return Result.atom([vKeyword("if "), condition, vKeyword(" then "), node.op.thenTarget.toString(), vKeyword(" else "), node.op.elseTarget.toString()]);
    } else {
      return Result.atom([vKeyword("if "), condition, vKeyword(" then "), node.op.thenTarget.toString()]);
    }
  },
  "OpGoto": (node) {
    return Result.atom([vKeyword("goto "), node.op.target.toString()]);
  },
  "OpSelectIf": (node) {
    final condition = Result.binary(renderUse(node.inputs[0]),
                                    Operator.BINARY_OPERATORS[node.op.condition],
                                    renderUse(node.inputs[1]));
    return Result.atom([vKeyword("if "), condition, vKeyword(" then "), renderUse(node.inputs[2]), vKeyword(" else "), renderUse(node.inputs[3])]);
  },
  "OpUnpack": (node) {
    return Result.atom([vOp("unpack"), "(", renderUse(node.inputs[0]), ")"]);
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
      this.name = CpuRegister.kNames[origin.op.n].toLowerCase();
    }
  }

  get canBeInlined {
    return origin.op != node.PHI && !isHidden;
  }

  get hasSingleUse => useCount == 1;

  get isUsed => useCount > 0;

  get isNamed => !isInline && isUsed;

  get isVisible => !isInline && !isHidden && (isUsed || origin.hasEffect);

  static final Map<int, Node> nodes = new Map<int, Node>();

  static toPresentation(node.Node n) {
    return nodes.putIfAbsent(n.id, () => new Node(n, "v${n.id}"));
  }

  toString() => "Node(${origin})";
}

final vEditableName = v.componentFactory(EditableName);
class EditableName extends Component {
  @property() var entity;

  bool editing = false;

  void create() { element = new html.SpanElement(); }

  void init() {
    element.onDoubleClick.listen((e) => startEditing());

    element.onKeyDown.listen((e) {
      if (e.keyCode == html.KeyCode.ENTER) {
        endEditing();
      } else if (e.keyCode == html.KeyCode.ESC) {
        endEditing(apply: false);
      }
    });

    element.onBlur.capture((e) => endEditing());
  }

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
        entity.name = element.text;
      }
    }
  }

  build() => v.root()(v.span()(entity.name));
}

abstract class InvalidationMixin {
  var subscriptions;

  _unsubscribe() {
    if (subscriptions != null) {
      for (var subscription in subscriptions)
        subscription.cancel();
      subscriptions = null;
    }
  }

  get dependencies;

  void invalidate();

  void updated() {
    _unsubscribe();
    subscriptions = dependencies.map((obj) =>
      obj.changes.listen((_) => invalidate())).toList();
  }

  detached() {
    _unsubscribe();
  }
}

var NodeRefId = 0;

final vNodeRef = v.componentFactory(NodeRef);
class NodeRef extends Component with InvalidationMixin {
  @property() Node node;
  @property() var parens;

  void create() { element = new html.SpanElement(); }

  void init() {
    element.onClick.matches('.inline-marker').listen((e) {
      node.isInline = true;
    });
  }

  get dependencies => [node];

  build() {
    if (node.isInline) {
      return v.root()(vNodeBody(node: node, parens: parens));
    } else {
      final children = [vEditableName(entity: node, classes: ['ir-node-name'])];
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
  }

  updated() {
    element.classes.remove("node-body-hover");
  }

  build() {
    final children = [];

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
class NodeComponent extends Component {
  @property() Node node;

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
class BlockComponent extends Component {
  @property() node.BB block;

  var nodes;

  void init() {
    nodes = []
      ..addAll(block.phis.map(Node.toPresentation))
      ..addAll(block.code.map(Node.toPresentation));
    nodes.forEach((node) => onPropertyChange(node, #isInline, invalidate));
  }

  build() {
    final vnodes = intersperse(nodes.where((node) => node.isVisible).map(buildNode), () => v.text('\n'));
    return v.root()([
      v.text(block.name),
      v.text('\n'),
      v.div(classes: ['ir-block-body'])(vnodes),
      v.text('\n\n')
    ]);
  }

  static buildNode(Node node) => vNode(node: node);
}
