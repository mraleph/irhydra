//
// Benchmark.js wrapper that limits amounts of samples to minimize the size
// of produced hydrogen.cfg/code.asm dumps.
//

load("../lodash.js");
load("../benchmark.js");

Benchmark.options.maxTime = 0;
Benchmark.options.minSamples = 2;

function measure(cases) {
  var suite = new Benchmark.Suite();

  Object.keys(cases).forEach(function (name) {
    suite.add(name, cases[name]);
  });

  suite
    .on('cycle', function(event) {
      print(String(event.target));
    })
    .on('complete', function() {
      print('Fastest is ' + this.filter('fastest').pluck('name'));
    })
    .run({'async': false});
}