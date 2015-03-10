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
 * @author Randy Hudson
 */
class RouteEdges extends GraphVisitor {
  /**
   * @see GraphVisitor#visit(DirectedGraph)
   */
  void revisit(DirectedGraph g) {
    for (int i = 0; i < g.edges.length; i++) {
      Edge edge = g.edges[i];
      edge.start = new Point(edge.sourceOffset + edge.source.x, edge.source.y + edge.source.height);
      if (edge.source is SubgraphBoundary) {
        SubgraphBoundary boundary = edge.source;
        if (boundary.parent.head == boundary)
          edge.start.y = boundary.parent.y
              + boundary.parent.insets.top;
      }
      edge.end = new Point(edge.targetOffset + edge.target.x, edge.target.y);
      if (edge.vNodes != null) {
        routeLongEdge(edge, g);
      } else {
        PointList list = new PointList();
        list.addPoint(edge.start);
        list.addPoint(edge.end);
        edge.setPoints(list);
      }
    }
  }

  static void routeLongEdge(Edge edge, DirectedGraph g) {
    ShortestPathRouter router = new ShortestPathRouter();
    Path path = new Path(start: edge.start, end: edge.end);
    router.addPath(path);
    Rectangle o;
    Insets padding;
    final P1 = new Point(-100000, 2);
    final P2 = new Point(100000, 2);
    for (int i = 0; i < edge.vNodes.length; i++) {
      Node node = edge.vNodes[i];
      Node neighbor;
      if (node.left != null) {
        neighbor = node.left;
        o = new Rectangle(neighbor.x, neighbor.y, neighbor.width, neighbor.height);
        padding = g.getPadding(neighbor);
        o.width += padding.right + edge.padding - 1;
        o.x -= padding.left;
        o.unionPoint(o.getLocation().translate(P1));
        router.addObstacle(o);
      }
      if (node.right != null) {
        neighbor = node.right;
        o = new Rectangle(neighbor.x, neighbor.y, neighbor.width, neighbor.height);
        padding = g.getPadding(neighbor);
        o.width += padding.right;
        o.x -= padding.left + edge.padding - 1;
        o.unionPoint(o.getLocation().translate(P2));
        router.addObstacle(o);
      }
    }
    router.setSpacing(0);
    router.solve();
    edge.setPoints(path.getPoints());
  }
}
