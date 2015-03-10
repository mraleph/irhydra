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
 * Stores an integer width and height. This class provides various methods for
 * manipulating this Dimension or creating new derived Objects.
 */
class Dimension {
  int width = 0;
  int height = 0;

  Dimension(int this.width, int this.height);

  /**
   * Returns whether the input Object is equivalent to this Dimension.
   * <code>true</code> if the Object is a Dimension and its width and height
   * are equal to this Dimension's width and height, <code>false</code>
   * otherwise.
   * @param othe Object being tested for equality
   * @return <code>true</code> if the given object is equal to this dimension
   * @since 2.0
   */

  bool operator == (Object o) {
    if (o is Dimension) {
      return (o.width == width && o.height == height);
    }

    return false;
  }

  /**
   * @see java.lang.Object#hashCode()
   */
  int get hashCode {
    return (width * height) ^ (width + height);
  }

  /**
   * @see Object#toString()
   */
  String toString() {
    return "Dimension(${width}, ${height})";
  }

  /**
   * Swaps the width and height of this Dimension, and returns this for
   * convenience. Can be useful in orientation changes.
   * @return <code>this</code> for convenience
   * @since 2.0
   */
  Dimension transpose() {
    int temp = width;
    width = height;
    height = temp;
    return this;
  }
 }
