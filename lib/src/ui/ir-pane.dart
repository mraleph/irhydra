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

library ir_pane;

import 'dart:async' as async;
import 'dart:math' as math;
import 'dart:html';

import 'package:irhydra/src/formatting.dart' as formatting;
import 'package:irhydra/src/html_utils.dart' show toHtml, span;
import 'package:irhydra/src/modes/ir.dart' as IR;
import 'package:irhydra/src/modes/code.dart' as code;
import 'package:irhydra/src/task.dart';
import 'package:irhydra/src/xref.dart' as xref;

import 'package:js/js.dart' as js;

import 'package:polymer/polymer.dart';

class FormattingContext {
  final _irDesc;
  get ns => _irDesc.ns;
  final makeBlockRef;
  final makeValueRef;

  FormattingContext(this._irDesc, this.makeBlockRef, this.makeValueRef);

  ir(block) => _irDesc.from(block);

  formatOperand(tag, text) => span("${ns}-${tag}", text);

  format(operand) {
    if (operand is String) {
      return new Text(operand);
    } else {
      return operand.toHtml(this);
    }
  }
}

/**
 * Two column WebComponent used to display IRs and native code line by line.
 *
 * Individual lines or whole ranges can have an identifier associated with them
 * that allows to access these lines content as HTML, apply styles or reference
 * them by an [AnchorElement].
 *
 * First column *gutter* is used to display identifier e.g. block name,
 * SSA name or instruction's offset.
 *
 * Second column is for line's content e.g. instruction body itself.
 */
@CustomTag('ir-pane')
class IRPane extends PolymerElement {
  final applyAuthorStyles = true;

  static const CODE_MODES = const ['split', 'inline', 'none'];

  @published var codeMode;
  @published var ir;

  /** Lines currently added to the component */
  final List<IRPaneLine> _lines = <IRPaneLine>[];

  /** Content ranges for identifiers */
  final Map<String, _Range> _ranges = new Map<String, _Range>();

  /** Root [TableElement] */
  TableElement _table;

  var makeBlockRef;
  var makeValueRef;
  var _renderTask;

  IRPane.created() : super.created() {
    makeBlockRef = xref.makeReferencer(rangeContentAsHtmlFull,
                                       href,
                                       type: xref.POPOVER);
    makeValueRef = xref.makeReferencer(rangeContentAsHtml,
                                       href,
                                       type: xref.TOOLTIP);
    _renderTask = new Task(render, frozen: true);
  }

  enteredView() {
    super.enteredView();
    _table = $['rows'];

    final info = new xref.XRef((x) => x, xref.POPOVER);
    _table.onMouseOver.listen((e) {
      final target = e.target;
      if (!target.attributes.containsKey('data-opcode')) {
        return;
      }

      final ns = target.attributes['data-ns'];
      final opcode = target.attributes['data-opcode'];
      final desc = ir.mode.descriptions.lookup(ns, opcode);
      if (desc != null) {
        info.show(target, desc);
      }
    });

    _table.onMouseOut.listen((e) {
      final target = e.target;
      if (!target.attributes.containsKey('data-opcode')) {
        return;
      }
      info.hide();
    });

    _renderTask.unfreeze();
  }

  irChanged() => _renderTask.schedule();
  codeModeChanged() => _renderTask.schedule();

