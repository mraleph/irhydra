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
 * Assigns a valid rank assignment to all nodes based on their edges. The
 * assignment is not optimal in that it does not provide the minimum global
 * length of edge lengths.
 * @author Randy Hudson
 * @since 2.1.2
 */
class InitialRankSolver extends GraphVisitor {
  DirectedGraph graph;
  EdgeList candidates = new EdgeList();
  NodeList members = new NodeList();
  void visit(DirectedGraph graph) {
    this.graph = graph;
    graph.edges.resetFlags(false);
    graph.nodes.resetFlags();
    solve();
  }
  void solve() {
    if (graph.nodes.length == 0) return;
    NodeList unranked = new NodeList(graph.nodes);
    NodeList rankMe = new NodeList();
    Node node;
    int i;
    while (!unranked.isEmpty) {
      rankMe.clear();
      for (i = 0; i < unranked.length;) {
        node = unranked[i];
        if (node.incoming.isCompletelyFlagged()) {
          rankMe.add(node);
          unranked.removeAt(i);
        } else i++;
      }
      if (rankMe.length == 0) throw ("Cycle detected in graph");
      for (i = 0; i < rankMe.length; i++) {
        node = rankMe[i];
        assignMinimumRank(node);
        node.outgoing.setFlags(true);
      }
    }
    connectForest();
  }
  void connectForest() {
    List forest = new List();
    List stack = new List();
    NodeList tree;
    graph.nodes.resetFlags();
    for (int i = 0; i < graph.nodes.length; i++) {
      Node neighbor, n = graph.nodes[i];
      if (n.flag) continue;
      tree = new NodeList();
      stack.add(n);
      while (!stack.isEmpty) {
        n = stack.removeLast();
        n.flag = true;
        tree.add(n);
        for (int s = 0; s < n.incoming.length; s++) {
          neighbor = n.incoming[s].source;
          if (!neighbor.flag) stack.add(neighbor);
        }
        for (int s = 0; s < n.outgoing.length; s++) {
          neighbor = n.outgoing[s].target;
          if (!neighbor.flag) stack.add(neighbor);
        }
      }
      forest.add(tree);
    }
    if (forest.length > 1) {
      graph.forestRoot = new Node(data: "the forest root");
      graph.nodes.add(graph.forestRoot);
      for (var tree in forest) {
        graph.edges.add(new Edge(graph.forestRoot, tree[0], delta: 0, weight: 0));
      }
    }
  }
  void assignMinimumRank(Node node) {
    int rank = 0;
    Edge e;
    for (int i1 = 0; i1 < node.incoming.length; i1++) {
      e = node.incoming[i1];
      rank = Math.max(rank, e.delta + e.source.rank);
    }
    node.rank = rank;
  }
}
