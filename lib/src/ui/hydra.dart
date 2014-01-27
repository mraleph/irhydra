library hydra;

import 'dart:html';
import 'dart:async' as async;
import 'package:irhydra/src/html_utils.dart' show toHtml;
import "package:irhydra/src/modes/dartvm/dartvm.dart" as dartvm;
import "package:irhydra/src/modes/v8/v8.dart" as v8;
import 'package:irhydra/src/ui/ir-pane.dart' show IRPane;
import 'package:irhydra/src/xref.dart' show XRef, POPOVER;
import 'package:js/js.dart' as js;
import 'package:polymer/polymer.dart';

final MODES = [
  () => new v8.Mode(),
  () => new dartvm.Mode(),
];

_createV8DeoptDemo(type) => [
  "demos/v8/deopt-${type}/hydrogen.cfg",
  "demos/v8/deopt-${type}/code.asm"
];

final DEMOS = {
  "demo-1": _createV8DeoptDemo("eager"),
  "demo-2": _createV8DeoptDemo("soft"),
  "demo-3": _createV8DeoptDemo("lazy"),
  "demo-4": ["demos/dart/code.asm"],
};


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

  @observable var sourcePath = toObservable([]);

  var blockRef;

  get applyAuthorStyles => true;

  get currentFileNames => currentFiles.map((file) => file.name).join(', ');

  HydraElement.created() : super.created();

  enteredView() {
    super.enteredView();

    window.onHashChange.listen((e) {
      final from = Uri.parse(e.oldUrl).fragment;
      final to = Uri.parse(e.newUrl).fragment;

      if (DEMOS.containsKey(to)) {
        _wait(DEMOS[to].map((path) => HttpRequest.getString(path).then(loadData)));
        return;
      }

      if (to.startsWith("ir") && tabPane.activeTab != "ir") {
        tabPane.activeTab = "ir";

        new async.Timer(const Duration(milliseconds: 50), () {
          final anchor = irpane.shadowRoot.querySelector("a[id='$to']");
          if (anchor != null) {
            anchor.scrollIntoView();
          }
        });
      }
    });

    document.dispatchEvent(new CustomEvent("HydraReady"));
  }

  closeSplash() {
    js.context.DESTROY_SPLASH();
  }

  displayPhase(a, phaseAndMethod, b) {
    closeSplash();

    currentMethod = phaseAndMethod[0];
    currentPhase = phaseAndMethod[1];
    ir = currentMode.toIr(phaseAndMethod[0], currentPhase);
    blockRef = new XRef((id) => irpane.rangeContentAsHtmlFull(id));

    sourcePath.clear();
    if (!currentMethod.sources.isEmpty) {
      sourcePath.add(currentMethod.inlined.first);
    }
  }

  get irpane => shadowRoot.querySelector("#ir-pane");
  get tabPane => shadowRoot.querySelector("tab-pane");
  get sourcePane => shadowRoot.querySelector("#source-pane");

  openCompilation(e, files, target) {
    if (files.length > 1) {
      reset();
    }
    currentFiles = files;
    _loadFiles();
  }

  reloadCurrentFiles(e, detail, target) {
    reset();
    _loadFiles();
  }

  _loadFiles() {
    closeSplash();
    _wait(currentFiles.map((file) => readAsText(file).then(loadData)));
  }

  _wait(actions) {
    final spinner = $['spinner'];
    spinner.start();
    async.Future.wait(
      actions
    ).then((_) => spinner.stop(), onError: (_) => spinner.stop());
  }

  showBlockAction(event, detail, target) {
    blockRef.show(detail.label, detail.blockId);
  }

  hideBlockAction(event, detail, target) {
    blockRef.hide();
  }

  navigateToDeoptAction(event, deopt, target) {
    if (currentMethod.inlined.isEmpty)
      return;

    buildStack(position) {
      if (position == null) {
        return [];
      } else {
        final f = currentMethod.inlined[position.inlineId];
        return buildStack(f.position)..add(f);
      }
    }

    sourcePath = toObservable(buildStack(deopt.srcPos));
    sourcePane.scrollTo(deopt, tabPane.activeTab != "source");
  }

  _formatDeoptInfo(deopt) {
    final contents = [];

    var instr = deopt.hir;
    var description = currentMode.descriptions.lookup("hir", deopt.hir.op);
    if (description == null) {
      description = currentMode.descriptions.lookup("lir", deopt.lir.op);
      if (description != null) {
        instr = deopt.lir;
      }
    }

    final connector = (deopt.reason == null) ? "at" : "due to";
    contents.add("<h4 class='deopt-header deopt-header-${deopt.type}'><span class='first-word'>${deopt.type}</span> deoptimization ${connector}</h4>");

    if (deopt.reason != null) {
      contents.add("<p><strong>${deopt.reason}</strong></p>");
      contents.add("<h4>at</h4>");
    }

    contents.add(irpane.rangeContentAsHtmlFull(instr.id));
    if (description != null) {
      contents.add("<br/>");
      contents.add(description);
    }

    final raw = new PreElement()
        ..appendText(deopt.raw.join('\n'));
    contents.add(toHtml(raw));

    return contents.join("\n");
  }

  showDeoptAction(event, detail, target) {
    var $widget = js.context.jQuery(detail.widget);
    if ($widget.data('bs.popover') != null) {
      $widget.popover('destroy');
      return;
    }

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

  final deoptPopover = new XRef((x) => x, POPOVER);

  enterDeoptAction(event, detail, target) {
    deoptPopover.show(detail.target, _formatDeoptInfo(detail.deopt));
  }

  leaveDeoptAction(event, detail, target) {
    deoptPopover.hide();
  }

  reset() {
    currentMode = currentMethods = null;
  }

  currentMethodsChanged() {
    currentPhase = ir = null;
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

    if (currentMode == null || !currentMode.load(text)) {
      var newMode;
      for (var mode in MODES) {
        final candidate = mode();
        if (candidate.load(text)) {
          newMode = candidate;
        }
      }

      if (newMode == null) {
        return;
      }

      currentMode = newMode;
    }
    currentMethods = toObservable(currentMode.methods);
  }
}