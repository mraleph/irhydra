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

library ir_pane;

import 'dart:html' as html;

import 'package:observe/observe.dart';
import 'package:liquid/liquid.dart';
import 'package:liquid/vdom.dart' as v;

import 'package:saga/src/flow/cpu_register.dart';
import 'package:saga/src/flow/node.dart' as node;

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

class Result {
  final Operator operator;
  final chunks;

  Result(this.operator, this.chunks) {
    assert(chunks is List || chunks is Node || chunks is String);
  }

  static join(op, arr) {
    if (arr.length == 1) {
      return arr[0];
    }
    return arr.reduce((Result lhs, Result rhs) => binary(lhs, op, rhs));
  }

  static withParen(result, cond, value) {
    if (cond) {
      result.add('(');
    }
    result.add(value);
    if (cond) {
      result.add(')');
    }
  }

  static binary(Result lhs, op, Result rhs) {
    if (op == Operator.ADD &&
        rhs.operator == Operator.ATOM &&
        rhs.chunks is String &&
        rhs.chunks[0] == "-") {
      op = Operator.SUB;
      rhs = atom(rhs.chunks.substring(1));
    }

    final result = [];

    withParen(result, lhs.operator.precedence > op.precedence, lhs.chunks);
    result.add(op.tight ? op.symbol : " ${op.symbol} ");
    withParen(result, (rhs.operator.precedence >= op.precedence && rhs.operator != op), rhs.chunks);

    return new Result(op, result);
  }

  static unary(op, Result val) {
    if (op.precedence < val.operator.precedence) {
      return new Result(op, [op.symbol, "(", val.chunks, ")"]);
    } else {
      return new Result(op, [op.symbol, val.chunks]);
    }
  }

