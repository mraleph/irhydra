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
 * A list containing nodes.
 * @author hudsonr
 * @since 2.1.2
 */
class NodeList {
  final list = new List<Node>();
  noSuchMethod(invocation) =>
      mirrors.reflect(list).delegate(invocation);
  
  NodeList([NodeList other]) {
    if (other != null) {
      list.addAll(other.list);
    }
  }
  
  void adjustRankSimple(int delta) {
    if (delta == 0) return;
    for (var node in this) node.rank += delta;
  }
  
  void resetSortValues() {
    for (var node in this) node.sortValue = 0.0;
  }
  
  void resetIndices() {
    for (var node in this) node.index = 0;
  }
  
  void normalizeRanks() {
    int minRank = Integer.MAX_VALUE;
    for (var node in this) {
      minRank = Math.min(minRank, node.rank);
    }
    adjustRankSimple(-minRank);
  }
  
  void resetFlags() {
    for (var node in this) {
      node.flag = false;
    }
  }
  
  // TODO(vegorov) remove when dartbug.com/8075 is fixed 
  remove(e) => Collections.remove(list, e);
}
