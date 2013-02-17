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

/** Apply regular expressions to single strings and lists of strings. */
library parsing;

/**
 * Applies given regular expression [re] to a string [str] and if matched
 * invokes callback [action] passing matched groups as arguments.
 */
match(String str, RegExp re, Function action) {
  final m = re.firstMatch(str);
  if (m == null) return false;

  var args = [];
  for (var i = 0; i < m.groupCount; i++) args.add(m.group(i + 1));
  Function.apply(action, args);
  return true;
}

/**
 * Base class for parsers built around idea of applying a set of regular
 * expressions to a sequence of text lines. For each line expressions are tried
 * one after another, once match is found an associated action is invoked.
 *
 * Active set of regular expressions can be changed by an action allowing
 * handling of nested constructs.
 */
abstract class ParserBase {
  /** Sequence of lines to process. */
  final List<String> lines;

  /** Current line number. */
  var lineno = 0;

  /** Stack of parser states. */
  final _states = <_State>[];

  /** Initial set of patterns to be provided by child classes. See [enter]. */
  Map get patterns;

  ParserBase(List<String> this.lines) {
    enter(patterns);  // Enter initial state.
  }

  /** Return true if parsing reached the end of sequence. */
  bool get isDone => lineno >= lines.length;

  /** Move to the next line. */
  nextLine() => lineno++;

  /** Return current line. Should not be called after the end of the sequence. */
  String get currentLine => lines[lineno];

  /** Iterate over lines applying patterns from the current state. */
  parse() {
    for (; !isDone; nextLine()) {
      _applyPatterns(currentLine);
    }
  }

  /**
   * Enter a new state with then given [patternsMap].
   *
   * Each value in the map should either be a [Function] to be called
   * on match or a [Map] that denotes a new state to enter.
   */
  enter(Map patternsMap) {
    _states.add(new _State(_convertPatterns(patternsMap), lineno));
  }

  /** Return range of lines covered by the current state. */
  subrange({bool inclusive: false}) {
    final start = _states.last.start + (inclusive ? 0 : 1);
    final end = lineno - (inclusive ? 0 : 1);
    return lines.getRange(start, end - start + 1);
  }

  /** Leave [nstates] current states stepping back [backtrack] lines. */
  leave({int nstates: 1, int backtrack: 0}) {
    for (var i = 0; i < nstates; i++) _states.removeLast();
    lineno -= backtrack;
  }

  /** Apply patterns to the string until match is found. */
  _applyPatterns(str) {
    for (var pattern in _states.last.patterns) {
      if (pattern.apply(str)) break;
    }
  }

  List<_Pattern> _convertPatterns(Map patternsMap) {
    final result = <_Pattern>[];
    for (var re in patternsMap.keys) {
      final action = patternsMap[re];
      if (action is Function) {
        // This is an action to execute on match.
        result.add(new _Pattern(re, action));
      } else if (action is Map) {
        // This is a new state to enter.
        final substate = _convertPatterns(action);
        result.add(new _Pattern(re, () {
          _states.add(new _State(substate, lineno));
        }));
      } else {
        throw "action should be either Map or a Function";
      }
    }
    return result;
  }
}

/** Helper class wrapping a pair of regular expression and an action. */
class _Pattern {
  final RegExp re;
  final Function action;

  /**
   * Create a new [_Pattern] with the given regular expression [re].
   *
   * If [re] is empty creates a [_Pattern] that matches anything.
   */
  _Pattern(String re, Function this.action)
      : re = (re == "") ? null : new RegExp(re);

  /** Apply this [_Pattern] and execute [action] if match is found. */
  apply(String str) {
    if (re == null) {
      action();
      return true;
    }

    return match(str, re, action);
  }
}

/** [ParserBase] state. */
class _State {
  /** Active patterns. */
  final List<_Pattern> patterns;

  /** Line number at which state was entered. */
  final int start;

  _State(this.patterns, this.start);
}
