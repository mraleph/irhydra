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

class LeftRight {
  // $TODO Delete and use NodePair class, equivalent
  final left, right;

  LeftRight(this.left, this.right);

  bool operator == (LeftRight other) =>
    other.left == left && other.right == right;

  int get hashCode => left.hashCode ^ right.hashCode;
}

/**
 * Calculates the X-coordinates for nodes in a compound directed graph.
 *
 * @author Randy Hudson
 * @since 2.1.2
 */
class CompoundHorizontalPlacement extends HorizontalPlacement {
  final Set<LeftRight> entries = new Set<LeftRight>();

  /**
   * @see org.eclipse.graph.HorizontalPlacement#applyGPrime()
   */
  void applyGPrime() {
    super.applyGPrime();
    for (Subgraph s in (graph as CompoundDirectedGraph).subgraphs) {
      if (s.left != null) {
        s.x = s.left.x;
      }
      s.width = s.right.x + s.right.width - s.x;
    }
  }

  /**
   * @see HorizontalPlacement#buildRankSeparators(RankList)
   */
  void buildRankSeparators(RankList ranks) {
    CompoundDirectedGraph g = graph;

    Rank rank;
    for (int row = 0; row < g.ranks.length; row++) {
      rank = g.ranks[row];
      Node n = null, prev = null;
      for (int j = 0; j < rank.length; j++) {
        n = rank[j];
        if (prev == null) {
          Node left = addSeparatorsLeft(n, null);
          if (left != null) {
            Edge e = new Edge(graphLeft, getPrime(left), delta: 0, weight: 0);
            prime.edges.add(e);
            e.delta = graph.getPadding(n).left
                + graph.getMargin().left;
          }

        } else {
          Subgraph s = GraphUtilities.getCommonAncestor(prev, n);
          Node left = addSeparatorsRight(prev, s);
          Node right = addSeparatorsLeft(n, s);
          createEdge(left, right);
        }
        prev = n;
      }
      if (n != null)
        addSeparatorsRight(n, null);
    }
  }

  void createEdge(Node left, Node right) {
    LeftRight entry = new LeftRight(left, right);
    if (entries.contains(entry))
      return;
    entries.add(entry);
    int separation = left.width + graph.getPadding(left).right
        + graph.getPadding(right).left;
    prime.edges
        .add(new Edge(getPrime(left), getPrime(right), delta: separation, weight: 0));
  }

  Node addSeparatorsLeft(Node n, Subgraph graph) {
    Subgraph parent = n.parent;
    while (parent != graph && parent != null) {
      createEdge(getLeft(parent), n);
      n = parent.left;
      parent = parent.parent;
    }
    return n;
  }

  Node addSeparatorsRight(Node n, Subgraph graph) {
    Subgraph parent = n.parent;
    while (parent != graph && parent != null) {
      createEdge(n, getRight(parent));
      n = parent.right;
      parent = parent.parent;
    }
    return n;
  }

  Node getLeft(Subgraph s) {
    if (s.left == null) {
      s.left = new SubgraphBoundary(s, graph.getPadding(s), 1);
      s.left.rank = (s.head.rank + s.tail.rank) ~/ 2;

      Node head = getPrime(s.head);
      Node tail = getPrime(s.tail);
      Node left = getPrime(s.left);
      Node right = getPrime(getRight(s));
      prime.edges.add(new Edge(left, right, delta: s.width, weight: 0));
      prime.edges.add(new Edge(left, head, delta: 0, weight: 1));
      prime.edges.add(new Edge(head, right, delta: 0, weight: 1));
      prime.edges.add(new Edge(left, tail, delta: 0, weight: 1));
      prime.edges.add(new Edge(tail, right, delta: 0, weight: 1));
    }
    return s.left;
  }

  Node getRight(Subgraph s) {
    if (s.right == null) {
      s.right = new SubgraphBoundary(s, graph.getPadding(s), 3);
      s.right.rank = (s.head.rank + s.tail.rank) ~/ 2;
    }
    return s.right;
  }

  Node getPrime(Node n) {
    Node nPrime = get(n);
    if (nPrime == null) {
      nPrime = new Node(data: n);
      prime.nodes.add(nPrime);
      map(n, nPrime);
    }
    return nPrime;
  }

  void visit(DirectedGraph g) {
    super.visit(g);
  }

}
