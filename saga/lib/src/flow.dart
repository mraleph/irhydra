// Copyright 2015 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library flow;

import 'package:saga/src/parser.dart' show Addr, Imm, RegRef;

import 'package:saga/src/flow/node.dart';
import 'package:saga/src/flow/ssa.dart';
import 'package:saga/src/flow/cpu_register.dart';
import 'package:saga/src/flow/locals.dart';
import 'package:saga/src/flow/loads.dart';
import 'package:saga/src/flow/dce.dart';
import 'package:saga/src/flow/fuse_branches.dart';


class MachineState {
  static const POINTER_SIZE = 8;

  var sem;

  final blockMap;

  MachineState(this.blockMap) {
    sem = _sem;
  }

  final ssa = new SSABuilder(<BB>[]);
  get blocks => ssa.blocks;

  get currentBlock => blocks.last;

  final entryState = new List.generate(CpuRegister.kNumberOfRegisters,
                                       (reg) => Node.arg(reg),
                                       growable: false);

  final phantom = Node.phantom();

  startBlock(bb) {
    blocks.add(bb);
    ssa.startBlock(bb);
    if (bb.id == 0) {
      for (var arg in entryState) {
        ssa.define(arg.op.n, emit(arg));
      }
    }
  }

  endBlock() {
    if (currentBlock.successors.length == 1 &&
        (currentBlock.code.isEmpty || currentBlock.code.last.op is! OpGoto)) {
      emit(Node.goto(currentBlock.successors[0]));
    }
  }

  Node emit(op, {point}) {
    if (op.list == null) {
      if (point == null) {
        currentBlock.append(op);
      } else {
        point.insertBefore(op);
      }
      op.origin = current;
    }
    return op;
  }

  define(int reg, Node value) {
    ssa.define(reg, value);
  }

  Node addrOf(Addr addr) {
    return emit(Node.addr(
        base: addr.base != null ? rUse(addr.base) : null,
        index: addr.index != null ? rUse(addr.index) : null,
        scale: addr.scale != null ? int.parse(addr.scale) : 1,
        offset: addr.offset != null ? int.parse(addr.offset) : 0));
  }

  Node use(val) {
    if (val is int) {
      return ssa.use(val);
    } else if (val is Imm) {
      return toKonst(val.value);
    } else if (val is Addr) {
      return emit(Node.load(addrOf(val)));
    }
    throw "unexpected ${val.runtimeType}";
  }

  Node toKonst(val) =>
    Node.konst(val is String ? int.parse(val).toSigned(32) : val);

  recordUse(ref, val) {
    if (ref is! Imm) {
      refUses[ref] = new Use(phantom, refUses.length)..bindTo(val);
    }
    return val;
  }

  rUse(ref) {
    if (ref is RegRef) {
      return recordUse(ref, use(CpuRegister.parse(ref.name)));
    } else {
      assert(ref is Addr || ref is Imm);
      return recordUse(ref, use(ref));
    }
  }

  rDef(ref) {
    if (ref is RegRef) {
      return CpuRegister.parse(ref.name);
    } else {
      assert(ref is Addr);
      return addrOf(ref);
    }
  }

  rUseDef(ref) {
    return rDef(ref);
  }

  rToUse(ref, val) {
    if (val is int) {
      return recordUse(ref, use(val));
    } else {
      assert(val is Node);
      return recordUse(ref, emit(Node.load(val)));
    }
  }

  var current;
  final refUses = {};
  exec(op) {
    current = op;
    Function.apply(sem[op.opcode], op.operands);
  }

  useFlags() => use(CpuRegister.FLAGS);

  ud(action) {
    return (src, dst) => action(rUse(src), rDef(dst));
  }

  uu(action) {
    return (rhs, lhs) => action(rUse(rhs), rUse(lhs));
  }

  uv(action) {
    return (src, dst) {
      final rdst = rUseDef(dst);
      action(rUse(src), rToUse(dst, rdst), rdst);
    };
  }

  v(action) {
    return (dst) {
      final rdst = rUseDef(dst);
      action(rToUse(dst, rdst), rdst);
    };
  }

  binary(op) =>
    uv((rhs, lhs, dst) => define(dst, emit(Node.binary(op, lhs, rhs))));

  branch(cc) =>
    (target) => emit(Node.branchOn(cc, useFlags(),
        target is int ? blockMap[target] : target, currentBlock.successors[0]));


  get _sem => {
    "mov": ud((from, to) {
      if (to is int) {
        define(to, from);
      } else if (to is Node) {
        emit(Node.store(to, from));
      } else {
        assert(false);
      }
    }),

    "cmovl": uv((rhs, lhs, dst) {
      define(dst, emit(Node.select("<", useFlags(), rhs, lhs)));
    }),

    "cmovg": uv((rhs, lhs, dst) {
      define(dst, emit(Node.select(">", useFlags(), rhs, lhs)));
    }),

    "xchg": (rhs, lhs) {
      assert(rDef(rhs) == rDef(lhs));
    },

    "push": (src) {
      final newSp = emit(Node.binary(SUB, use(CpuRegister.RSP), toKonst(POINTER_SIZE)));
      emit(Node.store(newSp, rUse(src)));
      ssa.define(CpuRegister.RSP, newSp);
    },

    "pop": (dst) {
      final sp = use(CpuRegister.RSP);
      define(rDef(dst), emit(Node.load(sp)));
      ssa.define(CpuRegister.RSP,
        emit(Node.binary(ADD, use(CpuRegister.RSP), toKonst(POINTER_SIZE))));
    },

    "lea": (addr, dst) {
      define(rDef(dst), addrOf(addr));
    },

    "cmp": uu((rhs, lhs) {
      var val = emit(Node.binary(SUB, lhs, rhs));
      ssa.define(CpuRegister.FLAGS, emit(Node.flags(val)));
    }),

    "test": uu((rhs, lhs) {
      var val = emit(Node.binary(AND, lhs, rhs));
      ssa.define(CpuRegister.FLAGS, emit(Node.flags(val)));
    }),

    "jmp": (target) { emit(Node.goto(target is int ? blockMap[target] : target)); },
    "jl": branch("<"),
    "jle": branch("<="),
    "jae": branch("ae"),
    "jge": branch(">="),
    "je": branch("=="),
    "jne": branch("!="),
    "callq": (target) => emit(Node.call(target)),

    "add": binary(ADD),
    "sub": binary(SUB),
    "xor": binary(XOR),
    "and": binary(AND),
    "dec": v((src, dst) {
      define(dst, emit(Node.binary(SUB, src, toKonst(1))));
    }),
    "inc": v((src, dst) {
      define(dst, emit(Node.binary(ADD, src, toKonst(1))));
    }),
    "retq": () {
      emit(Node.returnValue(use(CpuRegister.RAX)));
    },

    "nop": () { },

    "hlt": () { },
  };
}

build(ir) {
  Node.start(ir.blocks.values.first);
  var state = new MachineState(ir.blockMap);

  for (var block in ir.blocks.values) {
    state.startBlock(block);
    block.asm.forEach(state.exec);
    state.endBlock();
  }

  state.ssa.finish();

  dce(state.blocks);
  fuseBranches(state.blocks);
  dce(state.blocks);
  findLocals(state, state.blocks);
  dce(state.blocks);
  typeLoads(state, state.blocks);
  dce(state.blocks);


  // removeEmptyBlocks(state.blocks);

  return state;
}