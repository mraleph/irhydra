/**
 * Copyright (c) 2005, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */

part of graph;

class NestingTree {
  List contents = new List();
  bool isLeaf = true;
  int size = 0;
  double sortValue = 0.0;
  Node subgraph;
  static void addToNestingTree(NullMap map, Node child) {
    Subgraph subgraph = child.getParent();
    NestingTree parent = map[subgraph];
    if (parent == null) {
      parent = new NestingTree();
      parent.subgraph = subgraph;
      map[subgraph] = parent;
      if (subgraph != null) addToNestingTree2(map, parent);
    }
    parent.contents.add(child);
  }
  static void addToNestingTree2(NullMap map, NestingTree branch) {
    Subgraph subgraph = branch.subgraph.getParent();
    NestingTree parent = map[subgraph];
    if (parent == null) {
      parent = new NestingTree();
      parent.subgraph = subgraph;
      map[subgraph] = parent;
      if (subgraph != null) addToNestingTree2(map, parent);
    }
    parent.contents.add(branch);
  }
  static NestingTree buildNestingTreeForRank(Rank rank) {
    NullMap nestingMap = new NullMap();
    for (int j = 0; j < rank.count(); j++) {
      Node node = rank[j];
      addToNestingTree(nestingMap, node);
    }
    return nestingMap[null];
  }
  void calculateSortValues() {
    int total = 0;
    for (int i = 0; i < contents.length; i++) {
      Object o = contents[i];
      if (o is NestingTree) {
        isLeaf = false;
        NestingTree e = o;
        e.calculateSortValues();
        total += (e.sortValue * e.size).toInt();
        size += e.size;
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
    if (subgraph != null) sortValue = subgraph.sortValue;
    for (int i = 0; i < contents.length; i++) {
      Object o = contents[i];
      if (o is NestingTree) (o).getSortValueFromSubgraph();
    }
  }
  void recursiveSort(bool sortLeaves) {
    if (isLeaf && !sortLeaves) return;
    bool change = false;
    do {
      change = false;
      for (int i = 0; i < contents.length - 1; i++) change = swap(i) || change;
      if (!change) break;
      change = false;
      for (int i = contents.length - 2; i >= 0; i--) change = swap(i) || change;
    } while (change);
    for (int i = 0; i < contents.length; i++) {
      Object o = contents[i];
      if (o is NestingTree) (o).recursiveSort(sortLeaves);
    }
  }
  void repopulateRank(Rank r) {
    for (int i = 0; i < contents.length; i++) {
      Object o = contents[i];
      if (o is Node) r.add(o); else (o as NestingTree).repopulateRank(r);
    }
  }
  bool swap(int index) {
    Object left = contents[index];
    Object right = contents[index + 1];
    double iL = (left is Node) ? (left as Node).sortValue : (left as NestingTree).sortValue;
    double iR = (right is Node) ? (right as Node).sortValue : (right as NestingTree).sortValue;
    if (iL <= iR) return false;
    contents[index] = right;
    contents[index + 1] = left;
    return true;
  }
  String toString() {
    return "Nesting: $subgraph";  // TODO(vegorov)
  }
}
