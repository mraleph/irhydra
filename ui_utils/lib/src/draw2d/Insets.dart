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
 * Stores four integers for top, left, bottom, and right measurements.
 */
class Insets {
  /**
   * distance from left
   */
  int left = 0;
  /**
   * distance from top
   */
  int top = 0;
  /**
   * distance from bottom
   */
  int bottom = 0;
  /**
   * distance from right
   */
  int right = 0;

  Insets.clone(Insets i) : this(i.top, i.left, i.bottom, i.right);

  Insets.round(int i) : this(i, i, i, i);

  Insets(int top, int left, int bottom, int right) {
    this.top = top;
    this.left = left;
    this.bottom = bottom;
    this.right = right;
  }
  /**
   * Adds the values of the specified Insets to this Insets' values.
   * @return <code>this</code> for convenience
   * @param insetsthe Insets being added
   * @since 2.0
   */
  Insets add(Insets insets) {
    top += insets.top;
    bottom += insets.bottom;
    left += insets.left;
    right += insets.right;
    return this;
  }
  /**
   * Test for equality. The Insets are equal if their top, left, bottom, and
   * right values are equivalent.
   * @param oObject being tested for equality.
   * @return true if all values are the same.
   * @since 2.0
   */
  bool operator == (Object o) {
    if (o is Insets) {
      return o.top == top && o.bottom == bottom && o.left == left && o.right == right;
    }
    return false;
  }
  /**
   * Creates an Insets representing the sum of this Insets with the specified
   * Insets.
   * @param insetsInsets to be added
   * @return A new Insets
   * @since 2.0
   */
  Insets getAdded(Insets insets) {
    return new Insets.clone(this).add(insets);
  }
  /**
   * Returns the height for this Insets, equal to <code>top</code> +
   * <code>bottom</code>.
   * @return The sum of top + bottom
   * @see #getWidth()
   * @since 2.0
   */
  int getHeight() {
    return top + bottom;
  }
  /**
   * Creates a new Insets with transposed values. Top and Left are transposed.
   * Bottom and Right are transposed.
   * @return New Insets with the transposed values.
   * @since 2.0
   */
  Insets getTransposed() {
    return new Insets.clone(this).transpose();
  }
  /**
   * Returns the width for this Insets, equal to <code>left</code> +
   * <code>right</code>.
   * @return The sum of left + right
   * @see #getHeight()
   * @since 2.0
   */
  int getWidth() {
    return left + right;
  }
  /**
   * @see java.lang.Object#hashCode()
   */
  int get hashCode {
    return top * 7 + left * 2 + bottom * 31 + right * 37;
  }
  /**
   * Returns true if all values are 0.
   * @return true if all values are 0
   * @since 2.0
   */
  bool isEmpty() {
    return (left == 0 && right == 0 && top == 0 && bottom == 0);
  }
  /**
   * @return String representation.
   * @since 2.0
   */
  String toString() {
    return "Insets(t=${top}, l=${left}, b=${bottom}, r=${right})";
  }
  /**
   * Transposes this object. Top and Left are exchanged. Bottom and Right are
   * exchanged. Can be used in orientation changes.
   * @return <code>this</code> for convenience
   * @since 2.0
   */
  Insets transpose() {
    int temp = top;
    top = left;
    left = temp;
    temp = right;
    right = bottom;
    bottom = temp;
    return this;
  }
}
