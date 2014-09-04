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
library modes.dartvm.name_parser;

import 'package:irhydra/src/modes/ir.dart' as IR;

/** Strips full URI path to the file. */
final uriNameRe = new RegExp(r"^file://.*/([^/]+)$");

/** Removes private (_x) name mangling used by VM. */
final demangleRe = new RegExp(r"@(0x)?[0-9a-f]+\.?$");

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

/** Matches file name pattern with 'dart' extension. */
final fileNameRe = new RegExp(r"^([-\w]+\.dart)_(.*)$");

/** Matches dart:library-name prefix that is used for internal libraries. */
final dartSchemeRe = new RegExp(r"^(dart:_?[-a-zA-Z0-9]+)_(.*)$");

/** Matches accessor name which is the last part of the full name. */
final accessorRe = new RegExp(r"([gs]et)_(_?)([a-z0-9]+|[A-Z0-9_]+)$");

/** Splits name into individual components: file, class and method names. */
List<String> _splitName(String name) {
  final comps = <String>[];

  var prefix = [];  // Tracks _ prefixes.

  // Try to match a normal file name.
  final fileNameMatch = fileNameRe.firstMatch(name);
  if (fileNameMatch != null) {
    comps.add(fileNameMatch.group(1));
    name = fileNameMatch.group(2);
  } else {
    // Try to match dart: scheme.
    final dartSchemeMatch = dartSchemeRe.firstMatch(name);
    if (dartSchemeMatch != null) {
      comps.add(dartSchemeMatch.group(1));
      name = dartSchemeMatch.group(2);
    }
  }

  // Split out the accessor part from the end of the name.
  name = name.replaceAll(demangleRe, "");
  final accessorMatch = accessorRe.firstMatch(name);
  if (accessorMatch != null) {
    name = name.substring(0, accessorMatch.start);
  }

  for (var part in name.split("_")) {
    part = part.replaceAll(demangleRe, "");

    // Skip global namespace symbol.
    if (part == "::") {
      continue;
    }

    // Empty parts relate to multiple underscores in a row.
    if (part == "") {
      prefix.add("_");
      continue;
    }

    // Apply pending prefix if any.
    if (!prefix.isEmpty) {
      part = "${prefix.join()}${part}";
      prefix.clear();
    }

    comps.add(part);  // Emit component.
  }

  // Emit accessor name as the last component.
  if (accessorMatch != null) {
    final keyword = accessorMatch.group(1);
    final privacy = accessorMatch.group(2);
    final name = accessorMatch.group(3);
    comps.add("${keyword}:${privacy}${name}");
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


