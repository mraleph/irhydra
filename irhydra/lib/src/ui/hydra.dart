library hydra;

import 'dart:async' as async;
import 'dart:html';
import 'dart:js' as js;
import 'dart:typed_data' show ByteBuffer, Uint8List;

import 'package:ui_utils/html_utils.dart' show toHtml;
import 'package:ui_utils/xref.dart' show XRef, POPOVER;
import "package:irhydra/src/modes/perf.dart" as perf;
import "package:irhydra/src/modes/dartvm/dartvm.dart" as dartvm;
import "package:irhydra/src/modes/art/art.dart" as art;
import "package:irhydra/src/modes/v8/v8.dart" as v8;
import 'package:irhydra/src/ui/spinner-element.dart';
import 'package:polymer/polymer.dart';

import 'package:archive/archive.dart' show BZip2Decoder, TarDecoder;

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

class TextFile {
  final file;
  final action;

  TextFile(this.file, this.action);

  load() => _read(file).then(action);

  static _read(file) {
    // We would like to load file as binary to avoid
    // line ending normalization.
    // FileReader.readAsBinaryString is not exposed in Dart
    // so we trampoline through JS.
    async.Completer completer = new async.Completer();
    js.context.callMethod('readAsBinaryString', [
      file, completer.complete]);
    return completer.future;
  }
}

timeAndReport(action, report) {
  final stopwatch = new Stopwatch()..start();
  final result = action();
  print(report(stopwatch.elapsedMilliseconds));
  return result;
}

@CustomTag('hydra-app')
class HydraElement extends PolymerElement {
  var MODES;

  @observable var mode;
  @observable var files;
  @observable var phase;
  @observable var methods;

  @observable var ir;

  @observable var codeMode;

  @observable var crlfDetected = false;
  @observable var sourceAnnotatorFailed = false;
  @observable var newPositionsWithoutStartPos = false;
  @observable var hasTurboFanCode = false;

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

  HydraElement.created() : super.created() {
    MODES = [
      () => new art.Mode(),  // Must come before V8 mode.
      () => new v8.Mode(this),
      () => new dartvm.Mode(),
    ];
  }

  _requestArtifact(path) {
    done(x) {
      shadowRoot.querySelector("#progress-toast").dismiss();
      progressUrl = progressValue = progressAction = null;
    }

    if (path.endsWith(".tar.bz2")) {
      unpack(data) {
        if (data is ByteBuffer) {
          data = new Uint8List.view(data);
        }

        final tar = timeAndReport(() => js.context.callMethod('BUNZIP2', [data]),
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

      progressAction = "Downloading";
      progressUrl = path;
      shadowRoot.querySelector("#progress-toast").show();
      return HttpRequest.request(path, responseType: "arraybuffer", onProgress: progress)
        .then((rq) {
          progressAction = "Unpacking";
          shadowRoot.querySelector("#progress-toast").show();
          return new async.Future.delayed(const Duration(milliseconds: 100), () => rq.response);
        })
        .then(unpack)
        .then(loadFiles)
        .then(done, onError: done);
    } else {
      progressAction = "Downloading";
      progressUrl = path;
      shadowRoot.querySelector("#progress-toast").show();
      return HttpRequest.getString(path).then(loadData).then(done, onError: done);
    }
  }

  static final DRIVE_REGEXP = new RegExp(r"^drive:([_\w.]+)$");
  static const DRIVE_ROOT = 'http://googledrive.com/host/0B6XwArTFTLptOWZfVTlUWkdkMTg/';

  static final GIST_REGEXP = new RegExp(r"^gist:([a-f0-9]+)$");
  static const GIST_ROOT = 'https://gist.githubusercontent.com/raw/';

  _loadDemo(fragment) {
    if (DEMOS.containsKey(fragment)) {
      _wait(DEMOS[fragment], _requestArtifact);
      return true;
    }

    final driveMatch = DRIVE_REGEXP.firstMatch(fragment);
    if (driveMatch != null) {
      _wait(["${DRIVE_ROOT}${driveMatch.group(1)}"], _requestArtifact);
      return true;
    }

    // Load artifacts from gist when fragment matches 'gist:gistId'.
    final gistMatch = GIST_REGEXP.firstMatch(fragment);
    if (gistMatch != null) {
      _wait([
        "${GIST_ROOT}${gistMatch.group(1)}/hydrogen.cfg",
        "${GIST_ROOT}${gistMatch.group(1)}/code.asm"
      ], _requestArtifact);
      return true;
    }

    return false;
  }

  attached() {
    super.attached();

    new async.Timer(const Duration(milliseconds: 50), () {
      if (!_loadDemo(Uri.parse(window.location.href).fragment)) {
        window.location.hash = "";
      }
    });

    window.onHashChange.listen((e) {
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
    js.context.callMethod('DESTROY_SPLASH');
  }

  phaseChanged() {
    closeSplash();
    crlfDetected = false;
    if (phase != null) {
      activeTab = "ir";
      ir = mode.toIr(phase.method, phase, this);

      if (profile != null) {
        profile.attachTo(ir);
      }

      blockRef = new XRef((id) => irpane.rangeContentAsHtmlFull(id));
      sourcePath.clear();
      if (!phase.method.sources.isEmpty) {
        sourcePath.add(phase.method.inlined.first);
      }

      if (ir.blocks.isEmpty && sourcePath.isNotEmpty) {
        activeTab = "source";
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
    files = selectedFiles
      .map((file) => new TextFile(file, loadData))
      .toList();
    _loadFiles();
  }

  reloadCurrentFiles(e, detail, target) {
    reset();
    _loadFiles();
  }

  _loadFiles() {
    closeSplash();
    _wait(files, (file) => file.load());
  }

  _wait(data, action) {
    final SpinnerElement spinner = $["spinner"];
    spinner.start();
    return async.Future.forEach(data, action)
      .then((_) => spinner.stop(), onError: (_) => spinner.stop());
  }

  showBlockAction(event, detail, target) {
    blockRef.show(detail.label, detail.blockId);
  }

  hideBlockAction(event, detail, target) {
    blockRef.hide();
  }

  showLegend() => graphpane.showLegend();

  navigateToDeoptAction(event, deopt, target) {
    if (activeTab == 'ir') {
      irpane.scrollToDeopt(deopt);
    }

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
    crlfDetected = sourceAnnotatorFailed = newPositionsWithoutStartPos = false;
    hasTurboFanCode = false;
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
      print("ERROR loading profile");
      print("${e}");
      print("${stack}");
      return;
    }
    _attachProfile();
  }

  _attachProfile() {
    if (methods != null && profile != null) {
      try {
        profile.attachAll(mode, methods);
        sortMethodsBy = "ticks";
      } catch (e, stack) {
        print("ERROR while attaching profile");
        print(e);
        print(stack);
      }
    }
  }

  loadProfile(e, selectedFiles, target) {
    final profileFiles = selectedFiles
      .map((file) => new TextFile(file, _loadProfile))
      .toList();
    files = []
      ..addAll(files)
      ..addAll(profileFiles);
    _wait(profileFiles, (file) => file.load());
  }

  /** Load data from the given textual artifact if any mode can handle it. */
  loadData(text) {
    // Warn about Windows-style (CRLF) line endings.
    // Don't normalize the input: V8 writes code trace in
    // binary mode (retaining original line endings) so
    // in theory everything should just work.
    crlfDetected = crlfDetected || text.contains("\r\n");

    if (mode == null || !mode.load(text)) {
      var newMode;
      for (var modeFactory in MODES) {
        final candidate = modeFactory();
        if (candidate.load(text)) {
          newMode = candidate;
          break;
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
