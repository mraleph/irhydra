library hydra;

import 'dart:html';
import 'dart:async' as async;
import 'package:polymer/polymer.dart';
import 'package:js/js.dart' as js;

import 'package:irhydra/src/ui/irpane.dart' show IRPane;

import "package:irhydra/src/modes/dartvm/dartvm.dart" as dartvm;
import "package:irhydra/src/modes/v8/v8.dart" as v8;

final MODES = [new dartvm.Mode(), new v8.Mode()];

@CustomTag('hydra-app')
class HydraElement extends PolymerElement {
  @observable var currentMode;
  @observable var currentFiles;
  @observable var currentPhase;
  @observable var currentMethods;

  @observable var ir;

  @observable get codeModes => IRPane.CODE_MODES;
  @observable var codeMode = IRPane.CODE_MODES.first;

  get applyAuthorStyles => true;

  get currentFileNames => currentFiles.map((file) => file.name).join(', ');

  HydraElement.created() : super.created() {
    async.Future.wait([
      HttpRequest.getString("demos/1.v8.hydrogen.cfg").then(loadData),
      HttpRequest.getString("demos/1.v8.code.asm").then(loadData)
    ]).then((_) => displayPhase(null, [currentMethods.last, currentMethods.last.phases.last], null));
  }

  displayPhase(a, phaseAndMethod, b) {
    currentPhase = phaseAndMethod[1];
    ir = currentMode.toIr(phaseAndMethod[0], currentPhase);
  }

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

//    return
//        reader.onLoad.listen((e) => new async.Timer(const Duration(milliseconds: 500), () => callback(reader.result)));

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