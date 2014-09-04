//
// Is it faster to call a function directly or call it as if it was a method
// on an object?
//
// The benchmark used to show that Function is many times slower until we
// added
//
//       "Speed" + "you" + "JS" + "with" +
//       "this" + "one" + "weird" + "trick";
//
// in the setup.
//
// WAAAAAAT?
//
// Now they are equaly fast!
//
// (Hint: it was not optimized before, not it is --- both benchmarks now
// measure the sound of silence because LICM completely moves the "meat"
// out of benchmarking loops).
//

load("../jsperf.js");

Benchmark.prototype.setup = function() {
   "Speed" + "you" + "JS" + "with" +
   "this" + "one" + "weird" + "trick";

   function mk(word) {
        var len = word.length;
        if (len > 255) return undefined;
        var i = len >> 2;
        return String.fromCharCode(
            (word.charCodeAt(    0) & 0x03) << 14 |
            (word.charCodeAt(    i) & 0x03) << 12 |
            (word.charCodeAt(  i+i) & 0x03) << 10 |
            (word.charCodeAt(i+i+i) & 0x03) <<  8 |
            len
        );
    }

    var MK = function() { };
    MK.prototype.mk = mk;
    var mker = new MK;
};

measure({
  'Function': function() {
    var key;
    key = mk('www.wired.com');
    key = mk('www.youtube.com');
    key = mk('scorecardresearch.com');
    key = mk('www.google-analytics.com');
  },
  'Method': function() {
    var key;
    key = mker.mk('www.wired.com');
    key = mker.mk('www.youtube.com');
    key = mker.mk('scorecardresearch.com');
    key = mker.mk('www.google-analytics.com');
  }
});