  render() {
    final stopwatch = new Stopwatch()..start();
    clear();

    if (ir == null) {
      return;
    }

    formatOpcode(ctx, opcode) {
      final element = span('boldy', opcode);
      if (ir.mode.descriptions.lookup(ctx.ns, opcode) != null) {
        element.attributes['data-opcode'] = opcode;
        element.attributes['data-ns'] = ctx.ns;
        element.classes.add("known-opcode");
      }
      return element;
    }

    format(ctx, opcode, operands) =>
      new SpanElement()..append(formatOpcode(ctx, opcode))
                       ..appendText(" ")
                       ..append(new SpanElement()..nodes.addAll(operands.map(ctx.format)));

    addEx(ctx, id, opcode, operands) {
      if (opcode == null) {
        return;
      }

      if (id == null) {
        id = "";
      }

      var ln = add(id, format(ctx, opcode, operands));
      ln.gutter.parentNode.classes.add("${ctx.ns}-gutter");
      ln.text.parentNode.classes.add("${ctx.ns}-line");
    }

    /** Output a [Branch] instruction. */
    addBranch(ctx, instr) {
      final ln = add(" ", new SpanElement()
                    ..append(span("boldy", "if "))
                    ..append(format(ctx, instr.op, instr.args))
                    ..append(span("boldy", " goto "))
                    ..appendText("(")
                    ..append(makeBlockRef(instr.true_successor))
                    ..appendText(", ")
                    ..append(makeBlockRef(instr.false_successor))
                    ..appendText(")"));
      ln.gutter.parentNode.classes.add("${ctx.ns}-gutter");
      ln.text.parentNode.classes.add("${ctx.ns}-line");
    }

    final codeRenderer = new CodeRenderer(this, ir.code);
    final contexts = ir.mode.irs.map((irDesc) =>
        new FormattingContext(irDesc, makeBlockRef, makeValueRef)).toList();
    final lastCtx = contexts.last;

    emitInlineCode(ctx, instr) {
      if (ctx == lastCtx && codeMode == 'inline' && instr.code != null) {
        instr.code.skip(1).forEach(codeRenderer.display);
      }
    }


    if (codeMode != 'none') {
      ir.code.prologue.forEach(codeRenderer.display);
    }

    for (var block in ir.blocks.values) {
      // Block name.
      add(" ", " ");
      add(span('boldy', block.name), " ", id: block.name);

      for (var ctx in contexts) {
        final blockIr = ctx.ir(block);
        if (blockIr.isEmpty) continue;

        var branch = blockIr.last;
        for (var index = 0; index < blockIr.length - 1; index++) {
          final instr = blockIr[index];
          addEx(ctx, instr.id, instr.op, instr.args);
          emitInlineCode(ctx, instr);
        }

        if (branch is IR.Branch) {
          addBranch(ctx, branch);
        } else {
          addEx(ctx, branch.id, branch.op, branch.args);
        }
        emitInlineCode(ctx, branch);
      }

      if (codeMode == 'split') {
        for (var instr in lastCtx.ir(block)) {
          if (instr.code != null) {
            instr.code.forEach(codeRenderer.display);
          }
        }
      }

      createRange(block.name);
    }

    if (codeMode != 'none') {
      add(" ", " ");
      ir.code.epilogue.forEach(codeRenderer.display);
    }

    ir.deopts.forEach(_createDeoptMarkersAt);

    print("IRPane.render() took ${stopwatch.elapsedMilliseconds}");
  }

  /** Create marker for [deopt] at the line corresponding to [deopt.lir.id]. */
  _createDeoptMarkersAt(deopt) {
    if (deopt.lir != null) _createDeoptMarkersAtId(deopt, deopt.lir.id);
    if (deopt.hir != null) _createDeoptMarkersAtId(deopt, deopt.hir.id);
  }

  _createDeoptMarkersAtId(deopt, id) {
    final marker = _createDeoptMarkerFor(deopt);
    marker.attributes["id"] = "deopt-ir-${id}";
    line(id).text.append(marker);
  }

  /** Create marker for [deopt] at the line corresponding to [deopt.lirId]. */
  _createDeoptMarkerFor(deopt) {
    // Create a marker with a popover containing raw deopt information.
    final marker = new SpanElement()
        ..classes.addAll(['label', 'deopt-marker', 'deopt-marker-${deopt.type}'])
        ..text = "deopt";

    final divElement = new PreElement()
        ..appendText(deopt.raw.join('\n'));
    final raw = toHtml(divElement);
    js.context.jQuery(marker).popover(js.map({
      "title": "",
      "content": "${raw}",
      "placement": "bottom",
      "html": true,
      "container": 'body'
    })).data('bs.popover').tip().addClass('deopt');

    return marker;
  }

  formatOperand(tag, text) => span("-${tag}", text);

  /** Generate anchor name for the given identifier */
  href(id) => "ir-${id}";

  /** Return [IRPaneLine] for the given [id] */
  line(id) {
    final range = _ranges[id];
    return (range != null) ? _lines[range.start] : null;
  }

  /**
   * Append a new line with the given [gutter] and [text] content.
   *
   * Associate this line with the [id] and apply [klass] to the newly
   * created row.
   *
   * If [gutter] is a [String] and [id] was not supplied then [gutter]
   * will be used as an [id].
   *
   * Return newly created [IRPaneLine].
   */
  IRPaneLine add(gutter, text, {String id, String klass}) {
    if (gutter is String && (id == null)) {
      id = gutter;
    }

    // Wrap raw strings in Text element.
    gutter = _wrapElement(gutter);
    text = _wrapElement(text);

    // First column content: gutter.
    gutter = new Element.html("<pre/>")..append(
        new AnchorElement()
          ..id = href(id)
          ..nodes.add(gutter)
          ..onClick.listen((event) {
            if (id != null) showRefsTo(id);
          }));


    // Second column content: text.
    text = new Element.html("<pre/>")..nodes.add(text);

    final row = new TableRowElement()
      ..nodes.addAll([
        new TableCellElement()..nodes.add(gutter),
        new TableCellElement()..nodes.add(text)
      ]);

    if (klass != null) {
      row.classes.add(klass);
    }

    // Append the row.
    _table.nodes.add(row);

    final line = new IRPaneLine(gutter, text);
    _lines.add(line);
    if (id != null) _ranges[id] = new _Range(_lines.length - 1);

    return line;
  }

