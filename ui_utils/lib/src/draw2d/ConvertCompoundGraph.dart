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
 * Converts a compound directed graph into a simple directed graph.
 *
 * @author Randy Hudson
 * @since 2.1.2
 */
class ConvertCompoundGraph extends GraphVisitor {

  void addContainmentEdges(CompoundDirectedGraph graph) {
    // For all nested nodes, connect to head and/or tail of containing
    // subgraph if present
    for (int i = 0; i < graph.nodes.length; i++) {
      Node node = graph.nodes[i];
      Subgraph parent = node.parent;
      if (parent == null)
        continue;
      if (node is Subgraph) {
        Subgraph sub = node;
        connectHead(graph, sub.head, parent);
        connectTail(graph, sub.tail, parent);
      } else {
        connectHead(graph, node, parent);
        connectTail(graph, node, parent);
      }
    }
  }

  int buildNestingTreeIndices(NodeList nodes, int base) {
    for (int i = 0; i < nodes.length; i++) {
      Node node = nodes[i];
      if (node is Subgraph) {
        Subgraph s = node;
        s.nestingTreeMin = base;
        base = buildNestingTreeIndices(s.members, base);
      }
      node.nestingIndex = base++;
    }
    return base++;
  }

  void connectHead(CompoundDirectedGraph graph, Node node,
      Subgraph parent) {
    bool connectHead = true;
    for (int j = 0; connectHead && j < node.incoming.length; j++) {
      Node ancestor = node.incoming[j].source;
      if (parent.isNested(ancestor))
        connectHead = false;
    }
    if (connectHead) {
      Edge e = new Edge(parent.head, node);
      e.weight = 0;
      graph.edges.add(e);
      graph.containment.add(e);
    }
  }

  void connectTail(CompoundDirectedGraph graph, Node node,
      Subgraph parent) {
    bool connectTail = true;
    for (int j = 0; connectTail && j < node.outgoing.length; j++) {
      Node ancestor = node.outgoing[j].target;
      if (parent.isNested(ancestor))
        connectTail = false;
    }
    if (connectTail) {
      Edge e = new Edge(node, parent.tail);
      e.weight = 0;
      graph.edges.add(e);
      graph.containment.add(e);
    }
  }

  void convertSubgraphEndpoints(CompoundDirectedGraph graph) {
    for (int i = 0; i < graph.edges.length; i++) {
      Edge edge = graph.edges[i];
      if (edge.source is Subgraph) {
        Subgraph s = edge.source;
        Node newSource;
        if (s.isNested(edge.target))
          newSource = s.head;
        else
          newSource = s.tail;
        // s.outgoing.remove(edge);
        edge.source = newSource;
        newSource.outgoing.add(edge);
      }
      if (edge.target is Subgraph) {
        Subgraph s = edge.target;
        Node newTarget;
        if (s.isNested(edge.source))
          newTarget = s.tail;
        else
          newTarget = s.head;

        // s.incoming.remove(edge);
        edge.target = newTarget;
        newTarget.incoming.add(edge);
      }
    }
  }

  void replaceSubgraphsWithBoundaries(CompoundDirectedGraph graph) {
    for (int i = 0; i < graph.subgraphs.length; i++) {
      Subgraph s = graph.subgraphs[i];
      graph.nodes.add(s.head);
      graph.nodes.add(s.tail);
      graph.nodes.remove(s);
    }
  }

  void revisit(DirectedGraph g) {
    for (int i = 0; i < g.edges.length; i++) {
      Edge e = g.edges[i];
      if (e.source is SubgraphBoundary) {
        e.source.outgoing.remove(e);
        e.source = e.source.parent;
      }
      if (e.target is SubgraphBoundary) {
        e.target.incoming.remove(e);
        e.target = e.target.parent;
      }
    }
  }

  /**
   * @see GraphVisitor#visit(org.eclipse.draw2d.graph.DirectedGraph)
   */
  void visit(DirectedGraph dg) {
    CompoundDirectedGraph graph = dg;

    NodeList roots = new NodeList();
    // Find all subgraphs and root subgraphs
    for (int i = 0; i < graph.nodes.length; i++) {
      Object node = graph.nodes[i];
      if (node is Subgraph) {
        Subgraph s = node;
        Insets padding = dg.getPadding(s);
        s.head = new SubgraphBoundary(s, padding, 0);
        s.tail = new SubgraphBoundary(s, padding, 2);
        Edge headToTail = new Edge(s.head, s.tail);
        headToTail.weight = 10;
        graph.edges.add(headToTail);
        graph.containment.add(headToTail);

        graph.subgraphs.add(s);
        if (s.parent == null)
          roots.add(s);
        if (s.members.length == 2) // The 2 being the head and tail only
          graph.edges.add(new Edge(s.head, s.tail));
      }
    }

    buildNestingTreeIndices(roots, 0);
    convertSubgraphEndpoints(graph);
    addContainmentEdges(graph);
    replaceSubgraphsWithBoundaries(graph);
  }

}
