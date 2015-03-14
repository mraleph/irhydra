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

library bootstrap;

import "dart:js" as js;

js.JsObject jQuery(target) =>
  js.context.callMethod('jQuery', [target]);

Data popover(target, [options]) =>
  new Data.of(jQuery(target).callMethod('popover', options != null ? [_toJs(options)] : null), 'bs.popover');

Data tooltip(target, [options]) =>
  new Data.of(jQuery(target).callMethod('tooltip', options != null ? [_toJs(options)] : null), 'bs.tooltip');

class Data {
  final js.JsObject _data;

  Data.of(js.JsObject obj, id)
    : _data = obj.callMethod('data', [id]);

  get tip => _data.callMethod('tip').callMethod('get', [0]);

  addTipClass(String name) => _data.callMethod('tip').callMethod('addClass', [name]);

  show() => _data.callMethod('show');

  hide() => _data.callMethod('hide');

  destroy() => _data.callMethod('destroy');
}

_toJs(val) =>
  (val is Map || val is Iterable) ? new js.JsObject.jsify(val) : val;
