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

/** Displaying a list of methods with filtering and sorting. */
library method_list;

import "dart:html";

import "package:irhydra/src/delayed_reaction.dart";

import "package:js/js.dart" as js;

/** Methods that were recovered from parsed compilation artifacts. */
var currentMethods;

/** [Element] that hosts lists of methods on the page. */
var _methodsList;

/** [InputTextElement] that contains filter text. */
var _filterInput;

/** Currently active filter for the list of methods. */
var _currentFilter;

/** [AnchorElement] that reflects current sorting criteria. */
var _sortByDropDown;

/** Sort method list in ascending order by timestamp. */
const SORT_BY_TIME = "sort-by-timestamp";

/** Sort method list in descending order by number of method reoptimizations. */
const SORT_BY_REOPTS = "sort-by-reopts";

/** Current sorting criteria: either [SORT_BY_TIME] or [SORT_BY_REOPTS]. */
var _sortCriteria;

/**
 * Display the given list of methods in the #methods element.
 * Connect phases references to the given [displayPhase] callback.
 */
display(methods, displayPhase) {
  var timestamp = 0;
  currentMethods = methods.map((method) =>
      new _MethodWrapper(timestamp++, method, displayPhase)).toList();
  _resetHeader();
  _updateView();
}

/** Update the displayed list of methods applying the filter. */
_updateView() {
  // Update sorting criteria dropdown to reflect current criteria.
  // currentMethods are assumed to be already sorted in this order.
  _sortByDropDown.nodes[0].text =
      _sortByDropDown.parent.query("#${_sortCriteria}").text;

  final filter = _createFilter();
  _methodsList.nodes
    ..clear()
    ..addAll(currentMethods.where(filter).map((wrapper) => wrapper.node));
}

/**
 * Create filtering callback for the text in the [_currentFilter].
 * Filters are case insensitive and treat white space as a wildcard * character.
 */
_createFilter() {
  if (_currentFilter == "") {
    return (wrapper) => true;
  }

  final pattern =
      new RegExp(_currentFilter.replaceAllMapped(new RegExp(r"[-+$]"),
                                                 (m) => "\\${m.group(0)}")
                               .replaceAll(new RegExp(r" +"), ".*"),
                 caseSensitive: false);

  return (wrapper) => pattern.hasMatch(wrapper.name);
}

/** Update the current filter and updates UI if necessary. */
_updateCurrentFilter() {
  if (_currentFilter == _filterInput.value) {
    return;
  }

  _currentFilter = _filterInput.value;
  _updateView();
}

/** Reset the header of the list of methods (state of sorting and filter). */
_resetHeader() {
  _filterInput.value = "";
  _currentFilter = "";
  _sortCriteria = SORT_BY_TIME;
}

/** Connect to DOM elements representing the list of methods. */
connectDOM() {
  if (_methodsList != null) {
    return;
  }

  // Connect to method list and ensure that it has proper size.
  _methodsList = document.query("#methods");
  _resizeMethodsList();
  document.window.onResize.listen((e) => _resizeMethodsList());

  // Connect event listeners to _filterInput.
  _filterInput = document.query("#methods-filter");

  final delayed = new DelayedReaction(delay: 200);
  _filterInput.onKeyUp.listen((e) => delayed.schedule(_updateCurrentFilter));
  _filterInput.onChange.listen((e) {
    delayed.cancel();
    _updateCurrentFilter();
  });

  // Connect event listeners to the sorting criteria dropdown.
  _sortByDropDown = document.query("#sort-by");
  for (var criteria in [SORT_BY_TIME, SORT_BY_REOPTS]) {
    document.query("#${criteria}").onClick.listen((e) {
      _setSortCriteria(criteria);
    });
  }
}

/** Keeps method list height within windows size boundaries. */
_resizeMethodsList() {
  js.scoped(() {
    final top = js.context.jQuery(_methodsList).offset().top;
    final windowHeight = js.context.jQuery(js.context.window).height();
    _methodsList.style.height = "${windowHeight - top - 20}px";
  });
}

