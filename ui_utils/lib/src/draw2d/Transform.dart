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
 * Provides support for transformations of scaling, translation and rotation.
 */
class Transform {
  double scaleX = 1.0, scaleY = 1.0, dx = 0.0, dy = 0.0, cos = 1.0, sin = 0.0;
  /**
   * Sets the value for the amount of scaling to be done along both axes.
   * @param scaleScale factor
   * @since 2.0
   */
  void setScale(double scale) {
    scaleX = scaleY = scale;
  }
  /**
   * Sets the value for the amount of scaling to be done along X and Y axes
   * individually.
   * @param xAmount of scaling on X axis
   * @param yAmount of scaling on Y axis
   * @since 2.0
   */
  void setScale2(double x, double y) {
    scaleX = x;
    scaleY = y;
  }
  /**
   * Sets the rotation angle.
   * @param angleAngle of rotation
   * @since 2.0
   */
  void setRotation(double angle) {
    cos = math.cos(angle);
    sin = math.sin(angle);
  }
  /**
   * Sets the translation amounts for both axes.
   * @param xAmount of shift on X axis
   * @param yAmount of shift on Y axis
   * @since 2.0
   */
  void setTranslation(double x, double y) {
    dx = x;
    dy = y;
  }
  /**
   * Returns a new transformed Point of the input Point based on the
   * transformation values set.
   * @param pPoint being transformed
   * @return The transformed Point
   * @since 2.0
   */
  Point getTransformed(Point p) {
    double x = p.x.toDouble();
    double y = p.y.toDouble();
    double temp;
    x *= scaleX;
    y *= scaleY;
    temp = x * cos - y * sin;
    y = x * sin + y * cos;
    x = temp;
    return new Point(Math.round(x + dx), Math.round(y + dy));
  }
}
