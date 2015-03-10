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
 * Places nodes into ranks for a compound directed graph. If a subgraph spans a
 * rank without any nodes which belong to that rank, a bridge node is inserted
 * to prevent nodes from violating the subgraph boundary.
 *
 * @author Randy Hudson
 * @since 2.1.2
 */
class CompoundPopulateRanks extends PopulateRanks {

  void visit(CompoundDirectedGraph graph) {
    /**
     * Remove long containment edges at this point so they don't affect
     * MinCross.
     */
    for (var e in graph.containment.where((e) => e.slack > 0)) {
      graph.removeEdge(e);
    }
    graph.containment.removeWhere((e) => e.slack > 0);

    super.visit(graph);

    for (var subgraph in graph.subgraphs) {
      bridgeSubgraph(subgraph, graph);
    }
  }

  /**
   * @param subgraph
   */
  void bridgeSubgraph(Subgraph subgraph, CompoundDirectedGraph g) {
    int offset = subgraph.head.rank;
    List<bool> occupied = new List.filled(subgraph.tail.rank - subgraph.head.rank + 1, false);
    List<Node> bridge = new List(occupied.length);

    for (var n in subgraph.members) {
      if (n is Subgraph) {
        for (int r = n.head.rank; r <= n.tail.rank; r++)
          occupied[r - offset] = true;
      } else
        occupied[n.rank - offset] = true;
    }

    for (int i = 0; i < bridge.length; i++) {
      if (!occupied[i]) {
        Node br = bridge[i] = new Node(data: "bridge", parent: subgraph); //$NON-NLS-1$
        br.rank = i + offset;
        br.height = br.width = 0;
        br.nestingIndex = subgraph.nestingIndex;
        g.ranks[br.rank].add(br);
        g.nodes.add(br);
      }
    }
  }

}
