import 'dart:js_interop';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:web/web.dart' as web;

import 'components/header.dart';
import 'pages/about.dart';
import 'pages/home.dart';

// The main component of your application.
class App extends StatelessComponent {
  const App({super.key});

  void _handleFiles(web.FileList files) {
    for (var i = 0; i < files.length; i++) {
      final file = files.item(i)!;
      file.arrayBuffer().toDart.then((arrayBuffer) {
        final byteBuffer = arrayBuffer.toDart;
      });
    }
  }

  /** Load data from the given textual artifact if any mode can handle it. */
  loadData(text) {
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
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // This method is rerun every time the component is rebuilt.
    //
    // Each build method can return multiple child components as an [Iterable]. The recommended approach
    // is using the [sync* / yield] syntax for a streamlined control flow, but its also possible to simply
    // create and return a [List] here.

    // Renders a <div class="main"> html element with children.
    yield div(classes: 'main', [
      Router(routes: [
        ShellRoute(
          builder: (context, state, child) => Fragment(children: [
            Header(onSelected: _handleFiles),
            child,
          ]),
          routes: [
            Route(
                path: '/',
                title: 'Home',
                builder: (context, state) => const Home()),
            Route(
                path: '/about',
                title: 'About',
                builder: (context, state) => const About()),
          ],
        ),
      ]),
    ]);
  }
}
