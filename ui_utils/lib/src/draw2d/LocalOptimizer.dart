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
 * This graph visitor examines all adjacent pairs of nodes and determines if
 * swapping the two nodes provides improved graph aesthetics.
 * @author Daniel Lee
 * @since 2.1.2
 */
class LocalOptimizer extends GraphVisitor {
  bool shouldSwap(Node current, Node next) {
    int crossCount = 0;
    int invertedCrossCount = 0;
    EdgeList currentEdges = current.incoming;
    EdgeList nextEdges = next.incoming;
    int rank = current.rank - 1;
    int iCurrent, iNext;
    for (int i = 0; i < currentEdges.length; i++) {
      Edge currentEdge = currentEdges[i];
      iCurrent = currentEdge.getIndexForRank(rank);
      for (int j = 0; j < nextEdges.length; j++) {
        iNext = nextEdges[j].getIndexForRank(rank);
        if (iNext < iCurrent) crossCount++; else if (iNext > iCurrent) invertedCrossCount++; else {
          int offsetDiff = nextEdges[j].sourceOffset - currentEdge.sourceOffset;
          if (offsetDiff < 0) crossCount++; else if (offsetDiff > 0) invertedCrossCount++;
        }
      }
    }
    currentEdges = current.outgoing;
    nextEdges = next.outgoing;
    rank = current.rank + 1;
    for (int i = 0; i < currentEdges.length; i++) {
      Edge currentEdge = currentEdges[i];
      iCurrent = currentEdge.getIndexForRank(rank);
      for (int j = 0; j < nextEdges.length; j++) {
        iNext = nextEdges[j].getIndexForRank(rank);
        if (iNext < iCurrent) crossCount++; else if (iNext > iCurrent) invertedCrossCount++; else {
          int offsetDiff = nextEdges[j].targetOffset - currentEdge.targetOffset;
          if (offsetDiff < 0) crossCount++; else if (offsetDiff > 0) invertedCrossCount++;
        }
      }
    }
    if (invertedCrossCount < crossCount) return true;
    return false;
  }
  void swapNodes(Node current, Node next, Rank rank) {
    int index = rank.indexOf(current);
    rank[index + 1] = current;
    rank[index] = next;
    index = current.index;
    current.index = next.index;
    next.index = index;
  }
  /**
   * @see GraphVisitor#visit(org.eclipse.draw2d.graph.DirectedGraph)
   */
  void visit(DirectedGraph g) {
    bool flag;
    do {
      flag = false;
      for (int r = 0; r < g.ranks.length; r++) {
        Rank rank = g.ranks[r];
        for (int n = 0; n < rank.count() - 1; n++) {
          Node currentNode = rank[n];
          Node nextNode = rank[n + 1];
          if (shouldSwap(currentNode, nextNode)) {
            swapNodes(currentNode, nextNode, rank);
            flag = true;
            n = Math.max(0, n - 2);
          }
        }
      }
    } while (flag);
  }
}
