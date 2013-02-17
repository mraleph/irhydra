// Copyright 2013 Google Inc. All Rights Reserved.
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

/** Parsing of fully qualified function names printed by Dart VM. */
library name_parser;

import 'package:irhydra/src/modes/ir.dart' as IR;

/** Strips full URI path to the file. */
final uriNameRe = new RegExp(r"^file://.*/([^/]+)$");

/** Removes private (_x) name mangling used by VM. */
final demangleRe = new RegExp(r"@0x[0-9a-f]+\.?$");

/** Convert Dart VM's fully qualified function name into [IR.Name]. */
IR.Name parse(String full) {
  var name = full;

  // First strip the file:// uri prefix leaving only the last component.
  final m = uriNameRe.firstMatch(name);
  if (m != null) name = m.group(1);

  // Now split the name into '_' separated components.
  final components = _splitName(name);

  // The first component is the source file or library name.
  final source = components.first;

  // The rest is a function or method name.
  final short = _buildShort(components);

  return new IR.Name(full, source, short);
}

/** Splits name into individual components: file, class and method names. */
List<String> _splitName(String name) {
  final comps = <String>[];

  var prefix;  // Tracks get: and set: prefixes.

  for (var part in name.split("_")
                       .where((part) => part.length > 0)
                       .map((part) => part.replaceAll(demangleRe, ""))) {
    // Skip global namespace symbol.
    if (part == "::") continue;

    // Merge accessor prefixes into the next part of the name.
    if (part == "get" || part == "set") {
      assert(prefix == null);
      prefix = part;
      continue;
    }

    comps.add(prefix != null ? "${prefix}:${part}" : part);
  }

  return comps;
}

/** Build a short version of the name from components. */
_buildShort(List<String> comps) {
  comps.removeAt(0);  // Drop file name.
  if (comps.length == 2 && comps[1].startsWith("${comps[0]}.")) {
    // Constructor name already contains class name.
    // Use just the last component.
    return comps[1];
  }
  return comps.join(".");
}


