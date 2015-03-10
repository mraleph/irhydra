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
 * Some utility methods for graphs.
 * @author Eric Bordeau
 * @since 2.1.2
 */
class GraphUtilities {
  static Subgraph getCommonAncestor(Node left, Node right) {
    Subgraph parent;
    if (right is Subgraph)
      parent = right;
    else
      parent = right.parent;
    while (parent != null) {
      if (parent.isNested(left))
        return parent;
      parent = parent.parent;
    }
    return null;
  }

  /**
   * Counts the number of edge crossings in a DirectedGraph
   * @param graphthe graph whose crossed edges are counted
   * @return the number of edge crossings in the graph
   */
  static int numberOfCrossingsInGraph(DirectedGraph graph) {
    int crossings = 0;
    for (var rank in graph.ranks) {
      crossings += numberOfCrossingsInRank(rank);
    }
    return crossings;
  }
  /**
   * Counts the number of edge crossings in a Rank
   * @param rankthe rank whose crossed edges are counted
   * @return the number of edge crossings in the rank
   */
  static int numberOfCrossingsInRank(Rank rank) {
    int crossings = 0;
    for (int i = 0; i < rank.length - 1; i++) {
      Node currentNode = rank[i];
      Node nextNode;
      for (int j = i + 1; j < rank.length; j++) {
        nextNode = rank[j];
        EdgeList currentOutgoing = currentNode.outgoing;
        EdgeList nextOutgoing = nextNode.outgoing;
        for (int k = 0; k < currentOutgoing.length; k++) {
          Edge currentEdge = currentOutgoing[k];
          for (int l = 0; l < nextOutgoing.length; l++) {
            if (nextOutgoing[l].getIndexForRank(currentNode.rank + 1) < currentEdge.getIndexForRank(currentNode.rank + 1)) crossings++;
          }
        }
      }
    }
    return crossings;
  }
  static NodeList search(Node node, NodeList list) {
    if (node.flag) return list;
    node.flag = true;
    list.add(node);
    for (int i = 0; i < node.outgoing.length; i++) search(node.outgoing[i].target, list);
    return list;
  }
  /**
   * Returns <code>true</code> if adding an edge between the 2 given nodes
   * will introduce a cycle in the containing graph.
   * @param sourcethe potential source node
   * @param targetthe potential target node
   * @return whether an edge between the 2 given nodes will introduce a cycle
   */
  static bool willCauseCycle(Node source, Node target) {
    NodeList nodes = search(target, new NodeList());
    nodes.resetFlags();
    return nodes.contains(source);
  }
}
