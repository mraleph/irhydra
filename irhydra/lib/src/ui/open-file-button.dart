library open_file_button;

import 'dart:js' as js;
import 'package:polymer/polymer.dart';

@CustomTag('open-file-button')
class OpenFileButton extends PolymerElement {
  OpenFileButton.created() : super.created();

  attached() {
    super.attached();

    if (attributes['data-title'] != null) {
      final btn = shadowRoot.querySelector("button");
      js.context.callMethod('jQuery', [btn]).callMethod('tooltip', [new js.JsObject.jsify({
        "title": attributes['data-title'],
        "placement": "bottom",
        "container": "body",
        "trigger": "manual",
      })]);

      btn.onMouseEnter.listen((e) {
        js.context.callMethod('jQuery', [btn]).callMethod('tooltip', ['show']);
      });
      btn.onMouseLeave.listen((e) {
        js.context.callMethod('jQuery', [btn]).callMethod('tooltip', ['hide']);
      });
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