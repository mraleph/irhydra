load("../jsperf.js");

Benchmark.prototype.setup = function() {
  function x() { }
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
