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

import 'dart:html';
import 'dart:math' as math;

import 'package:irhydra/src/modes/code.dart' show CodeRenderer;
import 'package:irhydra/src/html_utils.dart' show toHtml, span;
import 'package:irhydra/src/xref.dart' as xref;

import 'package:js/js.dart' as js;

import 'package:polymer/polymer.dart';

class FormattingContext {
  final irPrefix;
  final makeBlockRef;
  final makeValueRef;

  FormattingContext(this.irPrefix, this.makeBlockRef, this.makeValueRef);

  formatOperand(tag, text) => span("${irPrefix}-${tag}", text);

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

  IRPane.created() : super.created() {
    makeBlockRef = xref.makeReferencer(rangeContentAsHtmlFull,
                                       href,
                                       type: xref.POPOVER);
    makeValueRef = xref.makeReferencer(rangeContentAsHtml,
                                       href,
                                       type: xref.TOOLTIP);
  }

  enteredView() {
    super.enteredView();
    _table = $['rows'];
    if (ir != null) {
      render();
    }
  }

  irChanged() {
    if (_table != null) {
      render();
    }
  }

  codeModeChanged() {
    if (_table != null) {
      render();
    }
  }

  var _renderedIr, _renderedCodeMode;

  render() {
    if (_renderedIr == ir && _renderedCodeMode == codeMode) return;
    _renderedIr = ir;
    _renderedCodeMode = codeMode;

    final stopwatch = new Stopwatch()..start();
    clear();

    formatOpcode(ctx, opcode) {
      final element = span('boldy', opcode);
      // TODO(mraleph) attach documentation link for the opcode.
      return element;
    }

    addEx(ctx, id, opcode, operands) {
      operands = new SpanElement()..nodes.addAll(operands.map(ctx.format));
      var ln = add(id, new SpanElement()..append(formatOpcode(ctx, opcode))
                                        ..appendText(" ")
                                        ..append(operands));
      ln.gutter.parentNode.classes.add("${ctx.irPrefix}-gutter");
      ln.text.parentNode.classes.add("${ctx.irPrefix}-line");
    }

    final hirContext = new FormattingContext("hir", makeBlockRef, makeValueRef);
    final lirContext = new FormattingContext("lir", makeBlockRef, makeValueRef);

    final codeRenderer = new CodeRenderer(this, ir.code);

    ir.code.prologue.forEach(codeRenderer.display);

    for (var block in ir.blocks.values) {
      // Block name.
      add(" ", " ");
      add(span('boldy', block.name), " ", id: block.name);

      for (var instr in block.parsedHir) {
        addEx(hirContext, instr.id, instr.op, instr.args);
      }

      final lir = block.parsedLir.toList();
      ir.attachCode(block, lir);

      for (var instr in lir) {
        addEx(lirContext, instr.id, instr.op, instr.args);
        if (codeMode == 'inline' && instr.code != null) {
          instr.code.forEach(codeRenderer.display);
        }
      }

      if (codeMode == 'split') {
        for (var instr in lir) {
          if (instr.code != null) {
            instr.code.forEach(codeRenderer.display);
          }
        }
      }

      createRange(block.name);
    }

    add(" ", " ");
    ir.code.epilogue.forEach(codeRenderer.display);
    
    for (var deopt in ir.deopts) {
      print("deopt at ${deopt.lirId}");
    }

    print("IRPane.render() took ${stopwatch.elapsedMilliseconds}");
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

    root.query(".close").onClick.listen((e) => close());
    root.query(".irpane-refs-inner").nodes.add(content);

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
