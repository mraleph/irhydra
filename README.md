# IRHydra

IRHydra is an in-browser tool that can display V8 and Dart VM compilation
artifacts (namely intermediate representations and native code) dumped during
optimization.

## Running project locally

### Mac

If you're a mac user, good for you. Just run:

```bash
brew install dart && cd path/to/irhydra && pub serve
```

After that, you should be able to open [index.html](http://localhost:8080/index.html) and see the app running.

### Windows

I'm afraid you're going to have to deal with [Dart Editor](https://www.dartlang.org/tools/editor/). It's fun.

## Hosted versions

[IRHydra](http://mrale.ph/irhydra/1/)

[IRHydra<sup>2</sup>](http://mrale.ph/irhydra/2/), requires V8 &ge;	2.24.39.

## Features

See [this](http://mrale.ph/blog/2013/02/17/release-the-irhydra.html) and [this](http://mrale.ph/blog/2014/01/28/prerelease-irhydra2.html) posts for description of the most important features.
