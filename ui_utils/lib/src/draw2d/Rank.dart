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
 * For Internal Use only.
 * @author hudsonr
 * @since 2.1.2
 */
class Rank extends NodeList {
  int bottomPadding = 0;
  int height = 0;
  int location = 0;
  final int hash = new Object().hashCode;
  int topPadding = 0;
  int total = 0;

  Rank() : super();

  void assignIndices() {
    total = 0;
    int mag;
    for (var node in this) {
      if (node is SubgraphBoundary) {
        mag = 4;
      } else {
        mag = Math.max(1, node.incoming.length + node.outgoing.length);
        mag = Math.min(mag, 5);
      }
      total += mag;
      node.index = total;
      total += mag;
    }
  }
  /**
   * Returns the number of nodes in this rank.
   * @return the number of nodes
   */
  int count() {
    return this.length;
  }

  /**
   * @see Object#hashCode() Overridden for speed based on equality.
   */
  int get hashCode {
    return hash;
  }

  void setDimensions(int location, int rowHeight) {
    this.height = rowHeight;
    this.location = location;
    for (var n in this) {
      n.y = location;
      n.height = rowHeight;
    }
  }
}
