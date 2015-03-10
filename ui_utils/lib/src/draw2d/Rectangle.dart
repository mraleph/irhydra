/**
 * Copyright (c) 2000, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 * Mariot Chauvin <mariot.chauvin@obeo.fr> - bug 260740
 */


part of draw2d.graph;

/**
 * Represents a Rectangle(x, y, width, height). This class provides various
 * methods for manipulating this Rectangle or creating new derived geometrical
 * Objects.
 */
class Rectangle {
  int height = 0;
  int width = 0;
  int x = 0;
  int y = 0;

  Rectangle(int this.x, int this.y, int this.width, int this.height);

  Rectangle.fromRect(Rectangle rect) : this(rect.x, rect.y, rect.width, rect.height);

  Rectangle.fromPoint(Point p, Dimension size) : this(p.x, p.y, size.width, size.height);

  Rectangle.fromPoints(Point p1, Point p2) {
    this.x = Math.min(p1.x, p2.x);
    this.y = Math.min(p1.y, p2.y);
    this.width = Math.abs(p2.x - p1.x) + 1;
    this.height = Math.abs(p2.y - p1.y) + 1;
  }

  /**
   * Returns the y-coordinate of the bottom of this Rectangle.
   * @return The Y coordinate of the bottom
   * @since 2.0
   */
  int bottom() {
    return y + height;
  }

  /**
   * Returns whether the given coordinates are within the boundaries of this
   * Rectangle. The boundaries are inclusive of the top and left edges, but
   * exclusive of the bottom and right edges.
   * @param xX value
   * @param yY value
   * @return true if the coordinates are within this Rectangle
   * @since 2.0
   */
  bool contains(int x, int y) {
    return y >= this.y && y < this.y + this.height && x >= this.x && x < this.x + this.width;
  }

  /**
   * Returns whether the given point is within the boundaries of this
   * Rectangle. The boundaries are inclusive of the top and left edges, but
   * exclusive of the bottom and right edges.
   * @param pPoint being tested for containment
   * @return true if the Point is within this Rectangle
   * @since 2.0
   */
  bool containsPoint(Point p) {
    return contains(p.x, p.y);
  }

  /**
   * Returns whether the input object is equal to this Rectangle or not.
   * Rectangles are equivalent if their x, y, height, and width values are the
   * same.
   * @param oObject being tested for equality
   * @return Returns the result of the equality test
   * @since 2.0
   */
  bool operator ==(Object o) {
    if (o is Rectangle) {
      return (x == o.x) && (y == o.y) && (width == o.width) && (height == o.height);
    }
    return false;
  }

  /**
   * Returns a new point representing the center of this Rectangle.
   * @return Point at the center of the rectangle
   */
  Point getCenter() {
    return new Point(x + width ~/ 2, y + height ~/ 2);
  }

  /**
   * Returns a new Rectangle which has the exact same parameters as this
   * Rectangle.
   * @return Copy of this Rectangle
   * @since 2.0
   */
  Rectangle clone() {
    return new Rectangle.fromRect(this);
  }

  /**
   * Returns a new Rectangle which has the intersection of this Rectangle and
   * the rectangle provided as input. Returns an empty Rectangle if there is
   * no intersection.
   * @param rectRectangle provided to test for intersection
   * @return A new Rectangle representing the intersection
   * @since 2.0
   */
  Rectangle getIntersection(Rectangle rect) {
    return clone().intersect(rect);
  }

  /**
   * Returns the upper left hand corner of the rectangle.
   * @return Location of the rectangle
   * @see #setLocation(Point)
   */
  Point getLocation() {
    return new Point(x, y);
  }

  /**
   * <P>
   * Returns an integer which represents the position of the given point with
   * respect to this rectangle. Possible return values are bitwise ORs of the
   * constants WEST, EAST, NORTH, and SOUTH as found in{@link org.eclipse.draw2d.PositionConstants}.
   * <P>
   * Returns PositionConstant.NONE if the given point is inside this
   * Rectangle.
   * @param pThe Point whose position has to be determined
   * @return An <code>int</code> which is a PositionConstant
   * @see org.eclipse.draw2d.PositionConstants
   * @since 2.0
   */
  int getPosition(Point p) {
    int result = PositionConstants.NONE;
    if (containsPoint(p)) return result;
    if (p.x < x) result = PositionConstants.WEST; else if (p.x >= (x + width)) result = PositionConstants.EAST;
    if (p.y < y) result = result | PositionConstants.NORTH; else if (p.y >= (y + height)) result = result | PositionConstants.SOUTH;
    return result;
  }

