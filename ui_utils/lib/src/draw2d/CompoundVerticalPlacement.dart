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
 * calculates the height and y-coordinates for nodes and subgraphs in a compound
 * directed graph.
 *
 * @author Randy Hudson
 * @since 2.1.2
 */
class CompoundVerticalPlacement extends VerticalPlacement {

  /**
   * @see GraphVisitor#visit(DirectedGraph) Extended to set subgraph values.
   */
  void visit(CompoundDirectedGraph g) {
    super.visit(g);
    for (Subgraph s in g.subgraphs) {
      s.y = s.head.y;
      s.height = s.tail.height + s.tail.y - s.y;
    }
  }

}
