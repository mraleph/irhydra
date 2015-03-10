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
 * Assigns the final rank assignment for a DirectedGraph with an initial
 * feasible spanning tree.
 * @author Randy Hudson
 * @since 2.1.2
 */
class RankAssignmentSolver extends SpanningTreeVisitor {
  DirectedGraph graph;
  EdgeList spanningTree;
  bool searchDirection = false;
  int depthFirstCutValue(Edge edge, int count) {
    Node n = getTreeTail(edge);
    setTreeMin(n, count);
    int cutvalue = 0;
    int multiplier = (edge.target == n) ? 1 : -1;
    EdgeList list;
    list = n.outgoing;
    Edge e;
    for (int i = 0; i < list.length; i++) {
      e = list[i];
      if (e.tree && e != edge) {
        count = depthFirstCutValue(e, count);
        cutvalue += (e.cut - e.weight) * multiplier;
      } else {
        cutvalue -= e.weight * multiplier;
      }
    }
    list = n.incoming;
    for (int i = 0; i < list.length; i++) {
      e = list[i];
      if (e.tree && e != edge) {
        count = depthFirstCutValue(e, count);
        cutvalue -= (e.cut - e.weight) * multiplier;
      } else {
        cutvalue += e.weight * multiplier;
      }
    }
    edge.cut = cutvalue;
    if (cutvalue < 0) spanningTree.add(edge);
    setTreeMax(n, count);
    return count + 1;
  }
  /**
   * returns the Edge which should be entered.
   * @param branch
   * @return Edge
   */
  Edge enter(Node branch) {
    Node n;
    Edge result = null;
    int minSlack = Integer.MAX_VALUE;
    bool incoming = getParentEdge(branch).target != branch;
    for (int i = 0; i < graph.nodes.length; i++) {
      if (searchDirection) {
        n = graph.nodes[i];
      } else {
        n = graph.nodes[graph.nodes.length - 1 - i];
      }
      if (subtreeContains(branch, n)) {
        EdgeList edges;
        if (incoming) edges = n.incoming; else edges = n.outgoing;
        for (int j = 0; j < edges.length; j++) {
          Edge e = edges[j];
          if (!subtreeContains(branch, e.opposite(n)) && !e.tree && e.slack < minSlack) {
            result = e;
            minSlack = e.slack;
          }
        }
      }
    }
    return result;
  }
  int getTreeMax(Node n) {
    return n.workingInts[1];
  }
  int getTreeMin(Node n) {
    return n.workingInts[0];
  }
  void initCutValues() {
    Node root = graph.nodes[0];
    spanningTree = new EdgeList();
    Edge e;
    setTreeMin(root, 1);
    setTreeMax(root, 1);
    for (int i = 0; i < root.outgoing.length; i++) {
      e = root.outgoing[i];
      if (!getSpanningTreeChildren(root).contains(e)) continue;
      setTreeMax(root, depthFirstCutValue(e, getTreeMax(root)));
    }
    for (int i = 0; i < root.incoming.length; i++) {
      e = root.incoming[i];
      if (!getSpanningTreeChildren(root).contains(e)) continue;
      setTreeMax(root, depthFirstCutValue(e, getTreeMax(root)));
    }
  }
  Edge leave() {
    Edge result = null;
    Edge e;
    int minCut = 0;
    int weight = -1;
    for (int i = 0; i < spanningTree.length; i++) {
      e = spanningTree[i];
      if (e.cut < minCut) {
        result = e;
        minCut = result.cut;
        weight = result.weight;
      } else if (e.cut == minCut && e.weight > weight) {
        result = e;
        weight = result.weight;
      }
    }
    return result;
  }
  void networkSimplexLoop() {
    Edge leave, enter;
    int count = 0;
    while ((leave = this.leave()) != null && count < 900) {
      count++;
      Node leaveTail = getTreeTail(leave);
      Node leaveHead = getTreeHead(leave);
      enter = this.enter(leaveTail);
      if (enter == null) break;
      getSpanningTreeChildren(leaveHead).remove(leave);
      setParentEdge(leaveTail, null);
      leave.tree = false;
      spanningTree.remove(leave);
      Node enterTail = enter.source;
      if (!subtreeContains(leaveTail, enterTail)) enterTail = enter.target;
      Node enterHead = enter.opposite(enterTail);
      updateSubgraph(enterTail);
      getSpanningTreeChildren(enterHead).add(enter);
      setParentEdge(enterTail, enter);
      enter.tree = true;
      repairCutValues(enter);
      Node commonAncestor = enterHead;
      while (!subtreeContains(commonAncestor, leaveHead)) {
        repairCutValues(getParentEdge(commonAncestor));
        commonAncestor = getTreeParent(commonAncestor);
      }
      while (leaveHead != commonAncestor) {
        repairCutValues(getParentEdge(leaveHead));
        leaveHead = getTreeParent(leaveHead);
      }
      updateMinMax(commonAncestor, getTreeMin(commonAncestor));
      tightenEdge(enter);
    }
  }
  void repairCutValues(Edge edge) {
    spanningTree.remove(edge);
    Node n = getTreeTail(edge);
    int cutvalue = 0;
    int multiplier = (edge.target == n) ? 1 : -1;
    EdgeList list;
    list = n.outgoing;
    Edge e;
    for (int i = 0; i < list.length; i++) {
      e = list[i];
      if (e.tree && e != edge) {
        cutvalue += (e.cut - e.weight) * multiplier;
      } else {
        cutvalue -= e.weight * multiplier;
      }
    }
    list = n.incoming;
    for (int i = 0; i < list.length; i++) {
      e = list[i];
      if (e.tree && e != edge) {
        cutvalue -= (e.cut - e.weight) * multiplier;
      } else {
        cutvalue += e.weight * multiplier;
      }
    }
    edge.cut = cutvalue;
    if (cutvalue < 0) spanningTree.add(edge);
  }
  void setTreeMax(Node n, int value) {
    n.workingInts[1] = value;
  }
  void setTreeMin(Node n, int value) {
    n.workingInts[0] = value;
  }
  bool subtreeContains(Node parent, Node child) {
    return parent.workingInts[0] <= child.workingInts[1] && child.workingInts[1] <= parent.workingInts[1];
  }
  void tightenEdge(Edge edge) {
    Node tail = getTreeTail(edge);
    int delta = edge.slack;
    if (tail == edge.target) delta = -delta;
    Node n;
    for (int i = 0; i < graph.nodes.length; i++) {
      n = graph.nodes[i];
      if (subtreeContains(tail, n)) n.rank += delta;
    }
  }
  int updateMinMax(Node root, int count) {
    setTreeMin(root, count);
    EdgeList edges = getSpanningTreeChildren(root);
    for (int i = 0; i < edges.length; i++) count = updateMinMax(getTreeTail(edges[i]), count);
    setTreeMax(root, count);
    return count + 1;
  }
  void updateSubgraph(Node root) {
    Edge flip = getParentEdge(root);
    if (flip != null) {
      Node rootParent = getTreeParent(root);
      getSpanningTreeChildren(rootParent).remove(flip);
      updateSubgraph(rootParent);
      setParentEdge(root, null);
      setParentEdge(rootParent, flip);
      repairCutValues(flip);
      getSpanningTreeChildren(root).add(flip);
    }
  }
  void visit(DirectedGraph graph) {
    this.graph = graph;
    initCutValues();
    networkSimplexLoop();
    if (graph.forestRoot == null) graph.nodes.normalizeRanks(); else normalizeForest();
  }
  void normalizeForest() {
    NodeList tree = new NodeList();
    graph.nodes.resetFlags();
    graph.forestRoot.flag = true;
    EdgeList rootEdges = graph.forestRoot.outgoing;
    List stack = new List();
    for (int i = 0; i < rootEdges.length; i++) {
      Node node = rootEdges[i].target;
      node.flag = true;
      stack.add(node);
      while (!stack.isEmpty) {
        node = stack.removeLast();
        tree.add(node);
        final neighbors = node.iteratorNeighbors();
        while (neighbors.hasNext()) {
          Node neighbor = neighbors.next();
          if (!neighbor.flag) {
            neighbor.flag = true;
            stack.add(neighbor);
          }
        }
      }
      tree.normalizeRanks();
      tree.clear();
    }
  }
}
