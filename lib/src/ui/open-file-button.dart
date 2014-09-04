library open_file_button;

import 'package:polymer/polymer.dart';
import 'package:js/js.dart' as js;

@CustomTag('open-file-button')
class OpenFileButton extends PolymerElement {
  OpenFileButton.created() : super.created();

  attached() {
    super.attached();

    if (attributes['data-title'] != null) {
      final btn = shadowRoot.querySelector("button");
      js.context.jQuery(btn).tooltip(js.map({
        "title": attributes['data-title'],
        "placement": "bottom",
        "container": "body",
        "trigger": "manual",
      }));

      btn.onMouseEnter.listen((e) {
        js.context.jQuery(btn).tooltip('show');
      });
      btn.onMouseLeave.listen((e) {
        js.context.jQuery(btn).tooltip('hide');
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