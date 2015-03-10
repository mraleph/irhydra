// Copyright 2012 Google Inc.
// All Rights Reserved.
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

library havlak;

import 'package:ui_utils/graph.dart';

LSG findLoops(List<BasicBlock> cfg) =>
  (new HavlakLoopFinder(cfg)..findLoops()).lsg;

//======================================================
// Scaffold Code
//======================================================

//
// class SimpleLoop
//
// Basic representation of loops, a loop has an entry point,
// one or more exit edges, a set of basic blocks, and potentially
// an outer loop - a "parent" loop.
//
// Furthermore, it can have any set of properties, e.g.,
// it can be an irreducible loop, have control flow, be
// a candidate for transformations, and what not.
//
class SimpleLoop  {
  final List<BasicBlock> basicBlocks = [];
  final List<SimpleLoop> children = [];
  final int counter;

  SimpleLoop parent;
  BasicBlock header;

  bool isRoot = false;
  bool isReducible = true;
  int nestingLevel = 0;
  int _depthLevel = -1;

  get depth {
    if (_depthLevel == -1) {
      _depthLevel = parent == null ? 0 : (parent.depth + 1);
    }
    return _depthLevel;
  }

  SimpleLoop(this.counter);

  void addNode(BasicBlock bb) => basicBlocks.add(bb);
  void addChildLoop(SimpleLoop loop) => children.add(loop);

  void setParent(SimpleLoop p) {
    this.parent = p;
    p.addChildLoop(this);
  }

  void setHeader(BasicBlock bb) {
    basicBlocks.add(bb);
    header = bb;
  }

  void setNestingLevel(int level) {
    nestingLevel = level;
    if (level == 0) {
      isRoot = true;
    }
  }

  printIt([ident = ""]) {
    print("${ident}loop-${counter} (isRoot=${isRoot}, isReducible=${isReducible}, nesting=${nestingLevel}, depth=${depth})");
    if (header != null) print("${ident}  header: B${header.name}");
    print("${ident}  blocks: ${basicBlocks.map((block) => 'B${block.name}').join(', ')}");
    for (var child in children) child.printIt(ident + "  ");
  }
}


//
// LoopStructureGraph
//
// Maintain loop structure for a given CFG.
//
// Two values are maintained for this loop graph, depth, and nesting level.
// For example:
//
// loop        nesting level    depth
//----------------------------------------
// loop-0      2                0
//   loop-1    1                1
//   loop-3    1                1
//     loop-2  0                2
//
class LSG {
  final int nblocks;

  int loopCounter = 1;
  final List<SimpleLoop> loops = [];
  final SimpleLoop root = new SimpleLoop(0);

  LSG(this.nblocks) {
    root.setNestingLevel(0);
    loops.add(root);
  }

  SimpleLoop createNewLoop() {
    SimpleLoop loop = new SimpleLoop(loopCounter++);
    return loop;
  }

  void addLoop(SimpleLoop loop) => loops.add(loop);

  printIt() {
    for (var loop in loops) loop.printIt();
  }

  int getNumLoops() => loops.length;

  get nesting {
    final nesting = new List<int>.filled(nblocks, 0);

    for (var loop in loops) {
      final current = loop.depth + 1;
      for (var bb in loop.basicBlocks) {
        if (current > nesting[bb.id]) {
          nesting[bb.id] = current;
        }
      }
    }

    return nesting;
  }
}


//======================================================
// Main Algorithm
//======================================================

//
// class UnionFindNode
//
// The algorithm uses the Union/Find algorithm to collapse
// complete loops into a single node. These nodes and the
// corresponding functionality are implemented with this class
//
class UnionFindNode {
  int dfsNumber = 0;
  UnionFindNode parent;
  BasicBlock bb;
  SimpleLoop loop;

  UnionFindNode();

  // Initialize this node.
  //
  void initNode(BasicBlock bb, int dfsNumber) {
    parent = this;
    this.bb = bb;
    this.dfsNumber = dfsNumber;
  }

  // Union/Find Algorithm - The find routine.
  //
  // Implemented with Path Compression (inner loops are only
  // visited and collapsed once, however, deep nests would still
  // result in significant traversals).
  //
  UnionFindNode findSet() {
    List<UnionFindNode> nodeList = [];

    UnionFindNode node = this;
    while (node != node.parent) {
      if (node.parent != node.parent.parent)
        nodeList.add(node);

      node = node.parent;
    }

    // Path Compression, all nodes' parents point to the 1st level parent.
    for (int iter=0; iter < nodeList.length; ++iter) {
      nodeList[iter].parent = node.parent;
    }

    return node;
  }

