/**
 * Copyright (c) 2003, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */

part of graph;

/**
 * Performs a topological sort from left to right of the subgraphs in a compound
 * directed graph. This ensures that subgraphs do not intertwine.
 * @author Randy Hudson
 * @since 2.1.2
 */
class SortSubgraphs extends GraphVisitor {
  CompoundDirectedGraph g;
  List<NestingTree> nestingTrees;
  Set orderingGraphEdges = new Set();
  Set orderingGraphNodes = new Set();
  NodePair pair = new NodePair();
  void breakSubgraphCycles() {
    List noLefts = new List();
    int index = 1;

    for (var node in orderingGraphNodes) {
      if (node.x == 0) sortedInsert(noLefts, node);
    }

    Node cycleRoot;
    do {
      while (noLefts.length > 0) {
        Node node = noLefts.removeLast();
        node.sortValue = (index++).toDouble();
        orderingGraphNodes.remove(node);
        NodeList rightOfL = rightOf(node);
        if (rightOfL == null) continue;
        for (int i = 0; i < rightOfL.length; i++) {
          Node right = rightOfL[i];
          right.x--;
          if (right.x == 0) sortedInsert(noLefts, right);
        }
      }
      cycleRoot = null;
      double min = double.INFINITY;
      for (var node in orderingGraphNodes) {
        if (node.sortValue < min) {
          cycleRoot = node;
          min = node.sortValue;
        }
      }
      if (cycleRoot != null) {
        sortedInsert(noLefts, cycleRoot);
        cycleRoot.x = -1;
      }
    } while (cycleRoot != null);
  }
  void buildSubgraphOrderingGraph() {
    RankList ranks = g.ranks;
    nestingTrees = new List<NestingTree>(ranks.length);
    for (int r = 0; r < ranks.length; r++) {
      NestingTree entry = NestingTree.buildNestingTreeForRank(ranks[r]);
      nestingTrees[r] = entry;
      entry.calculateSortValues();
      entry.recursiveSort(false);
    }
    for (int i = 0; i < nestingTrees.length; i++) {
      NestingTree entry = nestingTrees[i];
      buildSubgraphOrderingGraph2(entry);
    }
  }
  void buildSubgraphOrderingGraph2(NestingTree entry) {
    NodePair pair = new NodePair();
    if (entry.isLeaf) return;
    for (int i = 0; i < entry.contents.length; i++) {
      Object right = entry.contents[i];
      if (right is Node) {
        pair.n2 = right;
      } else {
        pair.n2 = (right as NestingTree).subgraph;
        buildSubgraphOrderingGraph2(right);
      }
      if (pair.n1 != null && !orderingGraphEdges.contains(pair)) {
        orderingGraphEdges.add(pair);
        leftToRight(pair.n1, pair.n2);
        orderingGraphNodes.add(pair.n1);
        orderingGraphNodes.add(pair.n2);
        pair.n2.x++;
        pair = new NodePair(pair.n2, null);
      } else {
        pair.n1 = pair.n2;
      }
    }
  }
  /**
   * Calculates the average position P for each node and subgraph. The average
   * position is stored in the sortValue for each node or subgraph.
   * Runs in approximately linear time with respect to the number of nodes,
   * including virtual nodes.
   */
  void calculateSortValues() {
    RankList ranks = g.ranks;
    g.subgraphs.resetSortValues();
    g.subgraphs.resetIndices();
    for (int r = 0; r < ranks.length; r++) {
      Rank rank = ranks[r];
      for (int j = 0; j < rank.count(); j++) {
        Node node = rank[j];
        node.sortValue = node.index.toDouble();
        Subgraph parent = node.getParent();
        while (parent != null) {
          parent.sortValue += node.sortValue;
          parent.index++;
          parent = parent.getParent();
        }
      }
    }
    for (int i = 0; i < g.subgraphs.length; i++) {
      Subgraph subgraph = g.subgraphs[i];
      subgraph.sortValue /= subgraph.index;
    }
  }
  void repopulateRanks() {
    for (int i = 0; i < nestingTrees.length; i++) {
      Rank rank = g.ranks[i];
      rank.clear();
      nestingTrees[i].repopulateRank(rank);
    }
  }
  NodeList rightOf(Node left) {
    return left.workingData[0];
  }
  void leftToRight(Node left, Node right) {
    rightOf(left).add(right);
  }
  void sortedInsert(List list, Node node) {
    int insert = 0;
    while (insert < list.length && list[insert].sortValue > node.sortValue) insert++;
    list.insertRange(insert, 1, node);
  }
  void topologicalSort() {
    for (int i = 0; i < nestingTrees.length; i++) {
      nestingTrees[i].getSortValueFromSubgraph();
      nestingTrees[i].recursiveSort(false);
    }
  }
  void init() {
    for (int r = 0; r < g.ranks.length; r++) {
      Rank rank = g.ranks[r];
      for (int i = 0; i < rank.count(); i++) {
        Node n = rank[i];
        n.workingData[0] = new NodeList();
      }
    }
    for (int i = 0; i < g.subgraphs.length; i++) {
      Subgraph s = g.subgraphs[i];
      s.workingData[0] = new NodeList();
    }
  }
  void visit(DirectedGraph dg) {
    g = dg;
    init();
    buildSubgraphOrderingGraph();
    calculateSortValues();
    breakSubgraphCycles();
    topologicalSort();
    repopulateRanks();
  }
}