  static mixfix(op, lhs, openSymbol, rhs, closeSymbol) {
    final result = [];

    withParen(result, lhs.operator.precedence > op.precedence, lhs.chunks);

    result.add(openSymbol);
    result.add(rhs.chunks);
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

Result renderRef(def) {
  final node = Node.toPresentation(def);
  if (node.isInline) {
    return renderNode(def);
  } else {
    return Result.atom(node);
  }
}

Result renderUse(use) => renderRef(use.def);

Result renderNode(def) {
  final cb = nodeRendering[def.op.typeTag];
  if (cb != null) {
    return cb(def);
  }
  return Result.atom("{$def}");
}

final nodeRendering = {
  "OpKonstant": (node) {
    return Result.atom(node.op.value.toString());
  },
  "OpArg": (node) {
    return Result.atom(CpuRegister.kNames[node.op.n]);
  },
  "OpPhi": (node) {
    return Result.atom(["Phi("]..addAll(intersperseValue(node.inputs.map(renderUse), ", "))..add(")"));
  },
  "OpAddr": (node) {
    final result = [];

    final base = node.inputs[0].def;
    final index = node.inputs[1].def;

    if (base != null) result.add(renderRef(base));
    if (index != null) {
      if (node.op.scale != 1) {
        result.add(Result.binary(renderRef(index), Operator.MUL, Result.atom(node.op.scale.toString())));
      } else {
        result.add(renderRef(index));
      }
    }

    if (node.op.offset != 0) {
      result.add(Result.atom(node.op.offset.toString()));
    }

    return Result.join(Operator.ADD, result);
  },
  "OpBinaryArith": (node) {
    final lhs = renderUse(node.inputs[0]);
    final op = Operator.BINARY_OPERATORS[node.op.opkind];
    final rhs = renderUse(node.inputs[1]);
    if (op == null) {
      return Result.atom(["${node.op.opkind}(", lhs, ", " , rhs, ")"]);
    }
    return Result.binary(lhs, op, rhs);
  },
  "OpLoad": (node) {
    return Result.unary(Operator.DEREF, renderRef(node.inputs[0].def));
  },
  "OpStore": (node) {
    return Result.binary(Result.unary(Operator.DEREF, renderRef(node.inputs[0].def)), Operator.ASSIGN, renderRef(node.inputs[1].def));
  },
  "OpReturn": (node) {
    return Result.atom(["return ", renderRef(node.inputs[0].def)]);
  },
  "OpBranchIf": (node) {
    final condition = Result.binary(renderUse(node.inputs[0]),
                                    Operator.BINARY_OPERATORS[node.op.condition],
                                    renderUse(node.inputs[1]));
    if (node.op.elseTarget != null) {
      return Result.atom(["if ", condition, " then ", node.op.thenTarget, " else ", node.op.elseTarget]);
    } else {
      return Result.atom(["if ", condition, " then ", node.op.thenTarget]);
    }
  },
  "OpGoto": (node) {
    return Result.atom(["goto ", node.op.target]);
  },
  "OpSelectIf": (node) {
    final condition = Result.binary(renderUse(node.inputs[0]),
                                    Operator.BINARY_OPERATORS[node.op.condition],
                                    renderUse(node.inputs[1]));
    return Result.atom(["if ", condition, " then ", renderUse(node.inputs[2]), " else ", renderUse(node.inputs[3])]);
  },
  "OpUnpack": (node) {
    return Result.atom(["unpack(", renderUse(node.inputs[0]), ")"]);
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
  final bool used;
  final bool hidden;

  @observable String name;
  @observable bool isInline = false;

  Node(origin, this.name) : origin = origin, used = origin.hasNonPhantomUses, hidden = origin.op is node.OpArg {
    isInline = origin.op is node.OpKonstant ||
        origin.op is node.OpAddr;
    if (origin.op is node.OpArg) {
      this.name = CpuRegister.kNames[origin.op.n].toLowerCase();
    }
  }

  get canBeInlined {
    return origin.op != node.PHI && !hidden;
  }

  get isNamed => !isInline && used;

  get isVisible => !isInline && !hidden && (used || origin.hasEffect);

  static final Map<int, Node> nodes = new Map<int, Node>();

  static toPresentation(node.Node n) {
    return nodes.putIfAbsent(n.id, () => new Node(n, "v${n.id}"));
  }
}

final vNodeRef = v.componentFactory(NodeRef);
class NodeRef extends Component {
  @property() Node node;
  @property() var parent;

  bool _editing = false;
  var nameElement;

  void create() { element = new html.SpanElement(); }

  void init() {
    node.changes.listen((_) => invalidate());

    element.onDoubleClick.matches('.node-name').listen((e) {
      startEditing();
    });

    element.onKeyDown.listen((e) {
      if (e.keyCode == html.KeyCode.ENTER) {
        endEditing();
        e.stopPropagation();
        e.preventDefault();
      }
    });

    element.onBlur.capture((e) => endEditing());

    element.onClick.matches('.inline-marker').listen((e) {
      node.isInline = true;
    });
  }

  startEditing() {
    if (!_editing) {
      nameElement.container.contentEditable = "true";
      nameElement.container.focus();
      _editing = true;
    }
  }

  endEditing() {
    if (_editing) {
      _editing = false;
      nameElement.container.contentEditable = "false";
      node.name = nameElement.container.text;
    }
  }

  build() {
    final children = [
      nameElement = v.span(classes: ['node-name'])(v.text(node.name)),
    ];

    if (node.canBeInlined) {
      children.add(v.span(classes: ['inline-marker'])("\u25BC"));
    }

    return v.root()(children);
  }
}

intersperseValue(it, val) sync* {
  var comma = false;
  for (var v in it) {
    if (comma) yield val; else comma = true;
    yield v;
  }
}

intersperse(it, f) sync* {
  var comma = false;
  for (var v in it) {
    if (comma) yield f(); else comma = true;
    yield v;
  }
}

final vNode = v.componentFactory(NodeComponent);
class NodeComponent extends Component {
  @property() Node node;

  create() { element = new html.SpanElement(); }

  build() {
    var children = [];

    if (node.isNamed) {
      children
        ..add(vNodeRef(node: node))
        ..add(v.text(" <- "));
    }

    final Result res = renderNode(node.origin);

    var str = null;
    res.flattenWith((val) {
      if (val is String) {
        str = (str == null) ? val : (str + val);
        return;
      }

      if (str != null) {
        children.add(v.text(str));
        str = null;
      }

      if (val is Node) {
        onPropertyChange(val, #isInline, invalidate);
        children.add(vNodeRef(node: val, classes: ["ir-use"]));
      } else {
        children.add(v.text('${val.name}'));
      }
    });
    if (str != null) {
      children.add(v.text(str));
      str = null;
    }

    return v.root()(children);
  }

  buildRef(use) {
    if (use.def == null) {
      return v.text('_');
    }

    final pres = Node.toPresentation(use.def);
    if (pres.isInline) {
      return vNode(node: pres);
    } else {
      return vNodeRef(node: pres, classes: ["ir-use"]);
    }
  }
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
    final children = [v.text(block.name), v.text('\n')];
    children.addAll(intersperse(nodes.where((node) => node.isVisible).map(buildNode), () => v.text('\n')));
    children.add(v.text("\n\n"));

    return v.root()(children);
  }

  static buildNode(Node node) => vNode(node: node);
}