  // Union/Find Algorithm - The union routine.
  //
  // Trivial. Assigning parent pointer is enough,
  // we rely on path compression.
  //
  void union(UnionFindNode unionFindNode) {
    parent = unionFindNode;
  }
  SimpleLoop setLoop(SimpleLoop l) => loop = l;
}



class HavlakLoopFinder {
  final List<BasicBlock> cfg;
  final LSG lsg;

  static const int BB_TOP          = 0; // uninitialized
  static const int BB_NONHEADER    = 1; // a regular BB
  static const int BB_REDUCIBLE    = 2; // reducible loop
  static const int BB_SELF         = 3; // single BB loop
  static const int BB_IRREDUCIBLE  = 4; // irreducible loop
  static const int BB_DEAD         = 5; // a dead BB
  static const int BB_LAST         = 6; // Sentinel

  // Marker for uninitialized nodes.
  static const int UNVISITED = -1;

  // Safeguard against pathologic algorithm behavior.
  static const int MAXNONBACKPREDS = (32 * 1024);

  HavlakLoopFinder(List<BasicBlock> cfg) : cfg = cfg, lsg = new LSG(cfg.length);

  //
  // IsAncestor
  //
  // As described in the paper, determine whether a node 'w' is a
  // "true" ancestor for node 'v'.
  //
  // Dominance can be tested quickly using a pre-order trick
  // for depth-first spanning trees. This is why DFS is the first
  // thing we run below.
  //
  bool isAncestor(int w, int v, List<int> last) {
    return (w <= v) && (v <= last[w]);
  }

  //
  // DFS - Depth-First-Search
  //
  // DESCRIPTION:
  // Simple depth first traversal along out edges with node numbering.
  //
  int DFS(BasicBlock currentNode,
          List<UnionFindNode> nodes,
          List<int> number,
          List<int> last, int current) {
    nodes[current].initNode(currentNode, current);
    number[currentNode.id] = current;

    int lastid = current;
    for (int target = 0; target < currentNode.successors.length; target++) {
      if (number[currentNode.successors[target].id] == UNVISITED)
        lastid = DFS(currentNode.successors[target], nodes, number,
                     last, lastid + 1);
    }

    last[number[currentNode.id]] = lastid;
    return lastid;
  }

