//
// Is it faster to load something from the prototype multiple times or cache it?
//
// Benchmarking on node.js v0.10.29 shows that caching is 8x faster.
//
// Should we start caching properties in local variables now and expect 8x
// speedup across the board?
//
// (Hint: the answer is no. We should learn how to benchmark things first)
//

var obj =
  Object.create(
    Object.create(
      Object.create(
        Object.create(
          Object.create({prop: 10})))));


function doManyLookups() {
  var counter = 0;
  for(var i = 0; i < 1000; i++) {
    for(var j = 0; j < 1000; j++) {
      for(var k = 0; k < 1000; k++) {
        counter += obj.prop;
      }
    }
  }
  print('In total: ' + counter);
}

function lookupAndCache() {
  var counter = 0;
  var value = obj.prop;
  for(var i = 0; i < 1000; i++)
    for(var j = 0; j < 1000; j++)
      for(var k = 0; k < 1000; k++)
        counter += value;
  print('In total: ' + counter);
}

function measure(f) {
  var start = Date.now();
  f();
  var end = Date.now();
  print(f.name + ' took ' + (end - start) + ' ms.');
}

measure(doManyLookups);
measure(lookupAndCache);


