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

library flow.loads;

import 'package:saga/src/flow/cpu_register.dart';
import 'package:saga/src/flow/node.dart';

class FieldDescriptor {
  final String name;
  final TypeDescriptor type;

  FieldDescriptor(this.name, this.type);
}

class TypeDescriptor {
  final String name;
  final Map<int, FieldDescriptor> offsets;

  TypeDescriptor(this.name, this.offsets);
}

final INT = new TypeDescriptor("I", null);

class ArrayTypeDescriptor extends TypeDescriptor {
  final elementType;

  static const lengthOffset = 12;
  static const elementsOffset = 16;

  ArrayTypeDescriptor(td)
    : elementType = td,
      super("[${td.name}", { lengthOffset: new FieldDescriptor("length", INT) });
}

loadField(field, obj) {
  return new Node(new OpLoadField(field), [obj])..type = field.type;
}

class OpLoadField extends Op {
  final field;

  OpLoadField(this.field);
  get typeTag => "OpLoadField";

  format(inputs) => "${inputs[0]}.${field.name}";
}

const LOAD_ELEMENT = const SingletonOp("OpLoadElement");

loadElement(elementType, array, index) {
  return new Node(LOAD_ELEMENT, [array, index])..type = elementType;
}

/*
 *
 *
$ java -cp "$HOME/src/temp/jol/jol-cli/target/jol-cli.jar:." org.openjdk.jol.Main internals javabench.SmallMap
Running 64-bit HotSpot VM.
Using compressed references with 3-bit shift.
Objects are 8 bytes aligned.
Field sizes by type: 4, 1, 1, 2, 2, 4, 4, 8, 8 [bytes]
Array element sizes: 4, 1, 1, 2, 2, 4, 4, 8, 8 [bytes]

VM fails to invoke the default constructor, falling back to class-only introspection.

javabench.SmallMap object internals:
 OFFSET  SIZE     TYPE DESCRIPTION                    VALUE
      0    12          (object header)                N/A
     12     4      int SmallMap.currentSize           N/A
     16     4 Object[] SmallMap.keys                  N/A
     20     4    int[] SmallMap.hashCodes             N/A
     24     4 Object[] SmallMap.values                N/A
     28     4      Map SmallMap.fallbackMap           N/A
Instance size: 32 bytes (estimated, the sample instance is not available)
Space losses: 0 bytes internal + 0 bytes external = 0 bytes total

$ java -cp "$HOME/src/temp/jol/jol-cli/target/jol-cli.jar:." org.openjdk.jol.Main internals "[I"
Running 64-bit HotSpot VM.
Using compressed references with 3-bit shift.
Objects are 8 bytes aligned.
Field sizes by type: 4, 1, 1, 2, 2, 4, 4, 8, 8 [bytes]
Array element sizes: 4, 1, 1, 2, 2, 4, 4, 8, 8 [bytes]

VM fails to invoke the default constructor, falling back to class-only introspection.

[I object internals:
 OFFSET  SIZE  TYPE DESCRIPTION                    VALUE
      0    12       (object header)                N/A
     12     4   int [I.length                      N/A
     16     0   int [I.<elements>                  N/A
Instance size: 16 bytes (estimated, the sample instance is not available)
Space losses: 0 bytes internal + 0 bytes external = 0 bytes total

 */

typeLoads(state, blocks) {
  state.entryState[CpuRegister.RSI].type = new TypeDescriptor("javabench.SmallMap", {
    12: new FieldDescriptor("currentSize", INT),
    20: new FieldDescriptor("hashCodes", new ArrayTypeDescriptor(INT))
  });

  final heapBase = state.entryState[CpuRegister.R12];
  for (var use in iterate(heapBase.uses)) {
    if (use.idx == 0 &&
        use.at.op is OpAddr &&
        use.at.op.scale == 8 &&
        use.at.op.offset == 0) {
      use.at.replaceWith(Node.unpack(use.at.inputs[1].def));
    }
  }

  for (var block in blocks) {
    for (var node in iterate(block.code).where((node) => node.op == LOAD)) {
      final addr = node.inputs[0].def;

      if (addr.op is OpAddr) {
        final base = addr.inputs[0].def;
        final index = addr.inputs[1].def;

        if (base != null && base.op == UNPACK) {
          base.type = base.inputs[0].def.type;
        }

        if (base == heapBase &&
            addr.op.scale == 8 &&
            index.type != null) {
          final field = index.type.offsets[addr.op.offset];
          if (field != null) {
            final unpacked = Node.unpack(index);
            node.insertBefore(unpacked);
            node.replaceWith(loadField(field, unpacked));
          }
        } else if (base != null && base.type != null) {
          if (index == null) {
            final field = base.type.offsets[addr.op.offset];
            if (field != null) {
              node.replaceWith(loadField(field, base));
            }
          } else if (base.type is ArrayTypeDescriptor) {
            final indexAdj = (addr.op.offset - ArrayTypeDescriptor.elementsOffset) ~/ addr.op.scale;
            if (indexAdj != 0) {
              final adjustedIdx = Node.binary(ADD, index, Node.konst(indexAdj));
              node.insertBefore(adjustedIdx);
              node.replaceWith(loadElement(base.type.elementType, base, adjustedIdx));
            } else {
              node.replaceWith(loadElement(base.type.elementType, base, index));
            }
          }
        }
      }
    }
  }
}