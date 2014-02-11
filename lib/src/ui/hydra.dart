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
  @observable var mode;
  @observable var files;
  @observable var phase;
  @observable var method;
  @observable var methods;

  @observable var ir;

  @observable var codeMode;

  @observable var sourcePath = toObservable([]);

  @observable var activeTab = "ir";

  var blockRef;

  get applyAuthorStyles => true;

  get currentFileNames => files.map((file) => file.name).join(', ');

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

      if (to == "source" || to == "ir" || to == "graph") {
        activeTab = to;
        return;
      }

      if (to.startsWith("ir") && activeTab != "ir") {
        activeTab = "ir";

        new async.Timer(const Duration(milliseconds: 50), () {
          final anchor = irpane.shadowRoot.querySelector("#${to}");
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

    activeTab = "ir";
    method = phaseAndMethod[0];
    phase = phaseAndMethod[1];
    ir = mode.toIr(phaseAndMethod[0], phase);
    blockRef = new XRef((id) => irpane.rangeContentAsHtmlFull(id));

    sourcePath.clear();
    if (!method.sources.isEmpty) {
      sourcePath.add(method.inlined.first);
    }
  }

  get irpane => shadowRoot.querySelector("#ir-pane");
  get sourcePane => shadowRoot.querySelector("#source-pane");

  openCompilation(e, selectedFiles, target) {
    if (selectedFiles.length > 1) {
      reset();
    }
    files = selectedFiles;
    _loadFiles();
  }

  reloadCurrentFiles(e, detail, target) {
    reset();
    _loadFiles();
  }

  _loadFiles() {
    closeSplash();
    _wait(files.map((file) => readAsText(file).then(loadData)));
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
    if (method.inlined.isEmpty)
      return;

    buildStack(position) {
      if (position == null) {
        return [];
      } else {
        final f = method.inlined[position.inlineId];
        return buildStack(f.position)..add(f);
      }
    }

    sourcePath = toObservable(buildStack(deopt.srcPos));
    sourcePane.scrollTo(deopt, activeTab != "source");
  }

  _formatDeoptInfo(deopt) {
    final contents = [];

    var instr = deopt.hir;
    var description = mode.descriptions.lookup("hir", deopt.hir.op);
    if (description == null) {
      description = mode.descriptions.lookup("lir", deopt.lir.op);
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
    mode = methods = null;
  }

  methodsChanged() {
    codeMode = "split";
    activeTab = "ir";
    phase = ir = null;
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

    if (mode == null || !mode.load(text)) {
      var newMode;
      for (var modeFactory in MODES) {
        final candidate = modeFactory();
        if (candidate.load(text)) {
          newMode = candidate;
        }
      }

      if (newMode == null) {
        return;
      }

      mode = newMode;
    }

    methods = toObservable(mode.methods);
    closeSplash();
  }
}