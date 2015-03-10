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
 * A list of <code>Edge</code>s.
 * @author hudsonr
 * @since 2.1.2
 */
class EdgeList extends ListBase<Edge> {
  int getSourceIndex(int i) {
    return this[i].source.index;
  }

  int getTargetIndex(int i) {
    return this[i].target.index;
  }

  int getSlack() {
    int slack = Integer.MAX_VALUE;
    for (final edge in this) slack = Math.min(slack, edge.slack);
    return slack;
  }

  int getWeight() {
    int w = 0;
    for (final edge in this) w += edge.weight;
    return w;
  }

  bool isCompletelyFlagged() {
    for (final edge in this) {
      if (!edge.flag) return false;
    }
    return true;
  }

  void resetFlags(bool resetTree) {
    for (final edge in this) {
      edge.flag = false;
      if (resetTree) edge.tree = false;
    }
  }

  void setFlags(bool value) {
    for (final edge in this) edge.flag = value;
  }

  // TODO(vegorov) remove when dartbug.com/8075 is fixed
  remove(e) => Collections.remove(list, e);
}
