
import 'dart:math';

class Vec2 {
  var x;
  var y;

  Vec2(this.x, this.y);

  get len2 => x * x + y * y;
  get len => sqrt(len2);
}

// We are going to deoptimize here when we call
// loop the second time because class of
// v2 does not match class of v.
len(v) => v.len;

loop(v) {
  var sum = 0.0;
  for (var i = 0; i < 10000; i++) sum += len(v);
  return sum;
}

class NamedVec2 extends Vec2 {
  final name;

  NamedVec2(this.name, x, y) : super(x, y);
}

main() {
  var v = new Vec2(0.1, 0.2);
  loop(v);

  var v2 = new NamedVec2("whatever", 0.1, 0.2);
  loop(v2);
}