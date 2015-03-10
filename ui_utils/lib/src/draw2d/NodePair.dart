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
 * @author hudsonr
 * @since 2.1
 */
class NodePair {
  Node n1;
  Node n2;

  NodePair([this.n1, this.n2]) {
  }

  bool operator == (Object obj) {
    if (obj is NodePair) {
      return obj.n1 == n1 && obj.n2 == n2;
    }
    return false;
  }

  int get hashCode {
    return n1.hashCode ^ n2.hashCode;
  }

  /**
   * @see java.lang.Object#toString()
   */
  String toString() {
    return "[$n1, $n2]";
  }
}
