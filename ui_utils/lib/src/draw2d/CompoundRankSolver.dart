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

class RowEntry {
  double contribution = 0.0;
  int count = 0;

  void reset() {
    contribution = 0.0;
    count = 0;
  }
}

class RowKey {
  int rank = 0;
  Subgraph s;

  RowKey(Subgraph s, int rank) {
    this.s = s;
    this.rank = rank;
  }

  bool operator == (Object other) =>
    other is RowKey && (other.s == s && other.rank == rank);

  int get hashCode =>
    s.hashCode ^ (rank * 31);
}


/**
 * Sorts nodes in a compound directed graph.
 *
 * @author Randy Hudson
 * @since 2.1.2
 */
class CompoundRankSorter extends RankSorter {
  bool initCalled = false;
  RowKey key = new RowKey(null, 0);

  Map map = new Map();

  void addRowEntry(Subgraph s, int row) {
    key.s = s;
    key.rank = row;
    if (!map.containsKey(key))
      map[new RowKey(s, row)] = new RowEntry();
  }

  void assignIncomingSortValues() {
    super.assignIncomingSortValues();
  }

  void assignOutgoingSortValues() {
    super.assignOutgoingSortValues();
  }

  void optimize(CompoundDirectedGraph graph) {
    graph.containment.forEach(graph.removeEdge);
    graph.containment.clear();
    new LocalOptimizer().visit(graph);
  }

  double evaluateNodeOutgoing() {
    double result = super.evaluateNodeOutgoing();
    // result += Math.random() * rankSize * (1.0 - progress) / 3.0;
    if (progress > 0.2) {
      Subgraph s = node.parent;
      double connectivity = mergeConnectivity(s, node.rank + 1, result,
          progress);
      result = connectivity;
    }
    return result;
  }

  double evaluateNodeIncoming() {
    double result = super.evaluateNodeIncoming();
    // result += Math.random() * rankSize * (1.0 - progress) / 3.0;
    if (progress > 0.2) {
      Subgraph s = node.parent;
      double connectivity = mergeConnectivity(s, node.rank - 1, result,
          progress);
      result = connectivity;
    }
    return result;
  }

  double mergeConnectivity(Subgraph s, int row, double result,
      double scaleFactor) {
    while (s != null && getRowEntry(s, row) == null)
      s = s.parent;
    if (s != null) {
      RowEntry entry = getRowEntry(s, row);
      double connectivity = entry.contribution / entry.count;
      result = connectivity * 0.3 + (0.7) * result;
      s = s.parent;
    }
    return result;
  }

  RowEntry getRowEntry(Subgraph s, int row) {
    key.s = s;
    key.rank = row;
    return map[key];
  }

  void copyConstraints(NestingTree tree) {
    if (tree.subgraph != null)
      tree.sortValue = tree.subgraph.rowOrder.toDouble();
    for (int i = 0; i < tree.contents.length; i++) {
      Object child = tree.contents[i];
      if (child is Node) {
        child.sortValue = child.rowOrder.toDouble();
      } else {
        copyConstraints(child);
      }
    }
  }

  void init(DirectedGraph g) {
    super.init(g);
    initCalled = true;

    for (int row = 0; row < g.ranks.length; row++) {
      Rank rank = g.ranks[row];

      NestingTree tree = NestingTree.buildNestingTreeForRank(rank);
      copyConstraints(tree);
      tree.recursiveSort(true);
      rank.clear();
      tree.repopulateRank(rank);

      for (int j = 0; j < rank.count(); j++) {
        Node n = rank[j];
        Subgraph s = n.parent;
        while (s != null) {
          addRowEntry(s, row);
          s = s.parent;
        }
      }
    }
  }

  void postSort() {
    super.postSort();
    if (initCalled)
      updateRank(rank);
  }

  void updateRank(Rank rank) {
    for (int j = 0; j < rank.count(); j++) {
      Node n = rank[j];
      Subgraph s = n.parent;
      while (s != null) {
        getRowEntry(s, currentRow).reset();
        s = s.parent;
      }
    }
    for (int j = 0; j < rank.count(); j++) {
      Node n = rank[j];
      Subgraph s = n.parent;
      while (s != null) {
        RowEntry entry = getRowEntry(s, currentRow);
        entry.count++;
        entry.contribution += n.index;
        s = s.parent;
      }
    }
  }

}
