//
// Is it faster two add two string constants or two variables containing the
// very same constants?
//
// (this is the same as 1-concat example, just running on the V8 with a fixed
// constant folding --- now both cases measure emptiness)
//

load("../jsperf.js");

Benchmark.prototype.setup = function() {
  var test1 = 'owijfiojwefiojewijewoijewoijofiejioejffwiejijiefwiowefjoiwejiewjfiewfoiwejewifjwefijewfiojoewfjwefiowejfiewfjiewfjiewfjieowfjewfijewiiewfjweiojewfiojewfioejfiewfjiewfo';
  var test2 = 'owijfiojwefiojewijewoijewoijofiejioejffwiejijiefwiowefjoiwejiewjfiewfoiwejewifjwefijewfiojoewfjwefiowejfiewfjiewfjiewfjieowfjewfijewiiewfjweiojewfiojewfioejfiewfjiewfo';
  function outsideScope() {
    return test1 + test2;
  }
  function insideScope() {
    return 'owijfiojwefiojewijewoijewoijofiejioejffwiejijiefwiowefjoiwejiewjfiewfoiwejewifjwefijewfiojoewfjwefiowejfiewfjiewfjiewfjieowfjewfijewiiewfjweiojewfiojewfioejfiewfjiewfo' +
           'owijfiojwefiojewijewoijewoijofiejioejffwiejijiefwiowefjoiwejiewjfiewfoiwejewifjwefijewfiojoewfjwefiowejfiewfjiewfjiewfjieowfjewfijewiiewfjweiojewfiojewfioejfiewfjiewfo';
  }
};

measure({
  'Inside': function() {
    insideScope();
  },
  'Outside': function() {
    outsideScope();
  }
});
