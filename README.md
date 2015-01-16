IRHydra is an in-browser tool that can display V8 and Dart VM compilation
artifacts (namely intermediate representations and native code) dumped during
optimization.

## Features

See [this](http://mrale.ph/blog/2013/02/17/release-the-irhydra.html) and [this](http://mrale.ph/blog/2014/01/28/prerelease-irhydra2.html) posts for description of the most important features.

## Hosted versions

[IRHydra](http://mrale.ph/irhydra/1/)

[IRHydra<sup>2</sup>](http://mrale.ph/irhydra/2/), requires V8 &ge;	3.24.39.

## Running Locally

IRHydra is written in [Dart](http://dartlang.org) the easiest way to run it is to [download](https://www.dartlang.org/tools/download.html) full Dart bundle and use Dart Editor.

Detailed information about Dart development can be found in the [Dart: Up and Running](https://www.dartlang.org/docs/dart-up-and-running/).

### Prerequisites

* [Dart SDK](https://www.dartlang.org/tools/download.html)
* [Sass](http://sass-lang.com/)

### Dart Editor Workflow

Launch Editor, open IRHydra folder via `File > Open Existing Folder`, right click `web/index.html` and select `Run in Dartium`.

### Dartium Workflow

Requires Dart SDK and Dartium.

    $ cd irhydra
    # Get all dependencies
    $ pub get
    # Serve root
    $ pub serve
    $ DART_FLAGS="--checked" dart/chromium/chrome --enable-experimental-webkit-features --enable-devtools-experiments http://localhost:8000/web/index.html

### JavaScript Workflow

Requires Dart SDK.

    $ cd irhydra
    # Get all dependencies
    $ pub get
    # Serve dart2js compiled IRHydra at http://localhost:8080/
    # It will be recompiled when needed.
    $ pub serve

or

    # Build IRHydra for deployment. Result is in build/
    $ pub build
