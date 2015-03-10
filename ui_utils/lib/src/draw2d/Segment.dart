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
 * A Segment representation for the ShortestPathRouting. A segment is a line
 * between two vertices.
 * This class is for internal use only
 * @author Whitney Sorenson
 * @since 3.0
 */
class Segment {
  Vertex start, end;
  Segment(Vertex start, Vertex end) {
    this.start = start;
    this.end = end;
  }
  /**
   * Returns the cosine of the made between this segment and the given segment
   * @param otherSegmentthe other segment
   * @return cosine value (not arc-cos)
   */
  double cosine(Segment otherSegment) {
    double cos = (((start.x - end.x) * (otherSegment.end.x - otherSegment.start.x)) + ((start.y - end.y) * (otherSegment.end.y - otherSegment.start.y))) / (getLength() * otherSegment.getLength());
    double sin = (((start.x - end.x) * (otherSegment.end.y - otherSegment.start.y)) - ((start.y - end.y) * (otherSegment.end.x - otherSegment.start.x))).toDouble();
    if (sin < 0.0) return (1 + cos);
    return -(1 + cos);
  }
  /**
   * Returns the cross product of this segment and the given segment
   * @param otherSegmentthe other segment
   * @return the cross product
   */
  int crossProduct(Segment otherSegment) {
    return (((start.x - end.x) * (otherSegment.end.y - end.y)) - ((start.y - end.y) * (otherSegment.end.x - end.x)));
  }
  double getLength() {
    return (end.getDistance(start));
  }
  /**
   * Returns a number that represents the sign of the slope of this segment.
   * It does not return the actual slope.
   * @return number representing sign of the slope
   */
  double getSlope() {
    if (end.x - start.x >= 0) return (end.y - start.y).toDouble(); else return -(end.y - start.y).toDouble();
  }
  /**
   * Returns true if the given segment intersects this segment.
   * @param sxstart x
   * @param systart y
   * @param txend x
   * @param tyend y
   * @return true if the segments intersect
   */
  bool intersects(int sx, int sy, int tx, int ty) {
    return Geometry.linesIntersect(start.x, start.y, end.x, end.y, sx, sy, tx, ty);
  }
  /**
   * Return true if the segment represented by the points intersects this
   * segment.
   * @param sstart point
   * @param tend point
   * @return true if the segments intersect
   */
  bool intersects2(Point s, Point t) {
    return intersects(s.x, s.y, t.x, t.y);
  }
  /**
   * @see java.lang.Object#toString()
   */
  String toString() {
    return "$start---";  // TODO(vegorov)
  }
}