  /** Expand range with identified by [id] to cover the current line */
  createRange(String id) {
    final range = _ranges[id];
    range.length = _lines.length - range.start;
  }

  /**
   * Return content of the range [id] as a raw HTML string.
   *
   * Ranges that a longer than a single row are formatted as a two column table
   * in the same way as the [IRPane] itself.
   *
   * Ranges that consist only a single row will be formatted as table only
   * if [fullRow] is [true].
   */
  String rangeContentAsHtml(String id, {fullRow: false}) {
    final range = _ranges[id];
    if (range == null) {
      return null;
    }

    if (!fullRow && range.length == 1) {
      return toHtml(_lines[range.start].text);
    }

    final table = new TableElement();
    table.classes.add("irpane");
    table.nodes.addAll(
        _table.nodes.sublist(range.start, range.start + range.length)
                    .map((elem) => elem.clone(true)));
    return toHtml(table);
  }

  /** Helper that redirects to [rangeContentAsHtml] with [fullRow] set. */
  String rangeContentAsHtmlFull(String id) =>
    rangeContentAsHtml(id, fullRow: true);

  /** Remove all lines from the pane */
  clear() {
    _table.nodes.clear();
    _lines.clear();
    _ranges.clear();
    closeRefsPanel();
  }

  /** Currently visible [_RefsPanel] showing rows referencing the given row. */
  var _refsPanel;

  /**
   * Display a [_RefsPanel] on the side of this panel showing
   * out of line all rows containing references (links) to the given row id.
   */
  showRefsTo(id) {
    closeRefsPanel();

    // Find all table rows referencing given identifier and clone their content.
    final refs = shadowRoot.querySelectorAll("a[href='#${href(id)}']")
                         .map((node) {
                           while (node != null &&
                                  node is! TableRowElement) {
                             node = node.parent;
                           }
                           return node;
                         })
                         .where((node) => (node != null))
                         .toSet()
                         .map((node) => node.clone(true))
                         .toList();

    if (refs.isEmpty) {
      return;  // No references to display.
    }

    // Convert row anchors to links that jump to the given row.
    for (var node in refs) {
      final anchor = node.query("a[id]");
      anchor.href = "#${anchor.attributes['id']}";
    }

    // Create IRPane styled table that will contain references.
    final refsTable = new TableElement();
    refsTable.classes.add("irpane");
    refsTable.nodes.addAll(refs);

    // Calculate middle baseline for _RefsPanel. It'll be centered at
    // referenced row.
    final gutter = line(id).gutter;
    var baselineOffset = js.context.jQuery(gutter).offset().top +
      gutter.clientHeight ~/ 2;

    // Show the panel.
    _refsPanel = new _RefsPanel(baselineOffset, _table, refsTable);
  }

  /** Close currently visible [_RefsPanel]. */
  closeRefsPanel() {
    if (_refsPanel != null) {
      _refsPanel.close();
      _refsPanel = null;
    }
  }
}

/** Single [IRPane] line */
class IRPaneLine {
  final gutter, text;
  IRPaneLine(Element this.gutter, Element this.text);
}

/** Range information associated with identifier on the [IRPane] */
class _Range {
  final int start;
  int length;

  _Range(int this.start, {int this.length: 1});
}

_wrapElement(val) => val is String ? new Text(val) : val;

/**
 * A floating panel used to display rows referencing some other row.
 *
 * Horizontally it is positioned between left border of the page and left
 * border of the parent [IRPane]. Vertically it is initially centered at
 * [baselineOffset] but it stays visible even if the window is scrolled
 * vertically.
 */
class _RefsPanel {
  /** The root [DivElement] of the panel. */
  final root = new Element.html(
      '<div class="irpane-refs">'
      '  <button type="button" class="close">X</button>'
      '  <br style="clear: both;"/>'
      '  <div class="irpane-refs-inner"></div>'
      '</div>');

  /** Subscription to the window's onScroll event stream. */
  var onScroll;

  /** Subscription to the window's onResize event stream. */
  var onResize;

  /** Baseline for the vertical positioning. */
  var baselineOffset;

  /** Element serving as the right border for the horizontal positioning. */
  var rightBorder;

  /** Padding between panel and surrounding borders. */
  static const PADDING = 5;

  _RefsPanel(this.baselineOffset, this.rightBorder, content) {
    onScroll = document.window.onScroll.listen((e) => position());
    onResize = document.window.onResize.listen((e) => position());

    root.querySelector(".close").onClick.listen((e) => close());
    root.querySelector(".irpane-refs-inner").nodes.add(content);

    document.body.nodes.add(root);

    position();
  }

