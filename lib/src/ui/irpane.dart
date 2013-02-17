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

import 'dart:html';

import 'package:irhydra/src/html_utils.dart' show toHtml;
import 'package:web_ui/web_ui.dart';

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
class IRPane extends WebComponent {
  /** Lines currently added to the component */
  final List<IRPaneLine> _lines = <IRPaneLine>[];

  /** Content ranges for identifiers */
  final Map<String, _Range> _ranges = new Map<String, _Range>();

  /** Root [TableElement] */
  TableElement _table;

  inserted() {
    _table = _root.query('table');
  }

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
          ..name = href(id)
          ..nodes.add(gutter));


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
        _table.nodes.getRange(range.start, range.length)
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