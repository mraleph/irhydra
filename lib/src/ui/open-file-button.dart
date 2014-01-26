library open_file_button;

import 'dart:html';
import 'package:irhydra/src/delayed_reaction.dart';
import 'package:polymer/polymer.dart';
import 'package:js/js.dart' as js;

@CustomTag('open-file-button')
class OpenFileButton extends PolymerElement {
  get applyAuthorStyles => true;

  OpenFileButton.created() : super.created();

  enteredView() {
    super.enteredView();

    if (attributes['title'] != null) {
      final btn = shadowRoot.querySelector("button");
      js.context.jQuery(btn).tooltip(js.map({
        "title": attributes['title'],
        "placement": "bottom",
        "container": "body",
        "trigger": "manual",
      }));

      var hide = new DelayedReaction(delay: const Duration(milliseconds: 100));
      var visible = false;
      btn.onMouseOver.listen((e) {
        hide.cancel();
        if (!visible) {
          js.context.jQuery(btn).tooltip('show');
        }
        visible = true;
      });
      btn.onMouseOut.listen((e) {
        // print("out ${e.target}");
        hide.schedule(() {
          js.context.jQuery(btn).tooltip('hide');
          visible = false;
        });
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