  //
  // findLoops
  //
  // Find loops and build loop forest using Havlak's algorithm, which
  // is derived from Tarjan. Variable names and step numbering has
  // been chosen to be identical to the nomenclature in Havlak's
  // paper (which, in turn, is similar to the one used by Tarjan).
  //
  int findLoops() {
    if (cfg.isEmpty) {
      return 0;
    }

    final int size = cfg.length;

    List<List<int>> nonBackPreds = new List(size);
    List<List<int>> backPreds = new List(size);
    List<int> number = new List(size);
    List<int> header = new List(size);
    List<int> types = new List(size);
    List<int> last = new List(size);
    List<UnionFindNode> nodes = new List(size);

    for (int i = 0; i < size; ++i) {
      nonBackPreds[i] = [];
      backPreds[i] = [];
      number[i] = UNVISITED;
      header[i] = 0;
      types[i] = BB_NONHEADER;
      last[i] = 0;
      nodes[i] = new UnionFindNode();
    }

    // Step a:
    //   - initialize all nodes as unvisited.
    //   - depth-first traversal and numbering.
    //   - unreached BB's are marked as dead.
    //
    DFS(cfg.first, nodes, number, last, 0);

    // Step b:
    //   - iterate over all nodes.
    //
    //   A backedge comes from a descendant in the DFS tree, and non-backedges
    //   from non-descendants (following Tarjan).
    //
    //   - check incoming edges 'v' and add them to either
    //     - the list of backedges (backPreds) or
    //     - the list of non-backedges (nonBackPreds)
    //
    for (int w = 0; w < size; ++w) {
      BasicBlock nodeW = nodes[w].bb;
      if (nodeW == null) {
        types[w] = BB_DEAD;
      } else {
        if (nodeW.predecessors.length > 0) {
          for (int nv = 0; nv < nodeW.predecessors.length; ++nv) {
            BasicBlock nodeV = nodeW.predecessors[nv];
            int v = number[nodeV.id];
            if (v != UNVISITED) {
              if (isAncestor(w, v, last)) {
                backPreds[w].add(v);
              } else {
                nonBackPreds[w].add(v);
              }
            }
          }
        }
      }
    }

    // Step c:
    //
    // The outer loop, unchanged from Tarjan. It does nothing except
    // for those nodes which are the destinations of backedges.
    // For a header node w, we chase backward from the sources of the
    // backedges adding nodes to the set P, representing the body of
    // the loop headed by w.
    //
    // By running through the nodes in reverse of the DFST preorder,
    // we ensure that inner loop headers will be processed before the
    // headers for surrounding loops.
    //
    for (int w = size-1; w >=0; --w) {
      // this is 'P' in Havlak's paper
      List<UnionFindNode> nodePool = [];

      BasicBlock nodeW = nodes[w].bb;
      if (nodeW == null) {
        continue;
      }

      // Step d:
      for (int vi = 0; vi < backPreds[w].length; ++vi) {
        var v = backPreds[w][vi];
        if (v != w) {
          nodePool.add(nodes[v].findSet());
        } else {
          types[w] = BB_SELF;
        }
      }

      // Copy nodePool to workList.
      //
      List<UnionFindNode> workList = [];
      for (int n = 0; n < nodePool.length; ++n) {
        workList.add(nodePool[n]);
      }

      if (nodePool.length != 0) {
        types[w] = BB_REDUCIBLE;
      }
      // work the list...
      //
      while (workList.length > 0) {
        UnionFindNode x = workList.removeAt(0);

        // Step e:
        //
        // Step e represents the main difference from Tarjan's method.
        // Chasing upwards from the sources of a node w's backedges. If
        // there is a node y' that is not a descendant of w, w is marked
        // the header of an irreducible loop, there is another entry
        // into this loop that avoids w.
        //

        // The algorithm has degenerated. Break and
        // return in this case.
        //
        int nonBackSize = nonBackPreds[x.dfsNumber].length;
        if (nonBackSize > MAXNONBACKPREDS) {
          return 0;
        }

        for (int iter=0; iter < nonBackPreds[x.dfsNumber].length; ++iter) {
          UnionFindNode y = nodes[nonBackPreds[x.dfsNumber][iter]];
          UnionFindNode ydash = y.findSet();

          if (!isAncestor(w, ydash.dfsNumber, last)) {
            types[w] = BB_IRREDUCIBLE;
            nonBackPreds[w].add(ydash.dfsNumber);
          } else {
            if (ydash.dfsNumber != w) {
              if (nodePool.indexOf(ydash) == -1) {
                workList.add(ydash);
                nodePool.add(ydash);
              }
            }
          }
        }
      }

      // Collapse/Unionize nodes in a SCC to a single node
      // For every SCC found, create a loop descriptor and link it in.
      //
      if ((nodePool.length > 0) || (types[w] == BB_SELF)) {
        SimpleLoop loop = lsg.createNewLoop();

        loop.setHeader(nodeW);
        if (types[w] == BB_IRREDUCIBLE) {
          loop.isReducible = true;
        } else {
          loop.isReducible = false;
        }

        // At this point, one can set attributes to the loop, such as:
        //
        // the bottom node:
        //    iter  = backPreds(w).begin();
        //    loop bottom is: nodes(iter).node;
        //
        // the number of backedges:
        //    backPreds(w).size()
        //
        // whether this loop is reducible:
        //    types(w) != BB_IRREDUCIBLE
        //
        nodes[w].loop = loop;

        for (int np = 0; np < nodePool.length; ++np) {
          UnionFindNode node = nodePool[np];

          // Add nodes to loop descriptor.
          header[node.dfsNumber] = w;
          node.union(nodes[w]);

          // Nested loops are not added, but linked together.
          if (node.loop != null) {
            node.loop.setParent(loop);
          } else {
            loop.addNode(node.bb);
          }
        }
        lsg.addLoop(loop);
      } // nodePool.length
    } // Step c

    return lsg.getNumLoops();
  } // findLoops
} // HavlakLoopFinder