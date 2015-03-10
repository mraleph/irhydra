/**
 * Copyright (c) 2005, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 * Alexander Shatalin (Borland) - Contribution for Bug 238874
 */


part of draw2d.graph;

/**
 * A Utilities class for geometry operations.
 * @author Pratik Shah
 * @author Alexander Nyssen
 * @since 3.1
 */
class Geometry {
  /**
   * Determines whether the two line segments p1->p2 and p3->p4, given by
   * p1=(x1, y1), p2=(x2,y2), p3=(x3,y3), p4=(x4,y4) intersect. Two line
   * segments are regarded to be intersecting in case they share at least one
   * common point, i.e if one of the two line segments starts or ends on the
   * other line segment or the line segments are collinear and overlapping,
   * then they are as well considered to be intersecting.
   * @param x1x coordinate of starting point of line segment 1
   * @param y1y coordinate of starting point of line segment 1
   * @param x2x coordinate of ending point of line segment 1
   * @param y2y coordinate of ending point of line segment 1
   * @param x3x coordinate of the starting point of line segment 2
   * @param y3y coordinate of the starting point of line segment 2
   * @param x4x coordinate of the ending point of line segment 2
   * @param y4y coordinate of the ending point of line segment 2
   * @return <code>true</code> if the two line segments formed by the given
   * coordinates share at least one common point.
   * @since 3.1
   */
  static bool linesIntersect(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4) {
    int bb1_x = Math.min(x1, x2);
    int bb1_y = Math.min(y1, y2);
    int bb2_x = Math.max(x1, x2);
    int bb2_y = Math.max(y1, y2);
    int bb3_x = Math.min(x3, x4);
    int bb3_y = Math.min(y3, y4);
    int bb4_x = Math.max(x3, x4);
    int bb4_y = Math.max(y3, y4);
    if (!(bb2_x >= bb3_x && bb4_x >= bb1_x && bb2_y >= bb3_y && bb4_y >= bb1_y)) {
      return false;
    }
    int p1p3_x = x1 - x3;
    int p1p3_y = y1 - y3;
    int p2p3_x = x2 - x3;
    int p2p3_y = y2 - y3;
    int p3p4_x = x3 - x4;
    int p3p4_y = y3 - y4;
    if (productSign(crossProduct(p2p3_x, p2p3_y, p3p4_x, p3p4_y), crossProduct(p3p4_x, p3p4_y, p1p3_x, p1p3_y)) >= 0) {
      int p2p1_x = x2 - x1;
      int p2p1_y = y2 - y1;
      int p1p4_x = x1 - x4;
      int p1p4_y = y1 - y4;
      return productSign(crossProduct(-p1p3_x, -p1p3_y, p2p1_x, p2p1_y), crossProduct(p2p1_x, p2p1_y, p1p4_x, p1p4_y)) <= 0;
    }
    return false;
  }
  static int productSign(int x, int y) {
    if (x == 0 || y == 0) {
      return 0;
    } else if ((x < 0) != (y < 0)) {
      return -1;
    }
    return 1;
  }
  static int crossProduct(int x1, int y1, int x2, int y2) {
    return x1 * y2 - x2 * y1;
  }
}
