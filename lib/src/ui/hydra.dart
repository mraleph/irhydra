library hydra;

import 'dart:html';
import 'dart:async' as async;
import 'package:irhydra/src/html_utils.dart' show toHtml;
import "package:irhydra/src/modes/dartvm/dartvm.dart" as dartvm;
import "package:irhydra/src/modes/v8/v8.dart" as v8;
import 'package:irhydra/src/ui/irpane.dart' show IRPane;
import 'package:irhydra/src/xref.dart' show XRef;
import 'package:js/js.dart' as js;
import 'package:polymer/polymer.dart';

final MODES = [new dartvm.Mode(), new v8.Mode()];

@CustomTag('hydra-app')
class HydraElement extends PolymerElement {
  @observable var currentMode;
  @observable var currentFiles;
  @observable var currentPhase;
  @observable var currentMethod;
  @observable var currentMethods;

  @observable var ir;

  @observable get codeModes => IRPane.CODE_MODES;
  @observable var codeMode = IRPane.CODE_MODES.first;

  var blockRef;

  get applyAuthorStyles => true;

  get currentFileNames => currentFiles.map((file) => file.name).join(', ');

  HydraElement.created() : super.created() {
    async.Future.wait([
      HttpRequest.getString("demos/1.v8.hydrogen.cfg").then(loadData),
      HttpRequest.getString("demos/1.v8.code.asm").then(loadData)
    ]).then((_) {
      var m = currentMethods.firstWhere((m) => m.name.short == "loop");
      displayPhase(null, [m, m.phases.last], null);
    });
  }

  displayPhase(a, phaseAndMethod, b) {
    currentMethod = phaseAndMethod[0];
    currentPhase = phaseAndMethod[1];
    ir = currentMode.toIr(phaseAndMethod[0], currentPhase);
    blockRef = new XRef((id) => irpane.rangeContentAsHtmlFull(id));
  }

  IRPane get irpane => shadowRoot.querySelector("#irpane");

  enteredView() {
    super.enteredView();
  }

  openCompilation(e, files, target) {
    if (files.length > 1) {
      reset();
    }
    currentFiles = files;
    reloadCurrentFiles(e, files, target);
  }

  reloadCurrentFiles(e, detail, target) {
    reset();

    final spinner = $['spinner'];
    spinner.start();
    async.Future.wait(
      currentFiles.map((file) => readAsText(file).then(loadData))
    ).then((_) => spinner.stop(), onError: (_) => spinner.stop());
  }

  openProfile(e, detail, target) {
    // TODO(mraleph) support profiles again
  }

  showBlockAction(event, detail, target) {
    blockRef.show(detail.label, detail.blockId);
  }

  hideBlockAction(event, detail, target) {
    blockRef.hide();
  }

  showDeoptAction(event, detail, target) {
    var $widget = js.context.jQuery(detail.widget);
    if ($widget.data('bs.popover') != null) {
      $widget.popover('destroy');
      return;
    }

    final contents = [irpane.rangeContentAsHtmlFull(detail.deopt.hirId)];

    final descriptions = currentMode.descriptions;
    if (descriptions != null) {
      final desc = descriptions.lookup("hir", detail.deopt.hir.op);
      if (desc != null) {
        contents.add(desc);
      }
    }

    final raw = new PreElement()
        ..appendText(detail.deopt.raw.join('\n'));
    contents.add(toHtml(raw));

    final content = contents.join("<br/>");
    $widget.popover(js.map({
      "title": "",
      "content": "${content}",
      "placement": "bottom",
      "html": true,
      "container": 'body',
      "trigger": "manual"
    })).data('bs.popover').tip().addClass('deopt');
    $widget.popover('show');
  }

  changeCodeModeAction(event, detail, target) {
    codeMode = detail;
  }

  reset() {
    if (currentMode != null) {
      currentMode.reset();
    }
    currentMode = currentPhase = null;
  }

  /** Load given file. */
  readAsText(file) {
    final reader = new FileReader();
    final result = reader.onLoad.first.then((_) => reader.result);
    reader.readAsText(file);
    return result;
  }

  /** Load data from the given textual artifact if any mode can handle it. */
  loadData(text) {
    // Normalize line endings.
    text = text.replaceAll(new RegExp(r"\r\n|\r"), "\n");

    // Select mode that can handle it.
    currentMode = null;
    for (var mode in MODES) {
      if (mode.canRecognize(text)) {
        currentMode = mode;
        break;
      }
    }

    // Parse.
    currentMethods = toObservable(currentMode.parse(text));
  }
}