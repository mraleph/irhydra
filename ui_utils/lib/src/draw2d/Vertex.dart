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
 * A vertex representation for the ShortestPathRouting. Vertices are either one
 * of four corners on an <code>Obstacle</code>(Rectangle), or one of the two end
 * points of a <code>Path</code>.
 * This class is not intended to be subclassed.
 * @author Whitney Sorenson
 * @since 3.0
 */
class Vertex extends Point {
  // constants for the vertex type
  static const NOT_SET = 0;
  static const INNIE = 1;
  static const OUTIE = 2;

  // for shortest path
  List neighbors;
  bool isPermanent = false;
  Vertex label;
  double cost = 0.0;

  // for routing
  int nearestObstacle = 0;
  double offset = 0.0;
  int type = NOT_SET;
  int count = 0;
  int totalCount = 0;
  Obstacle obs;
  List paths;
  bool nearestObstacleChecked = false;
  Map cachedCosines;
  int positionOnObstacle = -1;
  int origX = 0, origY = 0;

  Vertex(int x, int y, Obstacle obs) : super(x, y) {
    origX = x;
    origY = y;
    this.obs = obs;
  }

  Vertex.fromPoint(Point p, Obstacle obs) : this(p.x, p.y, obs);

  /**
   * Adds a path to this vertex, calculates angle between two segments and
   * caches it.
   * @param paththe path
   * @param startthe segment to this vertex
   * @param endthe segment away from this vertex
   */
  void addPath(Path path, Segment start, Segment end) {
    if (paths == null) {
      paths = new List();
      cachedCosines = new Map();
    }
    if (!paths.contains(path)) paths.add(path);
    cachedCosines[path] = start.cosine(end);
  }
  /**
   * Creates a point that represents this vertex offset by the given amount
   * times the offset.
   * @param modifierthe offset
   * @return a Point that has been bent around this vertex
   */
  Point bend(int modifier) {
    Point point = new Point(x, y);
    if ((positionOnObstacle & PositionConstants.NORTH) > 0) {
      point.y -= (modifier * offset).toInt();
    } else {
      point.y += (modifier * offset).toInt();
    }

    if ((positionOnObstacle & PositionConstants.EAST) > 0) {
      point.x += (modifier * offset).toInt();
    } else {
      point.x -= (modifier * offset).toInt();
    }
    return point;
  }
  /**
   * Resets all fields on this Vertex.
   */
  void fullReset() {
    totalCount = 0;
    type = NOT_SET;
    count = 0;
    cost = 0.0;
    offset = getSpacing().toDouble();
    nearestObstacle = 0;
    label = null;
    nearestObstacleChecked = false;
    isPermanent = false;
    if (neighbors != null) neighbors.clear();
    if (cachedCosines != null) cachedCosines.clear();
    if (paths != null) paths.clear();
  }
  /**
   * Returns a Rectangle that represents the region around this vertex that
   * paths will be traveling in.
   * @param extraOffseta buffer to add to the region.
   * @return the rectangle
   */
  Rectangle getDeformedRectangle(int extraOffset) {
    Rectangle rect = new Rectangle(0, 0, 0, 0);
    if ((positionOnObstacle & PositionConstants.NORTH) > 0) {
      rect.y = y - extraOffset;
      rect.height = origY - y + extraOffset;
    } else {
      rect.y = origY;
      rect.height = y - origY + extraOffset;
    }
    if ((positionOnObstacle & PositionConstants.EAST) > 0) {
      rect.x = origX;
      rect.width = x - origX + extraOffset;
    } else {
      rect.x = x - extraOffset;
      rect.width = origX - x + extraOffset;
    }
    return rect;
  }
  int getSpacing() {
    if (obs == null) return 0;
    return obs.getSpacing();
  }
  /**
   * Grows this vertex by its offset to its maximum size.
   */
  void grow() {
    int modifier;
    if (nearestObstacle == 0) {
      modifier = totalCount * getSpacing();
    } else {
      modifier = (nearestObstacle ~/ 2) - 1;
    }
    if ((positionOnObstacle & PositionConstants.NORTH) > 0) {
      y -= modifier;
    } else {
      y += modifier;
    }
    if ((positionOnObstacle & PositionConstants.EAST) > 0) {
      x += modifier;
    } else {
      x -= modifier;
    }
  }
  /**
   * Shrinks this vertex to its original size.
   */
  void shrink() {
    x = origX;
    y = origY;
  }
  /**
   * Updates the offset of this vertex based on its shortest distance.
   */
  void updateOffset() {
    if (nearestObstacle != 0) offset = ((nearestObstacle / 2) - 1) / totalCount;
  }
  /**
   * @see org.eclipse.draw2d.geometry.Point#toString()
   */
  String toString() {
    return "V($origX"; // TODO
  }
}
