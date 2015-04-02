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

/// Register name parsing.
/// Supports only x86_64 registers, ignores register size and aliasing.
library saga.flow.cpu_register;

final registers = (){
  final map = <String, int>{};

  add(x, r) {
    map["r${x}"] = map["e${x}"] = map["${x}"] = r;
  }

  add("ax", CpuRegister.RAX);
  add("bx", CpuRegister.RBX);
  add("cx", CpuRegister.RCX);
  add("dx", CpuRegister.RDX);

  add("si", CpuRegister.RSI);
  add("di", CpuRegister.RDI);
  add("sp", CpuRegister.RSP);
  add("bp", CpuRegister.RBP);

  for (var i = CpuRegister.R8; i <= CpuRegister.R15; i++) {
    map["r${i}d"] = map["r${i}"] = i;
  }

  map["rip"] = CpuRegister.RIP;

  return map;
}();

class CpuRegister {
  static const RAX = 0;
  static const RCX = 1;
  static const RDX = 2;
  static const RBX = 3;
  static const RSP = 4;
  static const RBP = 5;
  static const RSI = 6;
  static const RDI = 7;
  static const R8 = 8;
  static const R9 = 9;
  static const R10 = 10;
  static const R11 = 11;
  static const R12 = 12;
  static const R13 = 13;
  static const R14 = 14;
  static const R15 = 15;
  static const RIP = 16;
  static const FLAGS = 17;
  static const kNumberOfRegisters = 18;

  static const kNames = const [
    'RAX',
    'RCX',
    'RDX',
    'RBX',
    'RSP',
    'RBP',
    'RSI',
    'RDI',
    'R8',
    'R9',
    'R10',
    'R11',
    'R12',
    'R13',
    'R14',
    'R15',
    'RIP',
    'FLAGS'
  ];

  static parse(name) {
    assert(registers.containsKey(name));
    return registers[name];
  }
}