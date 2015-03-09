function K() {
}

K.prototype = {
  foo: function (i) {
    if (i === 2e4) {
      K.prototype.bar = function () { };
    } else if (i > 1e6) {
      with (this) { }  // To prevent inlining.
    }
    return 0;
  }
}

function loop1(v) {
  // In this loop function foo() changes prototype
  // of the object v in the middle of the loop
  // causing V8 to deoptimize loop1 lazily,
  // that is at the very moment when control returns
  // into loop1.
  // The reason for this is the global assumption that
  // prototypes are stable which allowed V8 to
  // omit prototype checks from the generated optimized
  // code. Instead this assumption is guarded at the
  // places where prototype can change shape and
  // generated code is invalidated.
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.foo(i);
  return sum;
}

var v = new K();
loop1(v);

function P() {
  this.v = 1.1;
}

function nullify(i, p) {
  if (i === 2e4) {
    p.v = null;
  } else if (i > 1e6) {
    with (p) { }  // To prevent inlining.
  }
}

function loop2() {
  var p = new P();
  var sum = 0;
  for (var i = 0; i < 1e5; i++) {
    nullify(i, p);
    sum += new P().v;
  }
  return sum;
}

loop2();