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
 * Performs transposing of subgraphics in a compound directed graph.
 *
 * @since 3.7.1
 */
class CompoundTransposeMetrics extends TransposeMetrics {

  void visit(DirectedGraph g) {
    if (g.getDirection() == PositionConstants.SOUTH)
      return;
    super.visit(g);
    int temp;
    CompoundDirectedGraph cg = g;
    for (int i = 0; i < cg.subgraphs.length; i++) {
      Node node = cg.subgraphs[i];
      temp = node.width;
      node.width = node.height;
      node.height = temp;
      if (node.padding != null)
        node.padding = node.padding.getTransposed();
    }
  }

  void revisit(DirectedGraph g) {
    if (g.getDirection() == PositionConstants.SOUTH)
      return;
    super.revisit(g);
    int temp;
    CompoundDirectedGraph cg = g;
    for (int i = 0; i < cg.subgraphs.length; i++) {
      Node node = cg.subgraphs[i];
      temp = node.width;
      node.width = node.height;
      node.height = temp;
      temp = node.y;
      node.y = node.x;
      node.x = temp;
      if (node.padding != null)
        node.padding = node.padding.getTransposed();
    }
  }

}