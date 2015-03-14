/**
 * Copyright (c) 2004, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */

part of draw2d.graph;

/**
 * Encapsulates the conversion of a long edge to multiple short edges and back.
 * @since 3.1
 */
class VirtualNodeCreation extends RevertableChange {
  final Edge edge;
  final DirectedGraph graph;
  List<Node> nodes;
  List<Edge> edges;
  static final int INNER_EDGE_X = 2;
  static final int LONG_EDGE_X = 8;
  VirtualNodeCreation(Edge this.edge, DirectedGraph this.graph) {
    int size = edge.target.rank - edge.source.rank - 1;
    int offset = edge.source.rank + 1;
    Node prevNode = edge.source;
    Node currentNode;
    Edge currentEdge;
    nodes = new List<Node>(size);
    edges = new List<Edge>(size + 1);
    Insets padding = new Insets(0, edge.padding, 0, edge.padding);
    Subgraph s = GraphUtilities.getCommonAncestor(edge.source, edge.target);
    for (int i = 0; i < size; i++) {
      nodes[i] = currentNode = new Node(data: "Virtual$i:$edge", parent: s);
      currentNode.width = 1;
      if (s != null) {
        currentNode.nestingIndex = s.nestingIndex;
      }
      currentNode.height = 0;
      currentNode.padding = padding;
      currentNode.rank = offset + i;
      graph.ranks[offset + i].add(currentNode);
      currentEdge = new Edge(prevNode, currentNode, delta: 1, weight: edge.weight * LONG_EDGE_X);
      if (i == 0) {
        currentEdge.weight = edge.weight * INNER_EDGE_X;
      }
      graph.edges.add(edges[i] = currentEdge);
      graph.nodes.add(currentNode);
      prevNode = currentNode;
    }
    currentEdge = new Edge(prevNode, edge.target, delta: 1, weight: edge.weight * INNER_EDGE_X);
    graph.edges.add(edges[edges.length - 1] = currentEdge);
    graph.removeEdge(edge);
  }
  void revert() {
    edge.start = edges[0].start;
    edge.end = edges[edges.length - 1].end;
    edge.vNodes = new NodeList();
    for (int i = 0; i < edges.length; i++) {
      graph.removeEdge(edges[i]);
    }
    for (int i = 0; i < nodes.length; i++) {
      edge.vNodes.add(nodes[i]);
      graph.removeNode(nodes[i]);
    }
    edge.source.outgoing.add(edge);
    edge.target.incoming.add(edge);
    graph.edges.add(edge);
  }
}
