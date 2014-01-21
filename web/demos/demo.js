function Vec2(x, y) {
  this.x = x;
  this.y = y;
}

Vec2.prototype.len2 = function () {
  return this.x * this.x + this.y * this.y;
};

Vec2.prototype.len = function () {
  return Math.sqrt(this.len2());
};

function loop(v) {
  var sum = 0;
  for (var i = 0; i < 1e5; i++) sum += v.len();
  return sum;
}

var v = new Vec2(0.1, 0.2);
loop(v);

var v2 = new Vec2(0.1, 0.2);
v2.name = "whatever";
loop(v2);