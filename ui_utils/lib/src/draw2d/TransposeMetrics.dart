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

class TransposeMetrics extends GraphVisitor {
  void visit(DirectedGraph g) {
    if (g.getDirection() == PositionConstants.SOUTH) return;
    int temp;
    g.setDefaultPadding(g.getDefaultPadding().getTransposed());
    for (int i = 0; i < g.nodes.length; i++) {
      Node node = g.nodes[i];
      temp = node.width;
      node.width = node.height;
      node.height = temp;
      if (node.padding != null) {
        node.padding = node.padding.getTransposed();
      }
    }
  }
  void revisit(DirectedGraph g) {
    if (g.getDirection() == PositionConstants.SOUTH) return;
    int temp;
    g.setDefaultPadding(g.getDefaultPadding().getTransposed());
    for (int i = 0; i < g.nodes.length; i++) {
      Node node = g.nodes[i];
      temp = node.width;
      node.width = node.height;
      node.height = temp;
      temp = node.y;
      node.y = node.x;
      node.x = temp;
      if (node.padding != null) {
        node.padding = node.padding.getTransposed();
      }
    }
    for (int i = 0; i < g.edges.length; i++) {
      Edge edge = g.edges[i];
      edge.start.transpose();
      edge.end.transpose();
      edge.points.transpose();
      List bends = edge.vNodes.list;
      if (bends == null) continue;
      for (int b = 0; b < bends.length; b++) {
        Node vnode = bends[b];
        temp = vnode.y;
        vnode.y = vnode.x;
        vnode.x = temp;
        temp = vnode.width;
        vnode.width = vnode.height;
        vnode.height = temp;
      }
    }
    g.size.transpose();
  }
}