  /** Destroy this panel. */
  close() {
    if (root.parent != null) {
      onResize.cancel();
      onScroll.cancel();
      root.parent.nodes.remove(root);
    }
  }

  /** Recompute fixed position and max-width for the panel. */
  position() {
    // Height of the panel.
    final height = root.getBoundingClientRect().height;

    final window = js.context.jQuery(js.context.window);

    // Offset within the page of the rightBorder.
    final leftBorderOffset = js.context.jQuery(rightBorder).offset().left;

    // Convert offsets with in a page to offsets within a window with respect
    // to window's scroll position.

    // Right offset of the panel is essentially right offset of border plus
    // padding. Panel stays glued to this position even if window is scrolled
    // horizontally.
    final right = window.scrollLeft() + (window.width() - leftBorderOffset) +
        PADDING;

    // If possible table glues itself to the baseline but it also tries to
    // stay visible as window is scrolled vertically thus top offset must
    // never be smaller than PADDING and bottom offset must never be bigger
    // than window's height.
    final baselineTop = baselineOffset - window.scrollTop() - (height ~/ 2);
    final maxTop = window.height() - PADDING - height;
    final minTop = PADDING;
    final top = math.min(math.max(baselineTop, minTop), maxTop);

    root.style.right = "${right}px";
    root.style.top = "${top}px";
    root.style.maxWidth = "${leftBorderOffset - 3 * PADDING}px";
  }
}

/**
 * Utility class that allows to splice disassembly into intermediate
 * representation when displaying both.
 */
class CodeRenderer {
  final pane;

  final code.Code _code;

  CodeRenderer(IRPane this.pane, this._code);

  /** Output a single instruction to the [IRPane]. */
  display(instr) {
    if (instr is code.Instruction) {
      pane.add("${instr.offset}",
               _formatInstruction(instr),
               id: "offset-${instr.offset}",
               klass: 'native-code');
    } else if (instr is code.Comment) {
      pane.add(" ",
               _em(";; ${instr.comment}"),
               klass: 'native-code');
    } else if (instr is code.Jump) {
      pane.add("${instr.offset}",
               _formatJump(instr),
               id: "offset-${instr.offset}",
               klass: 'native-code');
    }
  }

  /** Opcode mnemonic regular expression. Strips REX.W prefix. */
  final opcodeRe = new RegExp(r"^(REX.W\s+)?([\w()]+)(.*)$");

  /** Object address constant regular expression used to decode V8 comments. */
  final addressImmediateRe = new RegExp(r"^;; object: (0x[a-f0-9]+) (.*)$");

  /** Format a single [Instruction]. */
  _formatInstruction(instr) {
    final m = opcodeRe.firstMatch(instr.instr);

    final opcode = m[2];
    final operands = m[3];

    var formattedOperands;
    if (instr.comment != null) {
      // If there is a comment available for this instruction try to
      // extract an information about address immediate embedded into the
      // instruction.
      final immediateDef = addressImmediateRe.firstMatch(instr.comment);
      if (immediateDef != null) {
        final immAddress = immediateDef.group(1);
        final immValue = immediateDef.group(2);

        // Reformat instruction operands renaming immediate address to display
        // immediate value inline.
        final map = {};
        map[immAddress] = (_) =>
            span('native-code-constant', "${immAddress} (${immValue})");

        formattedOperands = formatting.makeFormatter(map)(operands);
      }
    }

    if (formattedOperands == null) {
      // Operands were not handled specially. Just wrap them into a SpanElement
      // and append emphasized comment (if any).
      formattedOperands = new SpanElement()..appendText(operands);
      if (instr.comment != null) {
        formattedOperands.append(_em(";; ${instr.comment}"));
      }
    }

    return new SpanElement()..append(span('boldy', opcode))
                            ..append(formattedOperands);
  }

  /** Format a single jump instruction. */
  _formatJump(instr) {
    final elem = new SpanElement()..append(span('boldy', instr.opcode))
                                  ..appendText(" ");

    if (0 <= instr.target && instr.target <= _code.code.last.offset) {
      // Jump target belongs to this code object. Display it as an offset and
      // format it as a reference to enable navigation.
      final anchor = pane.href("offset-${instr.target}");
      elem.append(new AnchorElement(href: "#${anchor}")..appendText("${instr.target}"));
    } else {
      // Jump target does not belong to this code object. Display it as an
      // absolute address.
      elem.appendText("${_code.start + instr.target}");
    }

    if (instr.comment != null) {  // Append emphasized comment if available.
      elem.append(_em(";; ${instr.comment}"));
    }

    return elem;
  }

  /** Wrap text into `em` tag. */
  static _em(text) => new Element.tag('em')..appendText(text);
}
