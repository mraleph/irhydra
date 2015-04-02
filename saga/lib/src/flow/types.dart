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

/// Type descriptors.
library saga.flow.types;

class Type {
  final String name;

  const Type(this.name);

  toString() => "Type(${name})";
}

class Field {
  final int offset;
  final String name;
  final Type type;

  Field(this.offset, this.name, this.type);
}

class ReferenceType extends Type {
  final Map<int, Field> fieldsByOffset;

  ReferenceType(name, fields)
    : fieldsByOffset = new Map.fromIterable(fields, key: (field) => field.offset),
      super(name);
}

class ArrayType extends ReferenceType {
  final Type elementType;

  static const lengthOffset = 12;
  static const elementsOffset = 16;
  static const nameSuffix = "[]";

  ArrayType(elementType)
    : elementType = elementType,
      super("${elementType.name}${nameSuffix}", [new Field(lengthOffset, "length", TypeSystem.INT)]);
}

class TypeSystem {
  final Map<String, Type> types = <String, Type>{};
  final Map<String, dynamic> typesInfo;

  static const INT = const Type("int");

  TypeSystem(this.typesInfo) {
    types[INT.name] = INT;
  }

  resolve(String name) {
    return types.putIfAbsent(name, () {
      if (name.endsWith(ArrayType.nameSuffix)) {
        final elementType = resolve(name.substring(0, name.length - ArrayType.nameSuffix.length));
        if (elementType != null) {
          return new ArrayType(elementType);
        }
      } else if (typesInfo.containsKey(name)) {
        return new ReferenceType(name, typesInfo[name].fields
            .map((fieldInfo) => new Field(fieldInfo.offset, fieldInfo.name, resolve(fieldInfo.type))));
      }
      return null;
    });
  }
}
