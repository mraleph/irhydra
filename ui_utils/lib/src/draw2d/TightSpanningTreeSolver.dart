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
 * Finds a tight spanning tree from the graphs edges which induce a valid rank
 * assignment. This process requires that the nodes be initially given a
 * feasible ranking.
 * @author Randy Hudson
 * @since 2.1.2
 */
class TightSpanningTreeSolver extends SpanningTreeVisitor {
  DirectedGraph graph;
  final candidates = new List<Edge>();
  NodeList members = new NodeList();

  void visit(DirectedGraph graph) {
    this.graph = graph;
    init();
    solve();
  }

  Node addEdge(Edge edge) {
    int delta = edge.slack;
    edge.tree = true;
    Node node;
    if (edge.target.flag) {
      delta = -delta;
      node = edge.source;
      setParentEdge(node, edge);
      getSpanningTreeChildren(edge.target).add(edge);
    } else {
      node = edge.target;
      setParentEdge(node, edge);
      getSpanningTreeChildren(edge.source).add(edge);
    }
    members.adjustRankSimple(delta);
    addNode(node);
    return node;
  }

  bool isNodeReachable(Node node) {
    return node.flag;
  }

  void setNodeReachable(Node node) {
    node.flag = true;
  }

  bool isCandidate(Edge e) {
    return e.flag;
  }

  void setCandidate(Edge e) {
    e.flag = true;
  }

  void addNode(Node node) {
    setNodeReachable(node);
    EdgeList list = node.incoming;
    Edge e;
    for (int i = 0; i < list.length; i++) {
      e = list[i];
      if (!isNodeReachable(e.source)) {
        if (!isCandidate(e)) {
          setCandidate(e);
          candidates.add(e);
        }
      } else {
        Collections.remove(candidates, e);
      }
    }
    list = node.outgoing;
    for (int i = 0; i < list.length; i++) {
      e = list[i];
      if (!isNodeReachable(e.target)) {
        if (!isCandidate(e)) {
          setCandidate(e);
          candidates.add(e);
        }
      } else {
        Collections.remove(candidates, e);
      }

    }
    members.add(node);
  }

  void init() {
    graph.edges.resetFlags(true);
    graph.nodes.resetFlags();
    for (int i = 0; i < graph.nodes.length; i++) {
      Node node = graph.nodes[i];
      node.workingData[0] = new EdgeList();
    }
  }

  void solve() {
    Node root = graph.nodes[0];
    setParentEdge(root, null);
    addNode(root);
    while (members.length < graph.nodes.length) {
      if (candidates.isEmpty) throw ("graph is not fully connected");
      int minSlack = Integer.MAX_VALUE, slack;
      Edge minEdge = null, edge;
      for (int i = 0; i < candidates.length && minSlack > 0; i++) {
        edge = candidates[i];
        slack = edge.slack;
        if (slack < minSlack) {
          minSlack = slack;
          minEdge = edge;
        }
      }
      addEdge(minEdge);
    }
    graph.nodes.normalizeRanks();
  }
}
