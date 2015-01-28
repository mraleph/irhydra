library hydra;

import 'dart:html';
import 'dart:async' as async;
import 'dart:typed_data' show ByteBuffer, Uint8List;

import 'package:irhydra/src/html_utils.dart' show toHtml;
import 'package:irhydra/src/xref.dart' show XRef, POPOVER;
import "package:irhydra/src/modes/perf.dart" as perf;
import "package:irhydra/src/modes/dartvm/dartvm.dart" as dartvm;
import "package:irhydra/src/modes/v8/v8.dart" as v8;
import 'package:irhydra/src/ui/spinner-element.dart';
import 'package:js/js.dart' as js;
import 'package:polymer/polymer.dart';

import 'package:archive/archive.dart' show BZip2Decoder, TarDecoder;

final MODES = [
  () => new v8.Mode(),
  () => new dartvm.Mode(),
];

_createV8DeoptDemo(type) => [
  "demos/v8/deopt-${type}/hydrogen.cfg",
  "demos/v8/deopt-${type}/code.asm"
];

_createWebRebelsDemo(name) => [
  "demos/webrebels2014/${name}/data.tar.bz2"
];

final DEMOS = {
  "demo-1": _createV8DeoptDemo("eager"),
  "demo-2": _createV8DeoptDemo("soft"),
  "demo-3": _createV8DeoptDemo("lazy"),
  "demo-4": ["demos/dart/code.asm"],
  "webrebels-2014-concat": _createWebRebelsDemo("1-concat"),
  "webrebels-2014-concat-fixed": _createWebRebelsDemo("2-concat-fixed"),
  "webrebels-2014-prototype-node": _createWebRebelsDemo("3-prototype-node"),
  "webrebels-2014-prototype-node-getter": _createWebRebelsDemo("4-prototype-node-getter"),
  "webrebels-2014-prototype": _createWebRebelsDemo("5-prototype"),
  "webrebels-2014-prototype-tostring": _createWebRebelsDemo("6-prototype-tostring"),
  "webrebels-2014-method-function": _createWebRebelsDemo("7-method-function"),
  "webrebels-2014-method-function-hack": _createWebRebelsDemo("8-method-function-hack"),
};

timeAndReport(action, report) {
  final stopwatch = new Stopwatch()..start();
  final result = action();
  print(report(stopwatch.elapsedMilliseconds));
  return result;
}

@CustomTag('hydra-app')
class HydraElement extends PolymerElement {
  @observable var mode;
  @observable var files;
  @observable var phase;
  @observable var methods;

  @observable var ir;

  @observable var codeMode;

  @observable var sourcePath = toObservable([]);

  @observable var activeTab = "ir";

  @observable var showSource = false;
  @observable var demangleNames = true;
  @observable var sortMethodsBy = "time";

  @observable var progressValue;
  @observable var progressUrl;
  @observable var progressAction;

  @observable var timeline;

  var profile;

  var blockRef;

  get currentFileNames => files.map((file) => file.name).join(', ');

  HydraElement.created() : super.created();

  _requestArtifact(path) {
    if (path.endsWith(".tar.bz2")) {
      unpack(data) {
        if (data is ByteBuffer) {
          data = new Uint8List.view(data);
        }

        final tar = timeAndReport(() => js.context.BUNZIP2(data),
            (ms) => "Unpacking ${path} (${data.length} bytes) in JS took ${ms} ms (${data.length / ms} bytes/ms)");

        return new TarDecoder().decodeBytes(tar).files;
      }

      loadFiles(files) {
        for (var file in files)
          loadData(new String.fromCharCodes(file.content));
      }

      progress(evt) {
        if (evt.lengthComputable) {
          progressValue = (evt.loaded * 100 / evt.total).floor();
        }
      }

      done(x) {
        shadowRoot.querySelector("paper-toast").dismiss();
        progressUrl = progressValue = progressAction = null;
      }

      progressAction = "Downloading";
      progressUrl = path;
      shadowRoot.querySelector("paper-toast").show();
      return HttpRequest.request(path, responseType: "arraybuffer", onProgress: progress)
        .then((rq) {
          progressAction = "Unpacking";
          shadowRoot.querySelector("paper-toast").show();
          return new async.Future.delayed(const Duration(milliseconds: 100), () => rq.response);
        })
        .then(unpack)
        .then(loadFiles)
        .then(done, onError: done);
    } else {
      return HttpRequest.getString(path).then(loadData);
    }
  }

  static final DRIVE_REGEXP = new RegExp(r"^drive:([_\w.]+)$");
  static const DRIVE_ROOT = 'http://googledrive.com/host/0B6XwArTFTLptOWZfVTlUWkdkMTg/';

  _loadDemo(fragment) {
    if (DEMOS.containsKey(fragment)) {
      _wait(DEMOS[fragment].map(_requestArtifact));
      return true;
    }

    final driveMatch = DRIVE_REGEXP.firstMatch(fragment);
    if (driveMatch != null) {
      _wait([_requestArtifact("${DRIVE_ROOT}${driveMatch.group(1)}")]);
      return true;
    }
  }

