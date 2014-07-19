//
// Is it faster two add two string constants or two variables containing the
// very same constants?
//
// (benchmarking shows it's faster to add variables, but in fact there is a
// bug in V8)
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
