library open_file_button;

import 'package:ui_utils/bootstrap.dart' as bs;
import 'package:polymer/polymer.dart';

@CustomTag('open-file-button')
class OpenFileButton extends PolymerElement {
  OpenFileButton.created() : super.created();

  attached() {
    super.attached();

    if (attributes['data-title'] != null) {
      final btn = shadowRoot.querySelector("button");
      final tooltip = bs.tooltip(btn, {
        "title": attributes['data-title'],
        "placement": "bottom",
        "container": "body",
        "trigger": "manual",
      });

      btn.onMouseEnter.listen((e) => tooltip.show());
      btn.onMouseLeave.listen((e) => tooltip.hide());
    }
  }

  clicked(e, detail, target) {
    $["file-input"].click();
    target.blur();
  }

  changed(e, detail, target) {
    fire("opened", detail: target.files);
  }
}