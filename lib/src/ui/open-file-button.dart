library open_file_button;

import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('open-file-button')
class OpenFileButton extends PolymerElement {  
  get applyAuthorStyles => true;
  
  OpenFileButton.created() : super.created() {
  }
 
  clicked(e, detail, target) {
    $["file-input"].click();
    target.blur();
  }
  
  changed(e, detail, target) {
    fire("opened", detail: target.files);
  }
}