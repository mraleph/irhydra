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
 * This visitor eliminates cycles in the graph via a modified implementation of
 * the greedy cycle removal algorithm for directed graphs. The algorithm has
 * been modified to handle the presence of Subgraphs and compound cycles which
 * may result. This algorithm determines a set of edges which can be inverted
 * and result in a graph without compound cycles.
 * @author Daniel Lee
 * @author Randy Hudson
 * @since 2.1.2
 */
class CompoundBreakCycles extends GraphVisitor {
  NodeList graphNodes;
  NodeList sL = new NodeList();

  bool allFlagged(NodeList nodes) {
    return nodes.every((node) => node.flag);
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
  bool canBeRemoved(Node n) {
    return !n.flag && getChildCount(n) == 0;
  }
  bool changeInDegree(Node n, int delta) {
    return (n.workingInts[1] += delta) == 0;
  }
  bool changeOutDegree(Node n, int delta) {
    return (n.workingInts[2] += delta) == 0;
  }
  void cycleRemove(NodeList children) {
    NodeList sR = new NodeList();
    do {
      findSinks(children, sR);
      findSources(children);
      Node max = findNodeWithMaxDegree(children);
      if (max != null) {
        for (int i = 0; i < children.length; i++) {
          Node child = children.get(i);
          if (child.flag) continue;
          if (child == max) restoreSinks(max, sR); else restoreSources(child);
        }
        remove(max);
      }
    } while (!allFlagged(children));
    while (!sR.isEmpty) sL.add(sR.removeLast());
  }
  void findInitialSinks(NodeList children, NodeList sinks) {
    for (int i = 0; i < children.length; i++) {
      Node node = children[i];
      if (node.flag) continue;
      if (isSink(node) && canBeRemoved(node)) {
        sinks.add(node);
        node.flag = true;
      }
      if (node is Subgraph) findInitialSinks((node).members, sinks);
    }
  }
  void findInitialSources(NodeList children, NodeList sources) {
    for (int i = 0; i < children.length; i++) {
      Node node = children[i];
      if (isSource(node) && canBeRemoved(node)) {
        sources.add(node);
        node.flag = true;
      }
      if (node is Subgraph) findInitialSources((node).members, sources);
    }
  }
  Node findNodeWithMaxDegree(NodeList nodes) {
    int max = Integer.MIN_VALUE;
    Node maxNode = null;
    for (int i = 0; i < nodes.length; i++) {
      Node node = nodes[i];
      if (node.flag) continue;
      int degree = getNestedOutDegree(node) - getNestedInDegree(node);
      if (degree >= max && node.flag == false) {
        max = degree;
        maxNode = node;
      }
    }
    return maxNode;
  }
  void findSinks(NodeList children, NodeList rightList) {
    NodeList sinks = new NodeList();
    findInitialSinks(children, sinks);
    while (!sinks.isEmpty) {
      Node sink = sinks[sinks.length - 1];
      rightList.add(sink);
      sinks.remove(sink);
      removeSink(sink, sinks);
      if (sink.getParent() != null) {
        Node parent = sink.getParent();
        setChildCount(parent, getChildCount(parent) - 1);
        if (isSink(parent) && canBeRemoved(parent)) {
          sinks.add(parent);
          parent.flag = true;
        }
      }
    }
  }
  void findSources(NodeList children) {
    NodeList sources = new NodeList();
    findInitialSources(children, sources);
    while (!sources.isEmpty) {
      Node source = sources[sources.length - 1];
      sL.add(source);
      sources.remove(source);
      removeSource(source, sources);
      if (source.getParent() != null) {
        Node parent = source.getParent();
        setChildCount(parent, getChildCount(parent) - 1);
        if (isSource(parent) && canBeRemoved(parent)) {
          sources.add(parent);
          parent.flag = true;
        }
      }
    }
  }
  int getChildCount(Node n) {
    return n.workingInts[3];
  }
  int getInDegree(Node n) {
    return n.workingInts[1];
  }
  int getNestedInDegree(Node n) {
    int result = getInDegree(n);
    if (n is Subgraph) {
      Subgraph s = n;
      for (int i = 0; i < s.members.length; i++)
        if (!s.members[i].flag)
          result += getInDegree(s.members[i]);
    }
    return result;
  }
  int getNestedOutDegree(Node n) {
    int result = getOutDegree(n);
    if (n is Subgraph) {
      Subgraph s = n;
      for (int i = 0; i < s.members.length; i++)
        if (!s.members[i].flag)
          result += getOutDegree(s.members[i]);
    }
    return result;
  }
  int getOrderIndex(Node n) {
    return n.workingInts[0];
  }
  int getOutDegree(Node n) {
    return n.workingInts[2];
  }
  void initializeDegrees(DirectedGraph g) {
    g.nodes.resetFlags();
    g.edges.resetFlags(false);
    for (int i = 0; i < g.nodes.length; i++) {
      Node n = g.nodes[i];
      setInDegree(n, n.incoming.length);
      setOutDegree(n, n.outgoing.length);
      if (n is Subgraph) setChildCount(n, (n).members.length); else setChildCount(n, 0);
    }
  }
  void invertEdges(DirectedGraph g) {
    int orderIndex = 0;
    for (int i = 0; i < sL.length; i++) {
      setOrderIndex(sL[i], orderIndex++);
    }
    for (int i = 0; i < g.edges.length; i++) {
      Edge e = g.edges[i];
      if (getOrderIndex(e.source) > getOrderIndex(e.target) && !e.source.isNested(e.target) && !e.target.isNested(e.source)) {
        e.invert();
        e.isFeedback = true;
      }
    }
  }
  /**
   * Removes all edges connecting the given subgraph to other nodes outside of
   * it.
   * @param s
   * @param n
   */
  void isolateSubgraph(Subgraph subgraph, Node member) {
    Edge edge = null;
    for (int i = 0; i < member.incoming.length; i++) {
      edge = member.incoming[i];
      if (!subgraph.isNested(edge.source) && !edge.flag) removeEdge(edge);
    }
    for (int i = 0; i < member.outgoing.length; i++) {
      edge = member.outgoing[i];
      if (!subgraph.isNested(edge.target) && !edge.flag) removeEdge(edge);
    }
    if (member is Subgraph) {
      NodeList members = (member).members;
      for (int i = 0; i < members.length; i++) isolateSubgraph(subgraph, members[i]);
    }
  }
  bool isSink(Node n) {
    return getOutDegree(n) == 0 && (n.getParent() == null || isSink(n.getParent()));
  }
  bool isSource(Node n) {
    return getInDegree(n) == 0 && (n.getParent() == null || isSource(n.getParent()));
  }
  void remove(Node n) {
    n.flag = true;
    if (n.getParent() != null) setChildCount(n.getParent(), getChildCount(n.getParent()) - 1);
    removeSink(n, null);
    removeSource(n, null);
    sL.add(n);
    if (n is Subgraph) {
      Subgraph s = n;
      isolateSubgraph(s, s);
      cycleRemove(s.members);
    }
  }
  bool removeEdge(Edge e) {
    if (e.flag) return false;
    e.flag = true;
    changeOutDegree(e.source, -1);
    changeInDegree(e.target, -1);
    return true;
  }
  /**
   * Removes all edges between a parent and any of its children or
   * descendants.
   */
  void removeParentChildEdges(DirectedGraph g) {
    for (int i = 0; i < g.edges.length; i++) {
      Edge e = g.edges[i];
      if (e.source.isNested(e.target) || e.target.isNested(e.source)) removeEdge(e);
    }
  }
  void removeSink(Node sink, NodeList allSinks) {
    for (int i = 0; i < sink.incoming.length; i++) {
      Edge e = sink.incoming[i];
      if (!e.flag) {
        removeEdge(e);
        Node source = e.source;
        if (allSinks != null && isSink(source) && canBeRemoved(source)) {
          allSinks.add(source);
          source.flag = true;
        }
      }
    }
  }
  void removeSource(Node n, NodeList allSources) {
    for (int i = 0; i < n.outgoing.length; i++) {
      Edge e = n.outgoing[i];
      if (!e.flag) {
        e.flag = true;
        changeInDegree(e.target, -1);
        changeOutDegree(e.source, -1);
        Node target = e.target;
        if (allSources != null && isSource(target) && canBeRemoved(target)) {
          allSources.add(target);
          target.flag = true;
        }
      }
    }
  }
  /**
   * Restores an edge if it has been removed, and both of its nodes are not
   * removed.
   * @param ethe edge
   * @return <code>true</code> if the edge was restored
   */
  bool restoreEdge(Edge e) {
    if (!e.flag || e.source.flag || e.target.flag) return false;
    e.flag = false;
    changeOutDegree(e.source, 1);
    changeInDegree(e.target, 1);
    return true;
  }
  /**
   * Brings back all nodes nested in the given node.
   * @param nodethe node to restore
   * @param srcurrent sinks
   */
  void restoreSinks(Node node, NodeList sR) {
    if (node.flag && sR.contains(node)) {
      node.flag = false;
      if (node.getParent() != null) setChildCount(node.getParent(), getChildCount(node.getParent()) + 1);
      sR.remove(node);
      for (int i = 0; i < node.incoming.length; i++) {
        Edge e = node.incoming[i];
        restoreEdge(e);
      }
      for (int i = 0; i < node.outgoing.length; i++) {
        Edge e = node.outgoing[i];
        restoreEdge(e);
      }
    }
    if (node is Subgraph) {
      Subgraph s = node;
      for (int i = 0; i < s.members.length; i++) {
        Node member = s.members[i];
        restoreSinks(member, sR);
      }
    }
  }
  /**
   * Brings back all nodes nested in the given node.
   * @param nodethe node to restore
   * @param srcurrent sinks
   */
  void restoreSources(Node node) {
    if (node.flag && sL.contains(node)) {
      node.flag = false;
      if (node.getParent() != null) setChildCount(node.getParent(), getChildCount(node.getParent()) + 1);
      sL.remove(node);
      for (int i = 0; i < node.incoming.length; i++) {
        Edge e = node.incoming[i];
        restoreEdge(e);
      }
      for (int i = 0; i < node.outgoing.length; i++) {
        Edge e = node.outgoing[i];
        restoreEdge(e);
      }
    }
    if (node is Subgraph) {
      Subgraph s = node;
      for (int i = 0; i < s.members.length; i++) {
        Node member = s.members[i];
        restoreSources(member);
      }
    }
  }
  void revisit(DirectedGraph g) {
    for (int i = 0; i < g.edges.length; i++) {
      Edge e = g.edges[i];
      if (e.isFeedback) e.invert();
    }
  }
  void setChildCount(Node n, int count) {
    n.workingInts[3] = count;
  }
  void setInDegree(Node n, int deg) {
    n.workingInts[1] = deg;
  }
  void setOrderIndex(Node n, int index) {
    n.workingInts[0] = index;
  }
  void setOutDegree(Node n, int deg) {
    n.workingInts[2] = deg;
  }
  /**
   * @see GraphVisitor#visit(org.eclipse.draw2d.graph.DirectedGraph)
   */
  void visit(DirectedGraph g) {
    initializeDegrees(g);
    graphNodes = g.nodes;
    NodeList roots = new NodeList();
    for (int i = 0; i < graphNodes.length; i++) {
      if (graphNodes[i].getParent() == null) roots.add(graphNodes[i]);
    }
    buildNestingTreeIndices(roots, 0);
    removeParentChildEdges(g);
    cycleRemove(roots);
    invertEdges(g);
  }
}
