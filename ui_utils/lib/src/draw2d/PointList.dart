/**
 * Copyright (c) 2000, 2010 IBM Corporation and others.
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
 * Represents a List of Points.
 */
class PointList {
  final List<Point> points = new List<Point>();

  get iterator => points.iterator;

  Rectangle bounds;

  PointList();

  void addAll(PointList source) {
    for (var p in source.points) points.add(p.clone());
  }

  void addPoint(Point p) {
    points.add(p.clone());
  }

  /**
   * Returns the smallest Rectangle which contains all Points.
   */
  Rectangle getBounds() {
    if (bounds != null) {
      return bounds;
    }

    bounds = new Rectangle(0, 0, 0, 0);
    if (!points.isEmpty) {
      bounds.setLocation2(first);
      for (var p in points) bounds.unionPoint(p);
    }
    return bounds;
  }

  Point get first => points.first;

  Point get last => points.last;

  Point get midpoint {
    final midpoint = (length ~/ 2);
    if (length % 2 == 0) {
      return points[midpoint - 1].clone().translate(points[midpoint]).scale(0.5);
    }
    return points[midpoint];
  }

  operator[] (int i) => points[i];

  void insertPoint(Point p, int index) {
    if (bounds != null && !bounds.containsPoint(p)) {
      bounds = null;
    }

    points.insert(index, p.clone());
  }

  void setPoint(Point p, int index) {  // TODO(vegorov) verify
    if (bounds != null && !bounds.containsPoint(p)) {
      bounds = null;
    }

    points[index] = p.clone();
  }

  /**
   * Removes all the points stored by this list. Resets all the properties
   * based on the point information.
   */
  void removeAllPoints() {
    bounds = null;
    points.clear();
  }

  /**
   * Removes the point at the specified index from the PointList, and returns
   * it.
   */
  Point removePoint(int index) {
    bounds = null;
    return points.removeAt(index);
  }

  void reverse() {
    Collections.reverse(points);
  }

  int get length => points.length;

  /**
   * Transposes all x and y values. Useful for orientation changes.
   * @since 3.2
   */
  void transpose() {
    if (bounds != null) {
      bounds.transpose();
    }

    for (var p in points) p.transpose();
  }
}
