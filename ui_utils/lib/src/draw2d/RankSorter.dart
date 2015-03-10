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
 * Sorts Ranks during the up and down sweeps of the MinCross visitor.
 * @author Randy Hudson
 * @since 2.1.2
 */
class RankSorter {
  final flipflop = new math.Random(3);
  Node node;
  double rankSize = 0.0, prevRankSize = 0.0, nextRankSize = 0.0;
  int currentRow = 0;
  Rank rank;
  double progress = 0.0;
  DirectedGraph g;
  void assignIncomingSortValues() {
    rankSize = rank.total.toDouble();
    prevRankSize = g.ranks[currentRow - 1].total.toDouble();
    if (currentRow < g.ranks.length - 1) nextRankSize = g.ranks[currentRow + 1].total.toDouble();
    for (int n = 0; n < rank.count(); n++) {
      node = rank[n];
      sortValueIncoming();
    }
  }
  void assignOutgoingSortValues() {
    rankSize = rank.total.toDouble();
    prevRankSize = g.ranks[currentRow + 1].total.toDouble();
    if (currentRow > 1) nextRankSize = g.ranks[currentRow - 1].total.toDouble();
    for (int n = 0; n < rank.count(); n++) {
      node = rank[n];
      sortValueOutgoing();
    }
  }
  double evaluateNodeIncoming() {
    bool change = false;
    EdgeList incoming = node.incoming;
    do {
      change = false;
      for (int i = 0; i < incoming.length - 1; i++) {
        if (incoming.getSourceIndex(i) > incoming.getSourceIndex(i + 1)) {
          Edge e = incoming[i];
          incoming[i] = incoming[i + 1];
          incoming[i + 1] = e;
          change = true;
        }
      }
    } while (change);
    int n = incoming.length;
    if (n == 0) {
      return node.index * prevRankSize / rankSize;
    }
    if (n % 2 == 1) return incoming.getSourceIndex(n ~/ 2).toDouble();
    int l = incoming.getSourceIndex(n ~/ 2 - 1);
    int r = incoming.getSourceIndex(n ~/ 2);
    if (progress >= 0.8 && n > 2) {
      int dl = l - incoming.getSourceIndex(0);
      int dr = incoming.getSourceIndex(n - 1) - r;
      if (dl < dr) return l.toDouble();
      if (dl > dr) return r.toDouble();
    }
    if (progress > 0.25 && progress < 0.75) {
      if (flipflop.nextBool()) {
        return (l + l + r) / 3.0;
      } else {
        return (r + r + l) / 3.0;
      }
    }
    return (l + r) / 2.0;
  }
  double evaluateNodeOutgoing() {
    bool change = false;
    EdgeList outgoing = node.outgoing;
    do {
      change = false;
      for (int i = 0; i < outgoing.length - 1; i++) {
        if (outgoing.getTargetIndex(i) > outgoing.getTargetIndex(i + 1)) {
          Edge e = outgoing[i];
          outgoing[i] = outgoing[i + 1];
          outgoing[i + 1] = e;
          change = true;
        }
      }
    } while (change);
    int n = outgoing.length;
    if (n == 0) return node.index * prevRankSize / rankSize;
    if (n % 2 == 1) return outgoing.getTargetIndex(n ~/ 2).toDouble();
    int l = outgoing.getTargetIndex(n ~/ 2 - 1);
    int r = outgoing.getTargetIndex(n ~/ 2);
    if (progress >= 0.8 && n > 2) {
      int dl = l - outgoing.getTargetIndex(0);
      int dr = outgoing.getTargetIndex(n - 1) - r;
      if (dl < dr) return l.toDouble();
      if (dl > dr) return r.toDouble();
    }
    if (progress > 0.25 && progress < 0.75) {
      return (flipflop.nextBool() ? (l + l + r) : (r + r + l)) / 3.0;
    }
    return (l + r) / 2.0;
  }
  void sortRankIncoming(DirectedGraph g, Rank rank, int row, double progress) {
    this.currentRow = row;
    this.rank = rank;
    this.progress = progress;
    assignIncomingSortValues();
    sort();
    postSort();
  }
  void init(DirectedGraph g) {
    this.g = g;
    for (int i = 0; i < g.ranks.length; i++) {
      rank = g.ranks[i];
      postSort();
    }
  }
  void optimize(DirectedGraph g) {
  }
  void postSort() {
    rank.assignIndices();
  }
  void sort() {
    bool change;
    do {
      change = false;
      for (int i = 0; i < rank.length - 1; i++) change = swap(i) || change;
      if (!change) break;
      change = false;
      for (int i = rank.length - 2; i >= 0; i--) change = swap(i) || change;
    } while (change);
  }
  bool swap(int i) {
    Node left = rank[i];
    Node right = rank[i + 1];
    if (left.sortValue <= right.sortValue) return false;
    rank[i] = right;
    rank[i + 1] = left;
    return true;
  }
  void sortRankOutgoing(DirectedGraph g, Rank rank, int row, double progress) {
    this.currentRow = row;
    this.rank = rank;
    this.progress = progress;
    assignOutgoingSortValues();
    sort();
    postSort();
  }
  void sortValueIncoming() {
    node.sortValue = evaluateNodeIncoming();
    double value = evaluateNodeOutgoing();
    if (value < 0) value = node.index * nextRankSize / rankSize;
    node.sortValue += value * progress;
  }
  void sortValueOutgoing() {
    node.sortValue = evaluateNodeOutgoing();
    double value = evaluateNodeIncoming();
    if (value < 0) value = node.index * nextRankSize / rankSize;
    node.sortValue += value * progress;
  }
}
