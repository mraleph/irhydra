library method_list;

import 'dart:js' as js;
import 'dart:math' show min;

import 'package:ui_utils/bootstrap.dart' as bs;
import 'package:ui_utils/delayed_reaction.dart';
import 'package:polymer/polymer.dart';

@CustomTag('method-list')
class MethodList extends PolymerElement {
  @published var methods;
  @published var filter = "";
  @published var selected;
  @published var demangleNames = true;
  @observable var filteredMethods;
  @published var sortBy = "time";

  var _currentMethods;
  var _sortedBy = "time";
  var _currentFilter;

  final delayed = new DelayedReaction(delay: const Duration(milliseconds: 200));

  MethodList.created() : super.created();

  attached() {
    super.attached();

    shadowRoot.querySelectorAll('[data-title]').forEach((node){
      bs.tooltip(node, { "container": "body" });
    });
  }

  selectPhase(a, b, c) {
    final phaseId = c.attributes['data-phase'].split(',').map(int.parse).toList();
    selected = filteredMethods[phaseId[0]].phases[phaseId[1]];
  }

  sortByChanged() => _recomputeList(force: true);
  methodsChanged() {
    if (methods != null) {
      _currentMethods = new List(methods.length);
      for (var i = 0; i < methods.length; i++)
        _currentMethods[i] = new _MethodWrapper(i, methods[i]);
    } else {
      _currentMethods = [];
    }

    sortBy = _sortedBy = "time";
    _recomputeList(force: true);
  }

  filterUpdated() {
    if (filter.startsWith("src:") && filter.length < 10) {
      return;
    }
    delayed.schedule(_recomputeList);
  }
  filterChanged() {
    delayed.cancel();
    _recomputeList();
  }


  _recomputeList({force: false}) {
    if (_currentFilter == filter && !force) {
      return;
    }
    _currentFilter = filter;

    if (_sortedBy != sortBy) {
      _currentMethods.sort(_createComparator());
      _sortedBy = sortBy;
    }

    filteredMethods = _currentMethods.where(_createFilter()).map((wrapper) => wrapper.method).toList();
  }

  _createComparator() {
    if (sortBy == "deopts") {
      _computeReopts();
      return (a, b) {
        var result = b.method.deopts.length - a.method.deopts.length;
        if (result == 0) {
          result = b.reopts - a.reopts;
          if (result == 0) {
            result = a.earliestDeopt - b.earliestDeopt;
            if (result == 0) {
              result = a.firstTimestamp - b.firstTimestamp;
              if (result == 0) {
                result = a.timestamp - b.timestamp;
              }
            }
          }
        }
        return result;
      };
    } else if (sortBy == "ticks") {
      ticksOf(w) => w.method.perfProfile == null ? 0 : w.method.perfProfile.totalTicks;

      return (a, b) {
        var result = ticksOf(b) - ticksOf(a);
        if (result == 0) {
          result = a.timestamp - b.timestamp;
        }
        return result;
      };
    }
    return (a, b) => a.timestamp - b.timestamp;
  }

  /**
   * Computes reoptimization counts and timestamps of the first compilation.
   * Methods with empty names are skipped because it is impossible to distinguish
   * them.
   */
  _computeReopts() {
    if (_currentMethods.isEmpty ||
        _currentMethods.first.reopts is int) {
      // Nothing to do.
      return;
    }

    var timestamp = {}, reopts = {};

    for (var wrapper in _currentMethods) {
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

    for (var wrapper in _currentMethods) {
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
   * Create filtering callback for the text in the [_currentFilter].
   * Filters are case insensitive and treat white space as a wildcard * character.
   */
  _createFilter() {
    if (_currentFilter == "") {
      return (wrapper) => !wrapper.method.phases.isEmpty;
    }

    if (_currentFilter.startsWith("src:")) {
      final pattern = _filterToPattern(_currentFilter.substring(4));
      return (wrapper) {
        for (var source in wrapper.method.sources) {
          for (var ln in source.source) {
            if (pattern.hasMatch(ln)) {
              return true;
            }
          }
        }
        return false;
      };
    }

    final pattern = _filterToPattern(_currentFilter);
    return (wrapper) => !wrapper.method.phases.isEmpty && pattern.hasMatch(wrapper.name);
  }

  _filterToPattern(filter) =>
      new RegExp(filter.replaceAllMapped(new RegExp(r"[-+$]"),
          (m) => "\\${m.group(0)}")
            .replaceAll(new RegExp(r" +"), ".*"),
            caseSensitive: false);


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

  /** Filterable name: concatenation of source and short parts of [IR.Name]. */
  final name;

  get earliestDeopt =>
    method.deopts.isEmpty ?
      0 : method.deopts.map((deopt) => deopt.timestamp).reduce(min);

  _MethodWrapper(this.timestamp, method)
      : method = method,
        name = _createName(method.name);

  static _createName(name) => (name.source != null) ?
      "${name.source}|${name.short}" : name.short;
}