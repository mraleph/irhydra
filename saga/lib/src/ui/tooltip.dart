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

library saga.ui.tooltip;

import 'dart:html';

import 'package:liquid/liquid.dart';
import 'package:liquid/vdom.dart' as v;
import 'package:observe/observe.dart';
import 'package:ui_utils/tooltip.dart' as tooltip;

export 'package:ui_utils/tooltip.dart' show Placement;

abstract class Tooltip extends Observable {
  @observable tooltip.Placement placement;
  @observable Element target;
  @observable bool isVisible = false;
  get content;

  Tooltip({this.placement: tooltip.Placement.BOTTOM});

  build({key}) => vTooltip(data: this, key: key);
}

class TooltipWithContent extends Tooltip {
  var contentBuilder;

  TooltipWithContent({placement: tooltip.Placement.BOTTOM}) : super(placement: placement);

  get content => contentBuilder();
}

final vTooltip = v.componentFactory(TooltipComponent);
class TooltipComponent extends Component {
  @property() Tooltip data;

  var subscription;
  _unsubscribe() {
    if (subscription != null) {
      subscription.cancel();
      subscription = null;
    }
  }

  updated() {
    _unsubscribe();
    subscription = data.changes.listen((_) {
      if (!data.isVisible) {
        tooltip.hide(element);
      } else {
        domScheduler.nextFrame.after().then((_) {
          tooltip.show(data.target, data.placement, element);
        });
        invalidate();
      }
    });
  }

  detached() => _unsubscribe();

  build() {
    return v.root(classes: ['popover', 'xref', tooltip.className(data.placement)])([
      v.div(classes: const ['arrow']),
      v.div(classes: const ['popover-content'])(data.content)
    ]);
  }
}