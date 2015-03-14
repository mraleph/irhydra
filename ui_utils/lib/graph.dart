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

/** Control flow graph */
library graph;

final _EMPTY_MARKS = new Set();

/** Block in the control flow graph. */
class BasicBlock {
  /** Block's number in a sequence of blocks. */
  int id;

  String name;

  final List<BasicBlock> successors = <BasicBlock>[];
  final List<BasicBlock> predecessors = <BasicBlock>[];

  int unlikely = 0;

  Set<String> marks = _EMPTY_MARKS;

  BasicBlock(this.id, this.name) {
    assert(id >= 0);
  }

  toString() => name;

  /** Creates an edge from this [BasicBlock] to the block [to]. */
  edge(BasicBlock to, {unlikely: false}) {
    to.predecessors.add(this);
    successors.add(to);
    if (unlikely) {
      this.unlikely |= 1 << (successors.length - 1);
    }
  }

  isUnlikelySuccessor(BasicBlock block) =>
    unlikely != 0 && (unlikely & (1 << successors.indexOf(block))) != 0;

  mark(tag) {
    if (identical(marks, _EMPTY_MARKS)) {
      marks = new Set();
    }
    marks.add(tag);
  }
}
