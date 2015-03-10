/**
 * Copyright (c) 2004, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */

part of draw2d.graph;

/**
 * An obstacle representation for the ShortestPathRouting. This is a subclass of
 * Rectangle.
 * This class is for internal use only.
 * @author Whitney Sorenson
 * @since 3.0
 */
class Obstacle extends Rectangle {
  bool exclude = false;
  Vertex topLeft, topRight, bottomLeft, bottomRight, center;
  ShortestPathRouter router;

  Obstacle(Rectangle rect, ShortestPathRouter router) : super(0, 0, 0, 0) {
    init(rect);
    this.router = router;
  }
  /**
   * Returns <code>true</code> if the given point is contained but not on the
   * boundary of this obstacle.
   * @param pa point
   * @return <code>true</code> if properly contained
   */
  bool containsProper(Point p) {
    return p.x > this.x && p.x < this.x + this.width - 1 && p.y > this.y && p.y < this.y + this.height - 1;
  }
  int getSpacing() {
    return router.getSpacing();
  }
  void growVertex(Vertex vertex) {
    if (vertex.totalCount > 0) vertex.grow();
  }
  /**
   * Grows all vertices on this obstacle.
   */
  void growVertices() {
    growVertex(topLeft);
    growVertex(topRight);
    growVertex(bottomLeft);
    growVertex(bottomRight);
  }
  /**
   * Initializes this obstacle to the values of the given rectangle
   * @param rectbounds of this obstacle
   */
  void init(Rectangle rect) {
    this.x = rect.x;
    this.y = rect.y;
    this.width = rect.width;
    this.height = rect.height;
    exclude = false;
    topLeft = new Vertex(x, y, this);
    topLeft.positionOnObstacle = PositionConstants.NORTH_WEST;
    topRight = new Vertex(x + width - 1, y, this);
    topRight.positionOnObstacle = PositionConstants.NORTH_EAST;
    bottomLeft = new Vertex(x, y + height - 1, this);
    bottomLeft.positionOnObstacle = PositionConstants.SOUTH_WEST;
    bottomRight = new Vertex(x + width - 1, y + height - 1, this);
    bottomRight.positionOnObstacle = PositionConstants.SOUTH_EAST;
    center = new Vertex.fromPoint(getCenter(), this);
  }
  /**
   * Requests a full reset on all four vertices of this obstacle.
   */
  void reset() {
    topLeft.fullReset();
    bottomLeft.fullReset();
    bottomRight.fullReset();
    topRight.fullReset();
  }
  void shrinkVertex(Vertex vertex) {
    if (vertex.totalCount > 0) vertex.shrink();
  }
  /**
   * Shrinks all four vertices of this obstacle.
   */
  void shrinkVertices() {
    shrinkVertex(topLeft);
    shrinkVertex(topRight);
    shrinkVertex(bottomLeft);
    shrinkVertex(bottomRight);
  }
  /**
   * @see org.eclipse.draw2d.geometry.Rectangle#toString()
   */
  String toString() {
    return "Obstacle($x"; // TODO(vegorov)
  }
}
