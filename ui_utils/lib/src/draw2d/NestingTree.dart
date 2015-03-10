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

class NestingTree {

  List contents = [];
  bool isLeaf = true;
  int size = 0;
  double sortValue = 0.0;
  Node subgraph;

  static void addNodeToNestingTree(Map map, Node child) {
    Subgraph subgraph = child.parent;
    NestingTree parent = map[subgraph];
    if (parent == null) {
      parent = new NestingTree();
      parent.subgraph = subgraph;
      map[subgraph] = parent;
      if (subgraph != null)
        addBranchToNestingTree(map, parent);
    }
    parent.contents.add(child);
  }

  static void addBranchToNestingTree(Map map, NestingTree branch) {
    Subgraph subgraph = branch.subgraph.parent;
    NestingTree parent = map[subgraph];
    if (parent == null) {
      parent = new NestingTree();
      parent.subgraph = subgraph;
      map[subgraph] = parent;
      if (subgraph != null)
        addBranchToNestingTree(map, parent);
    }
    parent.contents.add(branch);
  }

  static NestingTree buildNestingTreeForRank(Rank rank) {
    Map nestingMap = new Map();

    for (int j = 0; j < rank.count(); j++) {
      Node node = rank[j];
      addNodeToNestingTree(nestingMap, node);
    }

    return nestingMap[null];
  }

  void calculateSortValues() {
    int total = 0;
    for (int i = 0; i < contents.length; i++) {
      Object o = contents[i];
      if (o is NestingTree) {
        isLeaf = false;
        o.calculateSortValues();
        total += (o.sortValue * o.size).toInt();
        size += o.size;
      } else {
        Node n = o;
        n.sortValue = n.index.toDouble();
        total += n.index;
        size++;
      }
    }
    sortValue = total / size;
  }

  void getSortValueFromSubgraph() {
    if (subgraph != null)
      sortValue = subgraph.sortValue;
    for (int i = 0; i < contents.length; i++) {
      Object o = contents[i];
      if (o is NestingTree)
        o.getSortValueFromSubgraph();
    }
  }

  void recursiveSort(bool sortLeaves) {
    if (isLeaf && !sortLeaves)
      return;
    bool change = false;
    // Use modified bubble sort for almost-sorted lists.
    do {
      change = false;
      for (int i = 0; i < contents.length - 1; i++)
        change = swap(i) || change;
      if (!change)
        break;
      change = false;
      for (int i = contents.length - 2; i >= 0; i--)
        change = swap(i) || change;
    } while (change);
    for (int i = 0; i < contents.length; i++) {
      Object o = contents[i];
      if (o is NestingTree)
        o.recursiveSort(sortLeaves);
    }
  }

  void repopulateRank(Rank r) {
    for (int i = 0; i < contents.length; i++) {
      Object o = contents[i];
      if (o is Node)
        r.add(o);
      else
        (o as NestingTree).repopulateRank(r);
    }
  }

  bool swap(int index) {
    Object left = contents[index];
    Object right = contents[index + 1];
    double iL = (left is Node) ? left.sortValue
        : (left as NestingTree).sortValue;
    double iR = (right is Node) ? right.sortValue
        : (right as NestingTree).sortValue;
    if (iL <= iR)
      return false;
    contents[index] = right;
    contents[index + 1] = left;
    return true;
  }

  String toString() {
    return "Nesting: ${subgraph}"; //$NON-NLS-1$
  }

}