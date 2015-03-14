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

class ClusterSet {
  final HorizontalPlacement placement;

  ClusterSet(this.placement);

  int freedom = Integer.MAX_VALUE;
  bool isRight = false;
  List members = new List();
  int pullWeight = 0;
  int rawPull = 0;



  bool addCluster(NodeCluster seed) {
    members.add(seed);
    seed.isSetMember = true;
    rawPull += seed.weightedTotal;
    pullWeight += seed.weightedDivisor;
    if (isRight) {
      freedom = Math.min(freedom, seed.rightNonzero);
      if (freedom == 0 || rawPull <= 0) return true;
      addIncomingClusters(seed);
      if (addOutgoingClusters(seed)) return true;
    } else {
      freedom = Math.min(freedom, seed.leftNonzero);
      if (freedom == 0 || rawPull >= 0) return true;
      addOutgoingClusters(seed);
      if (addIncomingClusters(seed)) return true;
    }
    return false;
  }
  bool addIncomingClusters(NodeCluster seed) {
    for (int i = 0; i < seed.leftCount; i++) {
      NodeCluster neighbor = seed.leftNeighbors[i];
      if (neighbor.isSetMember) continue;
      CollapsedEdges edges = seed.leftLinks[i];
      if (!edges.isTight) continue;
      if ((!isRight || neighbor.getPull() > 0) && addCluster(neighbor)) return true;
    }
    return false;
  }
  bool addOutgoingClusters(NodeCluster seed) {
    for (int i = 0; i < seed.rightCount; i++) {
      NodeCluster neighbor = seed.rightNeighbors[i];
      if (neighbor.isSetMember) continue;
      CollapsedEdges edges = seed.rightLinks[i];
      if (!edges.isTight) continue;
      if ((isRight || neighbor.getPull() < 0) && addCluster(neighbor)) return true;
    }
    return false;
  }
  bool build(NodeCluster seed) {
    isRight = seed.weightedTotal > 0;
    if (!addCluster(seed)) {
      int delta = rawPull ~/ pullWeight;
      if (delta < 0) {
        delta = Math.max(delta, -freedom);
      } else {
        delta = Math.min(delta, freedom);
      }

      if (isRight) {
        delta = Math.min(0, delta);
      } else {
        delta = Math.max(0, delta);
      }

      if (delta != 0) {
        for (int i = 0; i < members.length; i++) {
          NodeCluster c = members[i];
          c.adjustRank(delta, placement.dirtyClusters);
        }
        placement.refreshDirtyClusters();
        reset();
        return true;
      }
    }
    reset();
    return false;
  }
  void reset() {
    rawPull = pullWeight = 0;
    for (int i = 0; i < members.length; i++) members[i].isSetMember = false;
    members.clear();
    freedom = Integer.MAX_VALUE;
  }
}
/**
 * Assigns the X and width values for nodes in a directed graph.
 * @author Randy Hudson
 * @since 2.1.2
 */
class HorizontalPlacement extends SpanningTreeVisitor {
  static int step = 0;
  List allClusters;
  Map clusterMap = new Map();
  ClusterSet clusterset;
  Set dirtyClusters = new Set();
  DirectedGraph graph;
  Map map2 = new Map();
  DirectedGraph prime;
  Node graphRight;
  Node graphLeft;

  HorizontalPlacement() { clusterset = new ClusterSet(this); }

