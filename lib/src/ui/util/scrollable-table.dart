// Copyright 2014 Google Inc. All Rights Reserved.
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

library ui.util.scrollable_table;

import 'dart:math';
import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('scrollable-table')
class ScrollableTable extends PolymerElement {
  final applyAuthorStyles = true;

  ScrollableTable.created() : super.created();

  @published var height = 20;
  @published var sources = [];
  final chunks = [];

  var prefixStart, activeStart, activeEnd, suffixEnd;

  Element get table => $['rows'];

  _initialize() {
    chunks.clear();
    table.nodes.clear();

    if (sources.isEmpty) {
      print("${sources.length}");
      return;
    }

    var start = 0;
    for (var index = 0; index < sources.length; index++) {
      chunks.add(new Chunk(start, sources[index]));
      start = chunks.last.end + 1;
    }

    final p = $["container"];
    final top = p.scrollTop;
    final bottom = p.getBoundingClientRect().height + p.scrollTop;

    final firstVisible = top ~/ height;
    final lastVisible = bottom ~/ height;
    prefixStart = activeStart = activeEnd = suffixEnd = 0;

    while (activeEnd < chunks.length - 1 && chunks[activeEnd].end < lastVisible) {
      activeEnd++;
    }

    suffixEnd = activeEnd;

    final nodes = [];
    for (var i = activeStart; i <= activeEnd; i++) {
      nodes.addAll(chunks[i].generate());
    }
    table.nodes.addAll(nodes);

    pump();

    print("done");
  }

  pump() {
    pumpPrefix();
    pumpSuffix();

    final ephemeralPrefix = prefixStart == 0 ? 0 : chunks.getRange(0, prefixStart).fold(0, (val, chunk) => val + chunk.length);
    final ephemeralSuffix = activeEnd == chunks.length - 1 ? 0 : chunks.getRange(activeEnd + 1, chunks.length).fold(0, (val, chunk) => val + chunk.length);

    table.style.marginTop = "${ephemeralPrefix * height}px";
    table.style.marginBottom = "${ephemeralSuffix * height}px";
  }

  pumpPrefix() {
    var prefixLength = activeStart - prefixStart;
    if (prefixLength > 3) {
      // destroy first chunks
      destroyChunks(prefixStart, activeStart - 4);
      prefixStart = activeStart - 3;
    } else if (prefixLength < 3 && prefixStart > 0) {
      // load more chunks
      insertChunks(max(0, prefixStart - 3 + prefixLength), prefixStart - 1);
      prefixStart = max(0, prefixStart - 3 + prefixLength);
    }
  }

  pumpSuffix() {
    var suffixLength = suffixEnd - activeEnd;
    if (suffixLength > 3) {
      destroyChunks(activeEnd + 4, suffixEnd);
      suffixEnd = activeEnd + 3;
    } else if (suffixLength < 3 && suffixEnd < chunks.length - 1) {
      insertChunks(suffixEnd + 1, min(chunks.length - 1, suffixEnd + 3 - suffixLength));
      suffixEnd = min(chunks.length - 1, suffixEnd + 3 - suffixLength);
    }
  }

  destroyChunks(from, to) {
    final totalRows = chunks.getRange(from, to + 1)
                             .fold(0, (val, chunk) => val + chunk.length);

    if (from == prefixStart) {
      final t = table;
      for (var i = 0; i < totalRows; i++) {
        t.nodes.remove(t.firstChild);
      }
    } else {
      assert(to == suffixEnd);
      final t = table;
      for (var i = 0; i < totalRows; i++) {
        t.nodes.remove(t.lastChild);
      }
    }
  }

  insertChunks(from, to) {
    final nodes = [];
    for (var i = from; i <= to; i++) {
      nodes.addAll(chunks[i].generate());
    }

    if (to == prefixStart - 1) {
      table.nodes.insertAll(0, nodes);
    } else {
      assert(from == suffixEnd + 1);
      table.nodes.addAll(nodes);
    }
  }

  enteredView() {
    super.enteredView();

    var p = $["container"];
    p.onScroll.listen((event) {
      if (chunks.isEmpty) {
        return;
      }

      final top = p.scrollTop;
      final bottom = p.getBoundingClientRect().height + p.scrollTop;

      final firstVisible = top ~/ height;
      final lastVisible = bottom ~/ height;

      while (chunks[activeStart].end < firstVisible) {
        activeStart++;
      }

      while (activeStart > 0 && chunks[activeStart].start > firstVisible) {
        activeStart--;
      }

      while (chunks[activeEnd].start > lastVisible) {
        activeEnd--;
      }

      while (activeEnd < chunks.length - 1 && chunks[activeEnd].end < lastVisible) {
        activeEnd++;
      }

      pump();
    });
  }

  sourcesChanged() {
    try {
      print("sourcesChanged");
      _initialize();
    } catch (e) {
      print(e);
    }
  }
}

class Chunk {
  final start;
  final source;

  Chunk(this.start, this.source);

  toString() => "(${start}, ${end})";

  get end => start + source.length - 1;
  get length => source.length;

  generate() => source.generate();
}