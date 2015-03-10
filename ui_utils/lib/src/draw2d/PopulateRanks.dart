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
 * This class takes a DirectedGraph with an optimal rank assignment and a
 * spanning tree, and populates the ranks of the DirectedGraph. Virtual nodes
 * are inserted for edges that span 1 or more ranks.
 * <P>
 * Ranks are populated using a pre-order depth-first traversal of the spanning
 * tree. For each node, all edges requiring virtual nodes are added to the
 * ranks.
 * @author Randy Hudson
 * @since 2.1.2
 */
class PopulateRanks extends GraphVisitor {
  final List<RevertableChange> changes = <RevertableChange>[];

  /**
   * @see GraphVisitor#visit(DirectedGraph)
   */
  void visit(DirectedGraph g) {
    if (g.forestRoot != null) {
      for (int i = g.forestRoot.outgoing.length - 1; i >= 0; i--) {
        g.removeEdge(g.forestRoot.outgoing[i]);
      }
      g.removeNode(g.forestRoot);
    }

    g.ranks = new RankList();
    for (var node in g.nodes) {
      g.ranks[node.rank].add(node);
    }

    for (var i = 0; i < g.nodes.length; i++) {
      final node = g.nodes[i];
      for (int j = 0; j < node.outgoing.length;) {
        Edge e = node.outgoing[j];
        if (e.length > 1) {
          changes.add(new VirtualNodeCreation(e, g));
        } else {
          j++;
        }
      }
    }
  }

  /**
   * @see GraphVisitor#revisit(DirectedGraph)
   */
  void revisit(DirectedGraph g) {
    for (var rank in g.ranks) {
      Node prev;
      for (var cur in rank) {
        cur.left = prev;
        if (prev != null) prev.right = cur;
        prev = cur;
      }
    }

    for (var change in changes) change.revert();
  }
}