  /**
   * Inset the corresponding parts for the given 2 nodes along an edge E. The
   * weight value is a value by which to scale the edges specified weighting
   * factor.
   * @param uthe source
   * @param vthe target
   * @param ethe edge along which u and v exist
   * @param weighta scaling for the weight
   */
  void addEdge(Node u, Node v, Edge e, int weight) {
    Node ne = new Node(data: new NodePair(u, v));
    prime.nodes.add(ne);
    ne.y = (u.y + u.height + v.y) ~/ 2;
    Node uPrime = get(u);
    Node vPrime = get(v);
    int uOffset = e.sourceOffset;
    int vOffset = e.targetOffset;
    Edge eu = new Edge(ne, uPrime, delta: 0, weight: e.weight * weight);
    Edge ev = new Edge(ne, vPrime, delta: 0, weight: e.weight * weight);
    int dw = uOffset - vOffset;
    if (dw < 0) eu.delta = -dw; else ev.delta = dw;
    prime.edges.add(eu);
    prime.edges.add(ev);
  }
  /**
   * Adds all of the incoming edges to the graph.
   * @param nthe original node
   * @param nPrimeits corresponding node in the auxilary graph
   */
  void addEdges(Node n) {
    for (int i = 0; i < n.incoming.length; i++) {
      Edge e = n.incoming[i];
      addEdge(e.source, n, e, 1);
    }
  }
  void applyGPrime() {
    Node node;
    for (int n = 0; n < prime.nodes.length; n++) {
      node = prime.nodes[n];
      if (node.data is Node) (node.data as Node).x = node.rank;
    }
  }
  void balanceClusters() {
    findAllClusters();
    step = 0;
    bool somethingMoved = false;
    for (int i = 0; i < allClusters.length;) {
      NodeCluster c = allClusters[i];
      int delta = c.getPull();
      if (delta < 0) {
        if (c.leftFreedom > 0) {
          c.adjustRank(Math.max(delta, -c.leftFreedom), dirtyClusters);
          refreshDirtyClusters();
          moveClusterForward(i, c);
          somethingMoved = true;
          step++;
        } else if (clusterset.build(c)) {
          step++;
          moveClusterForward(i, c);
          somethingMoved = true;
        }
      } else if (delta > 0) {
        if (c.rightFreedom > 0) {
          c.adjustRank(Math.min(delta, c.rightFreedom), dirtyClusters);
          refreshDirtyClusters();
          moveClusterForward(i, c);
          somethingMoved = true;
          step++;
        } else if (clusterset.build(c)) {
          step++;
          moveClusterForward(i, c);
          somethingMoved = true;
        }
      }
      i++;
      if (i == allClusters.length && somethingMoved) {
        i = 0;
        somethingMoved = false;
      }
    }
  }
  void buildGPrime() {
    RankList ranks = graph.ranks;
    buildRankSeparators(ranks);
    Rank rank;
    Node n;
    for (int r = 1; r < ranks.length; r++) {
      rank = ranks[r];
      for (int i = 0; i < rank.count(); i++) {
        n = rank[i];
        addEdges(n);
      }
    }
  }
  void buildRankSeparators(RankList ranks) {
    Rank rank;
    Node n, nPrime, prevNPrime;
    Edge e;
    for (int r = 0; r < ranks.length; r++) {
      rank = ranks[r];
      prevNPrime = null;
      for (int i = 0; i < rank.count(); i++) {
        n = rank[i];
        nPrime = new Node(data: n);
        if (i == 0) {
          e = new Edge(graphLeft, nPrime, delta: 0, weight: 0);
          prime.edges.add(e);
          e.delta = graph.getPadding(n).left + graph.getMargin().left;
        } else {
          e = new Edge(prevNPrime, nPrime);
          e.weight = 0;
          prime.edges.add(e);
          rowSeparation(e);
        }
        prevNPrime = nPrime;
        prime.nodes.add(nPrime);
        map(n, nPrime);
        if (i == rank.count() - 1) {
          e = new Edge(nPrime, graphRight, delta: 0, weight: 0);
          e.delta = n.width + graph.getPadding(n).right
              + graph.getMargin().right;
          prime.edges.add(e);
        }
      }
    }
  }
  void calculateCellLocations() {
    graph.cellLocations =
        new List<List<int>>(graph.ranks.length + 1);
    for (int row = 0; row < graph.ranks.length; row++) {
      Rank rank = graph.ranks[row];
      List<int> locations = graph.cellLocations[row] =
          new List<int>.filled(rank.length + 1, 0);
      int cell;
      Node node = null;
      for (cell = 0; cell < rank.length; cell++) {
        node = rank[cell];
        locations[cell] = node.x - graph.getPadding(node).left;
      }
      locations[cell] = node.x + node.width
          + graph.getPadding(node).right;
    }
  }
  void findAllClusters() {
    Node root = prime.nodes[0];
    NodeCluster cluster = new NodeCluster();
    allClusters = new List();
    allClusters.add(cluster);
    growCluster(root, cluster);
    for (int i = 0; i < prime.edges.length; i++) {
      Edge e = prime.edges[i];
      NodeCluster sourceCluster = clusterMap[e.source];
      NodeCluster targetCluster = clusterMap[e.target];
      if (targetCluster == sourceCluster) continue;
      CollapsedEdges link = sourceCluster.getRightNeighbor(targetCluster);
      if (link == null) {
        link = new CollapsedEdges(e);
        sourceCluster.addRightNeighbor(targetCluster, link);
        targetCluster.addLeftNeighbor(sourceCluster, link);
      } else {
        prime.removeEdge(link.processEdge(e));
        i--;
      }
    }
    for (int i = 0; i < allClusters.length; i++) allClusters[i].initValues();
  }
  Node get(Node key) {
    return map2[key];
  }
  void growCluster(Node root, NodeCluster cluster) {
    cluster.add(root);
    clusterMap[root] = cluster;
    EdgeList treeChildren = getSpanningTreeChildren(root);
    for (int i = 0; i < treeChildren.length; i++) {
      Edge e = treeChildren[i];
      if (e.cut != 0) growCluster(getTreeTail(e), cluster); else {
        NodeCluster newCluster = new NodeCluster();
        allClusters.add(newCluster);
        growCluster(getTreeTail(e), newCluster);
      }
    }
  }
  void map(Node key, Node value) {
    map2[key] = value;
  }
  void moveClusterForward(int i, NodeCluster c) {
    if (i == 0) return;
    int swapIndex = i ~/ 2;
    Object temp = allClusters[swapIndex];
    allClusters[swapIndex] = c;
    allClusters[i] = temp;
  }
  void refreshDirtyClusters() {
    for (var cluster in dirtyClusters) {
      cluster.refreshValues();
    }
    dirtyClusters.clear();
  }
  void rowSeparation(Edge e) {
    Node source = e.source.data;
    Node target = e.target.data;
    e.delta = source.width + graph.getPadding(source).right + graph.getPadding(target).left;
  }
  void visit(DirectedGraph g) {
    graph = g;
    prime = new DirectedGraph();
    prime.nodes.add(graphLeft = new Node());
    prime.nodes.add(graphRight = new Node());
    buildGPrime();
    new InitialRankSolver().visit(prime);
    new TightSpanningTreeSolver().visit(prime);
    RankAssignmentSolver solver = new RankAssignmentSolver();
    solver.visit(prime);
    balanceClusters();
    prime.nodes.adjustRankSimple(-graphLeft.rank);
    applyGPrime();
    calculateCellLocations();
    graph.size.width = graphRight.rank;
  }
}