/** Switch current sorting criteria to the new one and sort [currentMethods]. */
_setSortCriteria(criteria) {
  if (criteria == _sortCriteria) {
    return;  // Nothing changed.
  }

  _sortCriteria = criteria;
  currentMethods.sort(_createComparator());
  _updateView();
}

/** Create comparator callback from the [_sortCriteria]. */
_createComparator() {
  switch (_sortCriteria) {
    case SORT_BY_TIME:
      return (a, b) => a.timestamp - b.timestamp;

    case SORT_BY_REOPTS:
      _computeReopts();
      return (a, b) {
        var result = b.reopts - a.reopts;
        if (result == 0) {
          result = a.firstTimestamp - b.firstTimestamp;
          if (result == 0) {
            result = a.timestamp - b.timestamp;
          }
        }
        return result;
      };
  }
}

/**
 * Computes reoptimization counts and timestamps of the first compilation.
 * Methods with empty names are skipped because it is impossible to distinguish
 * them.
 */
_computeReopts() {
  if (currentMethods.isEmpty ||
      currentMethods.first.reopts is int) {
    // Nothing to do.
    return;
  }


  var timestamp = {}, reopts = {};

  for (var wrapper in currentMethods) {
    final fullName = wrapper.method.name.full;
    if (fullName == "") continue;

    final val = reopts[fullName];
    if (val != null) {
      reopts[fullName] = val + 1;
    } else {
      timestamp[fullName] = wrapper.timestamp;
      reopts[fullName] = wrapper.method.deopts.isEmpty ? 0 : 1;
    }
  }

  for (var wrapper in currentMethods) {
    final fullName = wrapper.method.name.full;
    if (fullName == "") {
      wrapper.reopts = 0;
      wrapper.firstTimestamp = 0;
      continue;
    }

    wrapper.reopts = reopts[fullName];
    wrapper.firstTimestamp = timestamp[fullName];
  }
}

/**
 * Wrapper around [IR.Method] that contains a DOM node that is used to display
 * it in the list of methods and its filterable name.
 */
class _MethodWrapper {
  /** Abstract timestamp of this method used for sorting. */
  final timestamp;

  /** Number of reopts that occurred to the method (based on its name). */
  var reopts;

  /** Timestamp of the first compilation of the method (based on its name). */
  var firstTimestamp;

  /** [IR.Method] corresponding to this wrapper. */
  final method;

  /** [Element] used to represent this method in the list of all methods. */
  final node;

  /** Filterable name: concatenation of source and short parts of [IR.Name]. */
  final name;

  _MethodWrapper(this.timestamp, method, displayPhase)
      : method = method,
        node = _createMethodNode(method, displayPhase),
        name = _createName(method.name);

  static _createName(name) => (name.source != null) ?
      "${name.source}|${name.short}" : name.short;
}

/**
 * Create [Element] that will be used to represent this method and all of its
 * phases in the list of methods.
 */
_createMethodNode(method, displayPhase) {
  final li = new Element.html('<li>'
                              '<h4></h4>'
                              '<ul class="nav nav-list"></ul>'
                              '</li>');

  final labels = [];

  if (method.name.source != null) {
    labels.add(_makeLabel('info', method.name.source));
  }

  if (!method.deopts.isEmpty) {
    labels.add(_makeLabel('important', 'deopts'));
  }

  if (!labels.isEmpty) {
    li.nodes.first.nodes.addAll(labels);
    li.nodes.first.nodes.add(new BRElement());
  }

  li.nodes.first.appendText(method.name.short);
  final ul = li.nodes.last;

  for (var phase in method.phases) {
    final anchor = new AnchorElement(href: "#ir")
        ..appendText(phase.name)
        ..onClick.listen((e) => displayPhase(method, phase));
    ul.nodes.add(new LIElement()..nodes.add(anchor));
  }

  return li;
}

/** Create Bootstrap label span. */
_makeLabel(type, text) =>
  new Element.html('<span class="label label-${type}">${text}</span>');