  attached() {
    super.attached();

    new async.Timer(const Duration(milliseconds: 50), () {
      if (!_loadDemo(Uri.parse(window.location.href).fragment)) {
        window.location.hash = "";
      }
    });

    window.onHashChange.listen((e) {
      final from = Uri.parse(e.oldUrl).fragment;
      final to = Uri.parse(e.newUrl).fragment;

      if (_loadDemo(to)) {
        return;
      }

      if (to == "source" || to == "ir" || to == "graph") {
        activeTab = to;
        return;
      }

      if (to.startsWith("ir") && activeTab != "ir") {
        activeTab = "ir";

        new async.Timer(const Duration(milliseconds: 50), () {
          irpane.scrollToRow(to.substring("ir-".length));
        });
      }
    });

    window.onPopState.listen((e) {
      if (e.state is String) {
        if (activeTab != "ir")
          activeTab = "ir";

        new async.Timer(const Duration(milliseconds: 50), () {
          irpane.scrollToRow(e.state);
        });
      }
    });

    document.onKeyPress
            .where((e) => e.path.length < 4 && e.keyCode == KeyCode.S)
            .listen((e) {
              showSource = !showSource;
            });

    document.dispatchEvent(new CustomEvent("HydraReady"));
  }

  toggleInterestingMode() {
    showSource = !showSource;
  }

  toggleNameDemangling() {
    demangleNames = !demangleNames;
  }

  closeSplash() {
    js.context.DESTROY_SPLASH();
  }

  phaseChanged() {
    closeSplash();
    if (phase != null) {
      activeTab = "ir";
      ir = mode.toIr(phase.method, phase);

      if (profile != null) {
        profile.attachTo(ir);
      }

      blockRef = new XRef((id) => irpane.rangeContentAsHtmlFull(id));
      sourcePath.clear();
      if (!phase.method.sources.isEmpty) {
        sourcePath.add(phase.method.inlined.first);
      }
    } else {
      ir = null;
    }
  }

  get graphpane => shadowRoot.querySelector("graph-pane");
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
    final SpinnerElement spinner = $["spinner"];
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

  showLegend() => graphpane.showLegend();

  navigateToDeoptAction(event, deopt, target) {
    if (phase.method.inlined.isEmpty)
      return;

    buildStack(position) {
      if (position == null) {
        return [];
      } else {
        final f = phase.method.inlined[position.inlineId];
        return buildStack(f.position)..add(f);
      }
    }

    sourcePath = toObservable(buildStack(deopt.srcPos));
    sourcePane.scrollTo(deopt, activeTab != "source");
  }

  _formatDeoptInfo(deopt) {
    final contents = [];

    var instr = deopt.hir;
    var description;
    if (deopt.hir != null) {
      description = mode.descriptions.lookup("hir", deopt.hir.op);
      if (description == null && deopt.lir != null) {
        description = mode.descriptions.lookup("lir", deopt.lir.op);
        if (description != null) {
          instr = deopt.lir;
        }
      }
    } else {
      try {
        description = toHtml((querySelector('[dependent-code-descriptions]') as TemplateElement).content
            .querySelector("[data-reason='${deopt.reason}']").clone(true));
      } catch (e) { }
    }

    final connector = (deopt.reason == null) ? "at" : "due to";
    contents.add("<h4 class='deopt-header deopt-header-${deopt.type}'><span class='first-word'>${deopt.type}</span> deoptimization ${connector}</h4>");

    if (deopt.reason != null) {
      contents.add("<p><strong>${deopt.reason}</strong></p>");
    }

    if (instr != null) {
      if (deopt.reason != null) {
        contents.add("<h4>at</h4>");
      }
      contents.add(irpane.rangeContentAsHtmlFull(instr.id));
    }

    if (description != null) {
      contents.add(description);
    }

    final raw = new PreElement()
        ..appendText(deopt.raw.join('\n'));
    contents.add(toHtml(raw));

    return contents.join("\n");
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
    demangleNames = true;
    profile = null;
    sortMethodsBy = "time";
  }

  methodsChanged() {
    codeMode = "none";
    activeTab = "ir";
    phase = ir = null;
  }

  _loadProfile(text) {
    try {
      profile = perf.parse(text);
    } catch (e, stack) {
      print(e);
      print(stack);
    }

    if (methods != null) {
      profile.attachAll(mode, methods);
      sortMethodsBy = "ticks";
    }
  }

  loadProfile(e, selectedFiles, target) {
    _wait(selectedFiles.map((file) => readAsText(file).then(_loadProfile)));
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

    timeline = mode.timeline;

    final re = new RegExp(r"\$\d+$");
    demangleNames = !mode.methods.any((m) => re.hasMatch(m.name.full));

    methods = toObservable(mode.methods);
    closeSplash();
  }
}