  /**
   * @see java.lang.Object#hashCode()
   */
  int get hashCode {
    return (x + height) * (y + width) ^ x ^ y;
  }

  /**
   * Sets the size of this Rectangle to the intersection region with the
   * Rectangle supplied as input, and returns this for convenience. The
   * location and dimensions are set to zero if there is no intersection with
   * the input Rectangle.
   * @param rectRectangle for the calculating intersection.
   * @return <code>this</code> for convenience
   * @since 2.0
   */
  Rectangle intersect(Rectangle rect) {
    int x1 = Math.max(this.x, rect.x);
    int x2 = Math.min(this.x + width, rect.x + rect.width);
    int y1 = Math.max(this.y, rect.y);
    int y2 = Math.min(this.y + height, rect.y + rect.height);
    if (((x2 - x1) < 0) || ((y2 - y1) < 0)) {
      x = y = width = height = 0;
      return this;
    } else {
      x = x1;
      y = y1;
      width = x2 - x1;
      height = y2 - y1;
      return this;
    }
  }
  /**
   * Returns <code>true</code> if the input Rectangle intersects this
   * Rectangle.
   * @param rectRectangle for the intersection test
   * @return <code>true</code> if the input Rectangle intersects this
   * Rectangle
   * @since 2.0
   */
  bool intersects(Rectangle rect) {
    return !getIntersection(rect).isEmpty();
  }
  /**
   * Returns <code>true</code> if this Rectangle's width or height is less
   * than or equal to 0.
   * @return <code>true</code> if this Rectangle is empty
   * @since 2.0
   */
  bool isEmpty() {
    return width <= 0 || height <= 0;
  }

  /**
   * Returns the x-coordinate of the right side of this Rectangle.
   * @return The X coordinate of the right side
   * @since 2.0
   */
  int right() {
    return x + width;
  }

  /**
   * Sets the location of this Rectangle to the coordinates given as input and
   * returns this for convenience.
   * @param xThe new X coordinate
   * @param yThe new Y coordinate
   * @return <code>this</code> for convenience
   * @since 2.0
   */
  Rectangle setLocation(int x, int y) {
    this.x = x;
    this.y = y;
    return this;
  }
  /**
   * Sets the location of this Rectangle to the point given as input and
   * returns this for convenience.
   * @return <code>this</code> for convenience
   * @param pNew position of this Rectangle
   * @since 2.0
   */
  Rectangle setLocation2(Point p) {
    return setLocation(p.x, p.y);
  }

  /**
   * Returns the description of this Rectangle.
   * @return String containing the description
   * @since 2.0
   */
  String toString() {
    return "Rectangle(${x}, ${y}, ${x + width}, ${y + height})";
  }

  /**
   * Moves this Rectangle horizontally by dx and vertically by dy, then
   * returns this Rectangle for convenience.
   * @param dxShift along X axis
   * @param dyShift along Y axis
   * @return <code>this</code> for convenience
   * @since 2.0
   */
  Rectangle translate(int dx, int dy) {
    x += dx;
    y += dy;
    return this;
  }

  /**
   * Switches the x and y values, as well as the width and height of this
   * Rectangle. Useful for orientation changes.
   * @return <code>this</code> for convenience
   * @since 2.0
   */
  Rectangle transpose() {
    int temp = x;
    x = y;
    y = temp;
    temp = width;
    width = height;
    height = temp;
    return this;
  }

  /**
   * Updates this Rectangle's bounds to the minimum size which can hold both
   * this Rectangle and the coordinate (x,y).
   * @return <code>this</code> for convenience
   * @param x1X coordinate
   * @param y1Y coordinate
   * @since 2.0
   */
  Rectangle union(int x1, int y1) {
    if (x1 < x) {
      width += (x - x1);
      x = x1;
    } else {
      int right = x + width;
      if (x1 >= right) {
        right = x1 + 1;
        width = right - x;
      }
    }
    if (y1 < y) {
      height += (y - y1);
      y = y1;
    } else {
      int bottom = y + height;
      if (y1 >= bottom) {
        bottom = y1 + 1;
        height = bottom - y;
      }
    }
    return this;
  }

  /**
   * Updates this Rectangle's bounds to the minimum size which can hold both
   * this Rectangle and the given Point.
   * @param pPoint to be unioned with this Rectangle
   * @since 2.0
   */
  void unionPoint(Point p) {
    union(p.x, p.y);
  }
}
