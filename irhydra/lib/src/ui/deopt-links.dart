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

library deopt_links;

import 'package:polymer/polymer.dart';

/**
 * Primitive tabbed pane WebComponent.
 */
@CustomTag('deopt-links')
class DeoptLinksElement extends PolymerElement {
  @published var deopts;
  @observable var deoptInfo;

  DeoptLinksElement.created() : super.created();

  deoptsChanged() {
    deoptInfo = deopts.map((deopt) {
      var targetId = null;
      if (deopt.hir != null) {
        targetId = deopt.hir.id;
      } else if (deopt.lir != null) {
        targetId = deopt.lir.id;
      }

      return new _DeoptInfo(targetId, deopt.type);
    }).toList();
  }

  jumpToDeoptAction(event, detail, target) {
    final index = int.parse(target.attributes["data-target"]);
    fire("deopt-click", detail: deopts[index]);
  }

  enterDeoptAction(event, detail, target) {
    final index = int.parse(target.attributes["data-target"]);
    fire("deopt-enter", detail: new _DeoptHoverDetail(deopts[index], target));
  }

  leaveDeoptAction(event, detail, target) {
    final index = int.parse(target.attributes["data-target"]);
    fire("deopt-leave", detail: new _DeoptHoverDetail(deopts[index], target));
  }
}

class _DeoptHoverDetail {
  final deopt;
  final target;
  _DeoptHoverDetail(this.deopt, this.target);
}

class _DeoptInfo {
  @observable final id;
  @observable final type;

  _DeoptInfo(this.id, this.type);
}