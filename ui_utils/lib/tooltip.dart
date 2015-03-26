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

library tooltip;

import 'dart:html';

enum Placement {
  TOP, BOTTOM, LEFT, RIGHT
}

show(Element target, Placement placement, Element element) {
  element.style.left = "0px";
  element.style.top = "0px";
  element.style.display = "block";

  final tooltipPos = _calculatePosition(element, target, placement);
  switch (placement) {
    case Placement.TOP:
    case Placement.BOTTOM:
      var centerShift = 0;
      if (tooltipPos.x < 0) {
        centerShift = -tooltipPos.x;
        _moveTo(element, new Point(0, tooltipPos.y));
      } else {
        _moveTo(element, tooltipPos);
      }

      moveArrow(element, centerShift, element.offsetWidth, 'left');
      break;

    case Placement.LEFT:
    case Placement.RIGHT:
      _moveTo(element, tooltipPos);
      moveArrow(element, 0, element.offsetHeight, 'top');
      break;
  }
}

hide(Element element) {
  element.style.display = "none";
}

moveArrow(Element element, centerShift, total, position) {
  final arrow = element.querySelector('.arrow');
  final value = (centerShift != 0) ? "${50 * (1 - 2 * centerShift / total)}%" : '';
  if (position == 'left') {
    arrow.style.top = "";
    arrow.style.left = value;
  } else {
    arrow.style.left = "";
    arrow.style.top = value;
  }
}

Point _calculatePosition(Element element, Element target, Placement placement) {
  final targetRect = target.getBoundingClientRect();

  final tooltipWidth = element.offsetWidth;
  final tooltipHeight = element.offsetHeight;

  final computed = element.getComputedStyle();
  final margins = new Point(_parse(computed.marginLeft),
                            _parse(computed.marginTop));

  var p;
  switch (placement) {
    case Placement.BOTTOM:
      p = new Point(target.offsetLeft + targetRect.width ~/ 2 - tooltipWidth ~/ 2,
                    target.offsetTop + targetRect.height);
      break;

    case Placement.TOP:
      p = new Point(target.offsetLeft + targetRect.width ~/ 2 - tooltipWidth ~/ 2,
                    target.offsetTop - tooltipHeight);
      break;
    case Placement.LEFT:
      p = new Point(target.offsetLeft - tooltipWidth,
                    target.offsetTop + targetRect.height ~/ 2 - tooltipHeight ~/ 2);
      break;
    case Placement.RIGHT:
      p = new Point(target.offsetLeft + targetRect.width,
                    target.offsetTop + targetRect.height ~/ 2 - tooltipHeight ~/ 2);
      break;
  }

  return p - margins;
}

className(placement) {
  switch (placement) {
    case Placement.TOP:  return "top";
    case Placement.BOTTOM: return "bottom";
    case Placement.LEFT: return "left";
    case Placement.RIGHT: return "right";
  }
}

_moveTo(Element element, Point p) {
  final computed = element.getComputedStyle();
  final top = _parse(computed.top);
  final left = _parse(computed.left);

  element.style.left = "${element.offsetLeft + (p.x - left)}px";
  element.style.top = "${element.offsetTop + (p.y - top)}px";
}


final _reDigits = new RegExp("-?[0-9]+");
_parse(str) {
  final m = _reDigits.firstMatch(str);
  return (m != null) ? int.parse(m.group(0)) : 0;
}