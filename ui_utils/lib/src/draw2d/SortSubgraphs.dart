/**
 * Copyright (c) 2003, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */

part of draw2d.graph;

/**
 * Performs a topological sort from left to right of the subgraphs in a compound
 * directed graph. This ensures that subgraphs do not intertwine.
 *
 * @author Randy Hudson
 * @since 2.1.2
 */
class SortSubgraphs extends GraphVisitor {

  CompoundDirectedGraph g;

  List<NestingTree> nestingTrees;

  final Set<NodePair> orderingGraphEdges = new Set<NodePair>();
  final Set<Node> orderingGraphNodes = new Set<Node>();
  NodePair pair = new NodePair();

  void breakSubgraphCycles() {
    // The stack of nodes which have no unmarked incoming edges
    List noLefts = [];

    int index = 1;
    // Identify all initial nodes for removal
    for (Node node in orderingGraphNodes) {
      if (node.x == 0)
        sortedInsert(noLefts, node);
    }

    Node cycleRoot;
    do {
      // Remove all leftmost nodes, updating the nodes to their right
      while (noLefts.length > 0) {
        Node node = noLefts.removeLast();
        node.sortValue = (index++).toDouble();
        orderingGraphNodes.remove(node);
        // System.out.println("removed:" + node);
        NodeList rightOfList = rightOf(node);
        if (rightOfList == null)
          continue;
        for (Node right in rightOfList) {
          right.x--;
          if (right.x == 0)
            sortedInsert(noLefts, right);
        }
      }
      cycleRoot = null;
      double min = double.MAX_FINITE;
      for (Node node in orderingGraphNodes) {
        if (node.sortValue < min) {
          cycleRoot = node;
          min = node.sortValue;
        }
      }
      if (cycleRoot != null) {
        // break the cycle;
        sortedInsert(noLefts, cycleRoot);
        // System.out.println("breaking cycle with:" + cycleRoot);
        // Display.getCurrent().beep();
        cycleRoot.x = -1; // prevent x from ever reaching 0
      } // else if (OGmembers.length > 0)
        //System.out.println("FAILED TO FIND CYCLE ROOT"); //$NON-NLS-1$
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
      buildSubgraphOrderingGraphFor(entry);
    }
  }

  void buildSubgraphOrderingGraphFor(NestingTree entry) {
    NodePair pair = new NodePair();
    if (entry.isLeaf)
      return;
    for (int i = 0; i < entry.contents.length; i++) {
      Object right = entry.contents[i];
      if (right is Node)
        pair.n2 = right;
      else {
        pair.n2 = (right as NestingTree).subgraph;
        buildSubgraphOrderingGraphFor(right);
      }
      if (pair.n1 != null && !orderingGraphEdges.contains(pair)) {
        orderingGraphEdges.add(pair);
        leftToRight(pair.n1, pair.n2);
        orderingGraphNodes.add(pair.n1);
        orderingGraphNodes.add(pair.n2);
        pair.n2.x++; // Using x field to count predecessors.
        pair = new NodePair(pair.n2, null);
      } else {
        pair.n1 = pair.n2;
      }
    }
  }

  /**
   * Calculates the average position P for each node and subgraph. The average
   * position is stored in the sortValue for each node or subgraph.
   *
   * Runs in approximately linear time with respect to the number of nodes,
   * including virtual nodes.
   */
  void calculateSortValues() {
    RankList ranks = g.ranks;

    g.subgraphs.resetSortValues();
    g.subgraphs.resetIndices();

    /*
     * For subgraphs, the sum of all positions is kept, along with the
     * number of contributions, which is tracked in the subgraph's index
     * field.
     */
    for (int r = 0; r < ranks.length; r++) {
      Rank rank = ranks[r];
      for (int j = 0; j < rank.count(); j++) {
        Node node = rank[j];
        node.sortValue = node.index.toDouble();
        Subgraph parent = node.parent;
        while (parent != null) {
          parent.sortValue += node.sortValue;
          parent.index++;
          parent = parent.parent;
        }
      }
    }

    /*
     * For each subgraph, divide the sum of the positions by the number of
     * contributions, to give the average position.
     */
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
    while (insert < list.length
        && (list[insert]).sortValue > node.sortValue)
      insert++;
    list.insert(insert, node);
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

  void visit(CompoundDirectedGraph dg) {
    g = dg;
    init();
    buildSubgraphOrderingGraph();
    calculateSortValues();
    breakSubgraphCycles();
    topologicalSort();
    repopulateRanks();
  }

}
