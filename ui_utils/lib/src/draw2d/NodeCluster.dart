/**
 * Copyright (c) 2005, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */

part of draw2d.graph;

/**
 * A group of nodes which are interlocked and cannot be separately placed.
 * @since 3.1
 */
class NodeCluster extends NodeList {
  int hashCode2 = new Object().hashCode;
  bool isSetMember = false;
  bool isDirty = false;
  bool leftDirty = false;
  bool rightDirty = false;
  int leftFreedom = 0;
  int rightFreedom = 0;
  int leftNonzero = 0;
  int rightNonzero = 0;
  int get leftCount => leftLinks.length;
  int get rightCount => rightLinks.length;
  List<CollapsedEdges> leftLinks = new List<CollapsedEdges>();
  List<CollapsedEdges> rightLinks = new List<CollapsedEdges>();
  List<NodeCluster> leftNeighbors = new List<NodeCluster>();
  List<NodeCluster> rightNeighbors = new List<NodeCluster>();
  int effectivePull = 0;
  int weightedTotal = 0;
  int weightedDivisor = 0;
  int unweightedTotal = 0;
  int unweightedDivisor = 0;

  NodeCluster() : super();

  void addLeftNeighbor(NodeCluster neighbor, CollapsedEdges link) {
    leftNeighbors.add(neighbor);
    leftLinks.add(link);
  }
  void addRightNeighbor(NodeCluster neighbor, CollapsedEdges link) {
    rightNeighbors.add(neighbor);
    rightLinks.add(link);
  }

  void adjustRank(int delta, Set affected) {
    adjustRankSimple(delta);
    NodeCluster neighbor;
    CollapsedEdges edges;
    for (int i = 0; i < leftCount; i++) {
      neighbor = leftNeighbors[i];
      if (neighbor.isSetMember) continue;
      edges = leftLinks[i];
      neighbor.weightedTotal += delta * edges.collapsedWeight;
      neighbor.unweightedTotal += delta * edges.collapsedCount;
      weightedTotal -= delta * edges.collapsedWeight;
      unweightedTotal -= delta * edges.collapsedCount;
      neighbor.rightDirty = leftDirty = true;
      if (!neighbor.isDirty) {
        neighbor.isDirty = true;
        affected.add(neighbor);
      }
    }
    for (int i = 0; i < rightCount; i++) {
      neighbor = rightNeighbors[i];
      if (neighbor.isSetMember) continue;
      edges = rightLinks[i];
      neighbor.weightedTotal += delta * edges.collapsedWeight;
      neighbor.unweightedTotal += delta * edges.collapsedCount;
      weightedTotal -= delta * edges.collapsedWeight;
      unweightedTotal -= delta * edges.collapsedCount;
      neighbor.leftDirty = rightDirty = true;
      if (!neighbor.isDirty) {
        neighbor.isDirty = true;
        affected.add(neighbor);
      }
    }
    isDirty = true;
    affected.add(this);
  }

  CollapsedEdges getLeftNeighbor(NodeCluster neighbor) {
    for (int i = 0; i < leftCount; i++) {
      if (leftNeighbors[i] == neighbor) return leftLinks[i];
    }
    return null;
  }
  int getPull() {
    return effectivePull;
  }
  CollapsedEdges getRightNeighbor(NodeCluster neighbor) {
    for (int i = 0; i < rightCount; i++) {
      if (rightNeighbors[i] == neighbor) return rightLinks[i];
    }
    return null;
  }

  int get hashCode {
    return hashCode2;
  }
  /**
   * Initializes pull and freedom values.
   */
  void initValues() {
    weightedTotal = 0;
    weightedDivisor = 0;
    unweightedTotal = 0;
    int slack;
    leftNonzero = rightNonzero = leftFreedom = rightFreedom = Integer.MAX_VALUE;
    for (int i = 0; i < leftCount; i++) {
      CollapsedEdges edges = leftLinks[i];
      weightedTotal -= edges.weightedPull;
      unweightedTotal -= edges.tightestEdge.slack;
      unweightedDivisor += edges.collapsedCount;
      weightedDivisor += edges.collapsedWeight;
      slack = edges.tightestEdge.slack;
      leftFreedom = Math.min(slack, leftFreedom);
      if (slack > 0) leftNonzero = Math.min(slack, leftNonzero);
    }
    for (int i = 0; i < rightCount; i++) {
      CollapsedEdges edges = rightLinks[i];
      weightedTotal += edges.weightedPull;
      unweightedDivisor += edges.collapsedCount;
      unweightedTotal += edges.tightestEdge.slack;
      weightedDivisor += edges.collapsedWeight;
      slack = edges.tightestEdge.slack;
      rightFreedom = Math.min(slack, rightFreedom);
      if (slack > 0) rightNonzero = Math.min(slack, rightNonzero);
    }
    updateEffectivePull();
  }
  /**
   * Refreshes the left and right freedom.
   */
  void refreshValues() {
    int slack;
    isDirty = false;
    if (leftDirty) {
      leftDirty = false;
      leftNonzero = leftFreedom = Integer.MAX_VALUE;
      for (int i = 0; i < leftCount; i++) {
        CollapsedEdges edges = leftLinks[i];
        slack = edges.tightestEdge.slack;
        leftFreedom = Math.min(slack, leftFreedom);
        if (slack > 0) leftNonzero = Math.min(slack, leftNonzero);
      }
    }
    if (rightDirty) {
      rightDirty = false;
      rightNonzero = rightFreedom = Integer.MAX_VALUE;
      for (int i = 0; i < rightCount; i++) {
        CollapsedEdges edges = rightLinks[i];
        slack = edges.tightestEdge.slack;
        rightFreedom = Math.min(slack, rightFreedom);
        if (slack > 0) rightNonzero = Math.min(slack, rightNonzero);
      }
    }
    updateEffectivePull();
  }
  void updateEffectivePull() {
    if (weightedDivisor != 0) {
      effectivePull = weightedTotal ~/ weightedDivisor;
    } else if (unweightedDivisor != 0) {
      effectivePull = unweightedTotal ~/ unweightedDivisor;
    } else {
      effectivePull = 0;
    }
  }
}
