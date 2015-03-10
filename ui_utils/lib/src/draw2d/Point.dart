/**
 * Copyright (c) 2000, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */


part of draw2d.graph;

/**
 * Represents a point (x, y) in 2-dimensional space. This class provides various
 * methods for manipulating this Point or creating new derived geometrical
 * Objects.
 */
class Point {
  int x;
  int y;

  Point(this.x, this.y);

  Point clone() => new Point(x, y);

  /**
   * Test for equality.
   * @param oObject being tested for equality
   * @return true if both x and y values are equal
   * @since 2.0
   */
  bool operator == (Object o) {
    if (o is Point) {
      return o.x == x && o.y == y;
    }
    return false;
  }

  /**
   * @see java.lang.Object#hashCode()
   */
  int get hashCode {
    return (x * y) ^ (x + y);
  }

  /**
   * @return String representation.
   * @since 2.0
   */
  String toString() {
    return "Point(${x}, ${y})";
  }

  /**
   * Calculates the distance from this Point to the one specified.
   * @param pThe Point being compared to this
   * @return The distance
   * @since 2.0
   */
  double getDistance(Point p) {
    final dx = p.x - x;
    final dy = p.y - y;
    return math.sqrt((dx * dx + dy * dy).toDouble()); // TODO(vegorov) working around the crash.
  }


  /**
   * Creates a new Point which is translated by the values of the provided
   * Point.
   * @param pPoint which provides the translation amounts.
   * @return A new Point
   * @since 2.0
   */
  Point translate(Point p) {
    x += p.x;
    y += p.y;
    return this;
  }

  /**
   * Scales this Point by the specified amount.
   * @return <code>this</code> for convenience
   * @param factorscale factor
   * @since 2.0
   */
  Point scale(double factor) {
    x = Math.floor(x * factor);
    y = Math.floor(y * factor);
    return this;
  }

  /**
   * Transposes this object. X and Y values are exchanged.
   * @return <code>this</code> for convenience
   * @since 2.0
   */
  Point transpose() {
    var t = x;
    x = y;
    y = t;
    return this;
  }
}
