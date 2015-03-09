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

/** Management of tooltips and popovers for cross-references. */
library xref;

import "dart:html";
import "dart:js" as js;

import "package:irhydra/src/delayed_reaction.dart";


/** Resolution callback mapping cross-referenced identifier to its data. */
typedef String ResolutionCallback(String id);

/** Display cross-reference content in the Bootstrap popover. */
const POPOVER = const _Popover();

/** Display cross-reference content in the Bootstrap tooltip. */
const TOOLTIP = const _Tooltip();

class XRef {
  final getContent;
  final type;

  final _delayed = new DelayedReaction();
  var _target;

  XRef(ResolutionCallback this.getContent, [this.type = POPOVER]);

  show(target, id) {
    hide();
    _target = target;
    _delayed.schedule(() {
      final content = getContent(id);
      if (content != null) {
        type.show(target, content);
      }
    });
  }

  hide() {
    if (_target != null) {
      _delayed.cancel();
      type.destroy(_target);
      _target = null;
    }
  }
}

/**
 * Create a function that allows to turn any HTML element into a
 * cross-reference with the given id.
 *
 * When user moves mouse over cross-reference its content is resolved via
 * [getContent] callback and an appropriately styled tooltip or popover
 * it displayed.
 */
makeAttachableReferencer(ResolutionCallback getContent, {type: POPOVER}) {
  final xref = new XRef(getContent, type);

  return (node, id) {
    node.onMouseOver.listen((event) => xref.show(event.target, id));
    node.onMouseOut.listen((event) => xref.hide());
  };
}

/**
 * Create a function that allows to produce a cross-reference link for
 * the given id.
 *
 * Link points to the anchor returned by [getAnchor].
 *
 * When user moves mouse over cross-reference its content is resolved via
 * [getContent] callback and an appropriately styled tooltip or popover
 * it displayed.
 */
makeReferencer(ResolutionCallback getContent,
               ResolutionCallback getAnchor,
               {type: POPOVER}) {
  final attach = makeAttachableReferencer(getContent, type: type);
  return (id) {
    // TODO(mraleph) this does not work when anchor is hidden inside the
    // Shadow DOM. Scroll by capturing on-click handler.
    final link = new AnchorElement()
        ..href = '#${getAnchor(id)}'
        ..appendText(id);
    attach(link, id);
    return link;
  };
}

/** Thin wrapper around Bootstrap popover. */
class _Popover {
  const _Popover();

  show(target, content) {
    final data = js.context.callMethod('jQuery', [target]).callMethod('popover', [new js.JsObject.jsify({
      "title": '',
      "content": content,
      "trigger": "manual",
      "placement": "bottom",
      "html": true,
      "container": 'body'
    })]).callMethod('data', ['bs.popover']);
    data.callMethod('tip').callMethod('addClass', ['xref']);
    data.callMethod('show');
  }

  destroy(target) {
    js.context.callMethod('jQuery', [target]).callMethod('popover', ['destroy']);
  }
}


/** Thin wrapper around Bootstrap tooltip. */
class _Tooltip {
  const _Tooltip();

  show(target, content) {
    final data = js.context.callMethod('jQuery', [target]).callMethod('tooltip', [new js.JsObject.jsify({
      "title": content,
      "trigger": "manual",
      "placement": "bottom",
      "html": true,
      "container": 'body'
    })]).callMethod('data', ['bs.tooltip']);
    data.callMethod('tip').callMethod('addClass', ['xref']);
    data.callMethod('show');
  }

  destroy(target) {
    js.context.callMethod('jQuery', [target]).callMethod('tooltip', ['destroy']);
  }
}
