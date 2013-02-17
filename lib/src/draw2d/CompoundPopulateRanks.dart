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
 * Places nodes into ranks for a compound directed graph. If a subgraph spans a
 * rank without any nodes which belong to that rank, a bridge node is inserted
 * to prevent nodes from violating the subgraph boundary.
 * @author Randy Hudson
 * @since 2.1.2
 */
class CompoundPopulateRanks extends PopulateRanks {
  void visit(DirectedGraph g) {
    CompoundDirectedGraph graph = g;

    graph.containment.removeMatching((edge) {
      if (edge.slack > 0) {
        graph.removeEdge(edge);
        return true;
      }
      return false;
    });

    super.visit(g);

    NodeList subgraphs = graph.subgraphs;
    for (int i = 0; i < subgraphs.length; i++) {
      Subgraph subgraph = subgraphs.get(i);
      bridgeSubgraph(subgraph, graph);
    }
  }
  /**
   * @param subgraph
   */
  void bridgeSubgraph(Subgraph subgraph, CompoundDirectedGraph g) {
    int offset = subgraph.head.rank;
    List<bool> occupied = new List<bool>(subgraph.tail.rank - subgraph.head.rank + 1);
    List<Node> bridge = new List<Node>(occupied.length);
    for (int i = 0; i < subgraph.members.length; i++) {
      Node n = subgraph.members.get(i);
      if (n is Subgraph) {
        Subgraph s = n;
        for (int r = s.head.rank; r <= s.tail.rank; r++) occupied[r - offset] = true;
      } else occupied[n.rank - offset] = true;
    }
    for (int i = 0; i < bridge.length; i++) {
      if (!occupied[i]) {
        Node br = bridge[i] = new Node(data: "bridge", parent: subgraph);
        br.rank = i + offset;
        br.height = br.width = 0;
        br.nestingIndex = subgraph.nestingIndex;
        g.ranks[br.rank].add(br);
        g.nodes.add(br);
      }
    }
  }
}
