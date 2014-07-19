//
// Is it faster to load something from the prototype multiple times or cache it?
//
// What happens if we add toString() at the print statement... How does this
// fix 3x slowdown that we observed on the second run of this benchmark?
//
// (hint: it makes representation inference go different way)
//

if (typeof print === 'undefined') {
  print = console.log.bind(console);
}

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
  print('In total: ' + counter.toString());
}

function lookupAndCache() {
  var counter = 0;
  var value = obj.prop;
  for(var i = 0; i < 1000; i++)
    for(var j = 0; j < 1000; j++)
      for(var k = 0; k < 1000; k++)
        counter += value;
  print('In total: ' + counter.toString());
}

function measure(f) {
  var start = Date.now();
  f();
  var end = Date.now();
  print(f.name + ' took ' + (end - start) + ' ms.');
}

measure(doManyLookups);
measure(doManyLookups);
measure(lookupAndCache);
measure(lookupAndCache);

