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
 * A Stack of segments.
 */
class SegmentStack {
  final list = new List();

  Segment pop() => list.removeLast() as Segment;

  Obstacle popObstacle() => list.removeLast() as Obstacle;

  void push(Object obj) => list.add(obj);

  bool get isEmpty => list.isEmpty;
}

/**
 * A Path representation for the ShortestPathRouting. A Path has a start and end
 * point and may have bendpoints. The output of a path is accessed via the
 * method <code>getPoints()</code>.
 * This class is for internal use only.
 * @author Whitney Sorenson
 * @since 3.0
 */
class Path {
  static final Point CURRENT = new Point(0, 0);
  static final double EPSILON = 1.04;
  static final Point NEXT = new Point(0, 0);
  static final double OVAL_CONSTANT = 1.13;
  /**
   * The bendpoint constraints. The path must go through these bendpoints.
   */
  PointList bendpoints;
  /**
   * An arbitrary data field which can be used to map a Path back to some
   * client object.
   */
  Object data;
  List excludedObstacles = new List();
  List grownSegments = new List();
  /**
   * this field is for internal use only. It is true whenever a property has
   * been changed which requires the solver to resolve this path.
   */
  bool isDirty = true;
  bool isInverted = false;
  bool isMarked = false;
  PointList points = new PointList();
  /**
   * The previous cost ratio of the path. The cost ratio is the actual path
   * length divided by the length from the start to the end.
   */
  double prevCostRatio = 0.0;
  List segments  = new List();
  SegmentStack stack = new SegmentStack();
  Vertex start, end;
  Path subPath;
  double threshold = 0.0;
  Set visibleObstacles = new Set();
  Set visibleVertices = new Set();

  Path({start: null, end: null, this.data: null}) {
    this.start = (start is Point) ? new Vertex.fromPoint(start, null) : start;
    this.end = (end is Point) ? new Vertex.fromPoint(end, null) : end;
  }
  /**
   * Attempts to add all segments between the given obstacles to the
   * visibility graph.
   * @param sourcethe source obstacle
   * @param targetthe target obstacle
   */
  void addAllSegmentsBetween(Obstacle source, Obstacle target) {
    addConnectingSegment(new Segment(source.bottomLeft, target.bottomLeft), source, target, false, false);
    addConnectingSegment(new Segment(source.bottomRight, target.bottomRight), source, target, true, true);
    addConnectingSegment(new Segment(source.topLeft, target.topLeft), source, target, true, true);
    addConnectingSegment(new Segment(source.topRight, target.topRight), source, target, false, false);
    if (source.bottom() == target.bottom()) {
      addConnectingSegment(new Segment(source.bottomLeft, target.bottomRight), source, target, false, true);
      addConnectingSegment(new Segment(source.bottomRight, target.bottomLeft), source, target, true, false);
    }
    if (source.y == target.y) {
      addConnectingSegment(new Segment(source.topLeft, target.topRight), source, target, true, false);
      addConnectingSegment(new Segment(source.topRight, target.topLeft), source, target, false, true);
    }
    if (source.x == target.x) {
      addConnectingSegment(new Segment(source.bottomLeft, target.topLeft), source, target, false, true);
      addConnectingSegment(new Segment(source.topLeft, target.bottomLeft), source, target, true, false);
    }
    if (source.right() == target.right()) {
      addConnectingSegment(new Segment(source.bottomRight, target.topRight), source, target, true, false);
      addConnectingSegment(new Segment(source.topRight, target.bottomRight), source, target, false, true);
    }
  }
  /**
   * Attempts to add a segment between the given obstacles to the visibility
   * graph. This method is specifically written for the case where the two
   * obstacles intersect and contains a boolean as to whether to check the
   * diagonal that includes the top right point of the other obstacle.
   * @param segmentthe segment to check
   * @param o1the first obstacle
   * @param o2the second obstacle
   * @param checkTopRight1whether or not to check the diagonal containing top right
   * point
   */
  void addConnectingSegment(Segment segment, Obstacle o1, Obstacle o2, bool checkTopRight1, bool checkTopRight2) {
    if (threshold != 0 && (segment.end.getDistance(end) + segment.end.getDistance(start) > threshold || segment.start.getDistance(end) + segment.start.getDistance(start) > threshold)) return;
    if (o2.containsProper(segment.start) || o1.containsProper(segment.end)) return;
    if (checkTopRight1 && segment.intersects(o1.x, o1.bottom() - 1, o1.right() - 1, o1.y)) return;
    if (checkTopRight2 && segment.intersects(o2.x, o2.bottom() - 1, o2.right() - 1, o2.y)) return;
    if (!checkTopRight1 && segment.intersects(o1.x, o1.y, o1.right() - 1, o1.bottom() - 1)) return;
    if (!checkTopRight2 && segment.intersects(o2.x, o2.y, o2.right() - 1, o2.bottom() - 1)) return;
    stack.push(o1);
    stack.push(o2);
    stack.push(segment);
  }
  /**
   * Adds an obstacle to the visibility graph and generates new segments
   * @param newObsthe new obstacle, should not be in the graph already
   */
  void addObstacle(Obstacle newObs) {
    final otherObs = new Set.from(visibleObstacles);

    visibleObstacles.add(newObs);

    for (var currObs in otherObs) {
      addSegmentsFor(newObs, currObs);
    }

    addPerimiterSegments(newObs);
    addSegmentsFor2(start, newObs);
    addSegmentsFor2(end, newObs);
  }
  /**
   * Adds the segments along the perimiter of an obstacle to the visiblity
   * graph queue.
   * @param obsthe obstacle
   */
  void addPerimiterSegments(Obstacle obs) {
    Segment seg = new Segment(obs.topLeft, obs.topRight);
    stack.push(obs);
    stack.push(null);
    stack.push(seg);
    seg = new Segment(obs.topRight, obs.bottomRight);
    stack.push(obs);
    stack.push(null);
    stack.push(seg);
    seg = new Segment(obs.bottomRight, obs.bottomLeft);
    stack.push(obs);
    stack.push(null);
    stack.push(seg);
    seg = new Segment(obs.bottomLeft, obs.topLeft);
    stack.push(obs);
    stack.push(null);
    stack.push(seg);
  }
  /**
   * Attempts to add a segment to the visibility graph. First checks to see if
   * the segment is outside the threshold oval. Then it compares the segment
   * against all obstacles. If it is clean, the segment is finally added to
   * the graph.
   * @param segmentthe segment
   * @param exclude1an obstacle to exclude from the search
   * @param exclude2another obstacle to exclude from the search
   * @param allObstaclesthe list of all obstacles
   */
  void addSegment(Segment segment, Obstacle exclude1, Obstacle exclude2, List allObstacles) {
    if (threshold != 0 && (segment.end.getDistance(end) + segment.end.getDistance(start) > threshold || segment.start.getDistance(end) + segment.start.getDistance(start) > threshold)) return;
    for (int i = 0; i < allObstacles.length; i++) {
      Obstacle obs = allObstacles[i];
      if (obs == exclude1 || obs == exclude2 || obs.exclude) continue;
      if (segment.intersects(obs.x, obs.y, obs.right() - 1, obs.bottom() - 1) ||
          segment.intersects(obs.x, obs.bottom() - 1, obs.right() - 1, obs.y) ||
          obs.containsProper(segment.start) ||
          obs.containsProper(segment.end)) {
        if (!visibleObstacles.contains(obs)) addObstacle(obs);
        return;
      }
    }
    linkVertices(segment);
  }
  /**
   * Adds the segments between the given obstacles.
   * @param sourcesource obstacle
   * @param targettarget obstacle
   */
  void addSegmentsFor(Obstacle source, Obstacle target) {
    if (source.intersects(target)) addAllSegmentsBetween(source, target); else if (target.bottom() - 1 < source.y) addSegmentsTargetAboveSource(source, target); else if (source.bottom() - 1 < target.y) addSegmentsTargetAboveSource(target, source); else if (target.right() - 1 < source.x) addSegmentsTargetBesideSource(source, target); else addSegmentsTargetBesideSource(target, source);
  }
  /**
   * Adds the segments between the given obstacles.
   * @param sourcesource obstacle
   * @param targettarget obstacle
   */
  void addSegmentsFor2(Vertex vertex, Obstacle obs) {
    Segment seg = null;
    Segment seg2 = null;
    switch (obs.getPosition(vertex)) {
      case PositionConstants.SOUTH_WEST:
      case PositionConstants.NORTH_EAST:
        seg = new Segment(vertex, obs.topLeft);
        seg2 = new Segment(vertex, obs.bottomRight);
        break;
      case PositionConstants.SOUTH_EAST:
      case PositionConstants.NORTH_WEST:
        seg = new Segment(vertex, obs.topRight);
        seg2 = new Segment(vertex, obs.bottomLeft);
        break;

      case PositionConstants.NORTH:
        seg = new Segment(vertex, obs.topLeft);
        seg2 = new Segment(vertex, obs.topRight);
        break;

      case PositionConstants.EAST:
        seg = new Segment(vertex, obs.bottomRight);
        seg2 = new Segment(vertex, obs.topRight);
        break;

      case PositionConstants.SOUTH:
        seg = new Segment(vertex, obs.bottomRight);
        seg2 = new Segment(vertex, obs.bottomLeft);
        break;

      case PositionConstants.WEST:
        seg = new Segment(vertex, obs.topLeft);
        seg2 = new Segment(vertex, obs.bottomLeft);
        break;

      default:
        if (vertex.x == obs.x) {
          seg = new Segment(vertex, obs.topLeft);
          seg2 = new Segment(vertex, obs.bottomLeft);
        } else if (vertex.y == obs.y) {
          seg = new Segment(vertex, obs.topLeft);
          seg2 = new Segment(vertex, obs.topRight);
        } else if (vertex.y == obs.bottom() - 1) {
          seg = new Segment(vertex, obs.bottomLeft);
          seg2 = new Segment(vertex, obs.bottomRight);
        } else if (vertex.x == obs.right() - 1) {
          seg = new Segment(vertex, obs.topRight);
          seg2 = new Segment(vertex, obs.bottomRight);
        }

        throw ("Unexpected vertex conditions");
    }
    stack.push(obs);
    stack.push(null);
    stack.push(seg);
    stack.push(obs);
    stack.push(null);
    stack.push(seg2);
  }
  void addSegmentsTargetAboveSource(Obstacle source, Obstacle target) {
    Segment seg = null;
    Segment seg2 = null;
    if (target.x > source.x) {
      seg = new Segment(source.topLeft, target.topLeft);
      if (target.x < source.right() - 1) seg2 = new Segment(source.topRight, target.bottomLeft); else seg2 = new Segment(source.bottomRight, target.topLeft);
    } else if (source.x == target.x) {
      seg = new Segment(source.topLeft, target.bottomLeft);
      seg2 = new Segment(source.topRight, target.bottomLeft);
    } else {
      seg = new Segment(source.bottomLeft, target.bottomLeft);
      seg2 = new Segment(source.topRight, target.bottomLeft);
    }
    stack.push(source);
    stack.push(target);
    stack.push(seg);
    stack.push(source);
    stack.push(target);
    stack.push(seg2);
    seg = null;
    seg2 = null;
    if (target.right() < source.right()) {
      seg = new Segment(source.topRight, target.topRight);
      if (target.right() - 1 > source.x) seg2 = new Segment(source.topLeft, target.bottomRight); else seg2 = new Segment(source.bottomLeft, target.topRight);
    } else if (source.right() == target.right()) {
      seg = new Segment(source.topRight, target.bottomRight);
      seg2 = new Segment(source.topLeft, target.bottomRight);
    } else {
      seg = new Segment(source.bottomRight, target.bottomRight);
      seg2 = new Segment(source.topLeft, target.bottomRight);
    }
    stack.push(source);
    stack.push(target);
    stack.push(seg);
    stack.push(source);
    stack.push(target);
    stack.push(seg2);
  }
  void addSegmentsTargetBesideSource(Obstacle source, Obstacle target) {
    Segment seg = null;
    Segment seg2 = null;
    if (target.y > source.y) {
      seg = new Segment(source.topLeft, target.topLeft);
      if (target.y < source.bottom() - 1) seg2 = new Segment(source.bottomLeft, target.topRight); else seg2 = new Segment(source.bottomRight, target.topLeft);
    } else if (source.y == target.y) {
      seg = new Segment(source.topLeft, target.topRight);
      seg2 = new Segment(source.bottomLeft, target.topRight);
    } else {
      seg = new Segment(source.topRight, target.topRight);
      seg2 = new Segment(source.bottomLeft, target.topRight);
    }
    stack.push(source);
    stack.push(target);
    stack.push(seg);
    stack.push(source);
    stack.push(target);
    stack.push(seg2);
    seg = null;
    seg2 = null;
    if (target.bottom() < source.bottom()) {
      seg = new Segment(source.bottomLeft, target.bottomLeft);
      if (target.bottom() - 1 > source.y) seg2 = new Segment(source.topLeft, target.bottomRight); else seg2 = new Segment(source.topRight, target.bottomLeft);
    } else if (source.bottom() == target.bottom()) {
      seg = new Segment(source.bottomLeft, target.bottomRight);
      seg2 = new Segment(source.topLeft, target.bottomRight);
    } else {
      seg = new Segment(source.bottomRight, target.bottomRight);
      seg2 = new Segment(source.topLeft, target.bottomRight);
    }
    stack.push(source);
    stack.push(target);
    stack.push(seg);
    stack.push(source);
    stack.push(target);
    stack.push(seg2);
  }
  /**
   */
  void cleanup() {
    visibleVertices.clear();
  }
  /**
   * Begins the creation of the visibility graph with the first segment
   * @param allObstacleslist of all obstacles
   */
  void createVisibilityGraph(List allObstacles) {
    stack.push(null);
    stack.push(null);
    stack.push(new Segment(start, end));
    while (!stack.isEmpty)
      addSegment(stack.pop(), stack.popObstacle(), stack.popObstacle(), allObstacles);
  }
  /**
   * Once the visibility graph is constructed, this is called to label the
   * graph and determine the shortest path. Returns false if no path can be
   * found.
   * @return true if a path can be found.
   */
  bool determineShortestPath() {
    if (!labelGraph()) return false;
    Vertex vertex = end;
    prevCostRatio = end.cost / start.getDistance(end);
    Vertex nextVertex;
    while (vertex != start) {
      nextVertex = vertex.label;
      if (nextVertex == null) return false;
      Segment s = new Segment(nextVertex, vertex);
      segments.add(s);
      vertex = nextVertex;
    }
    Collections.reverse(segments);
    return true;
  }
  /**
   * Resets all necessary fields for a solve.
   */
  void fullReset() {
    visibleVertices.clear();
    segments.clear();
    if (prevCostRatio == 0) {
      double distance = start.getDistance(end);
      threshold = distance * OVAL_CONSTANT;
    } else threshold = prevCostRatio * EPSILON * start.getDistance(end);
    visibleObstacles.clear();
    resetPartial();
  }
  /**
   * Creates the visibility graph and returns whether or not a shortest path
   * could be determined.
   * @param allObstaclesthe list of all obstacles
   * @return true if a shortest path was found
   */
  bool generateShortestPath(List allObstacles) {
    createVisibilityGraph(allObstacles);
    if (visibleVertices.length == 0) return false;
    return determineShortestPath();
  }
  /**
   * Returns the list of constrained points through which this path must pass
   * or <code>null</code>.
   * @see #setBendPoints(PointList)
   * @return list of bend points
   */
  PointList getBendPoints() {
    return bendpoints;
  }
  /**
   * Returns the end point for this path
   * @return end point for this path
   */
  Point getEndPoint() {
    return end;
  }
  /**
   * Returns the solution to this path.
   * @return the points for this path.
   */
  PointList getPoints() {
    return points;
  }
  /**
   * Returns the start point for this path
   * @return start point for this path
   */
  Point getStartPoint() {
    return start;
  }
  /**
   * Returns a subpath for this path at the given segment
   * @param currentSegmentthe segment at which the subpath should be created
   * @return the new path
   */
  Path getSubPath(Segment currentSegment) {
    Path newPath = new Path(start: currentSegment.start, end: end);
    final idx = grownSegments.indexOf(currentSegment);
    newPath.grownSegments = grownSegments.getRange(idx, grownSegments.length);
    grownSegments = grownSegments.getRange(0, idx + 1);
    end = currentSegment.end;
    subPath = newPath;
    return newPath;
  }
  /**
   * Resets the vertices that this path has traveled prior to this segment.
   * This is called when the path has become inverted and needs to rectify any
   * labeling mistakes it made before it knew it was inverted.
   * @param currentSegmentthe segment at which the path found it was inverted
   */
  void invertPriorVertices(Segment currentSegment) {
    int stop = grownSegments.indexOf(currentSegment);
    for (int i = 0; i < stop; i++) {
      Vertex vertex = (grownSegments[i]).end;
      if (vertex.type == Vertex.INNIE) vertex.type = Vertex.OUTIE; else vertex.type = Vertex.INNIE;
    }
  }
  /**
   * Returns true if this obstacle is in the visibility graph
   * @param obsthe obstacle
   * @return true if obstacle is in the visibility graph
   */
  bool isObstacleVisible(Obstacle obs) {
    return visibleObstacles.contains(obs);
  }
  /**
   * Labels the visibility graph to assist in finding the shortest path
   * @return false if there was a gap in the visibility graph
   */
  bool labelGraph() {
    int numPermanentNodes = 1;
    Vertex vertex = start;
    Vertex neighborVertex = null;
    vertex.isPermanent = true;
    while (numPermanentNodes != visibleVertices.length) {
      List neighbors = vertex.neighbors;
      if (neighbors == null) return false;
      for (int i = 0; i < neighbors.length; i++) {
        neighborVertex = neighbors[i];
        if (!neighborVertex.isPermanent) {
          double newCost = vertex.cost + vertex.getDistance(neighborVertex);
          if (neighborVertex.label == null) {
            neighborVertex.label = vertex;
            neighborVertex.cost = newCost;
          } else if (neighborVertex.cost > newCost) {
            neighborVertex.label = vertex;
            neighborVertex.cost = newCost;
          }
        }
      }
      double smallestCost = 0.0;
      Vertex tempVertex = null;
      for (var tempVertex in visibleVertices) {
        if (!tempVertex.isPermanent && tempVertex.label != null && (tempVertex.cost < smallestCost || smallestCost == 0)) {
          smallestCost = tempVertex.cost;
          vertex = tempVertex;
        }
      }
      vertex.isPermanent = true;
      numPermanentNodes++;
    }
    return true;
  }
  /**
   * Links two vertices together in the visibility graph
   * @param segmentthe segment to add
   */
  void linkVertices(Segment segment) {
    if (segment.start.neighbors == null) segment.start.neighbors = new List();
    if (segment.end.neighbors == null) segment.end.neighbors = new List();
    if (!segment.start.neighbors.contains(segment.end)) {
      segment.start.neighbors.add(segment.end);
      segment.end.neighbors.add(segment.start);
    }
    visibleVertices.add(segment.start);
    visibleVertices.add(segment.end);
  }
  /**
   * Called to reconnect a subpath back onto this path. Does a depth-first
   * search to reconnect all paths. Should be called after sorting.
   */
  void reconnectSubPaths() {
    if (subPath != null) {
      subPath.reconnectSubPaths();
      Segment changedSegment = subPath.grownSegments.removeAt(0);
      Segment oldSegment = grownSegments[grownSegments.length - 1];
      oldSegment.end = changedSegment.end;
      grownSegments.addAll(subPath.grownSegments);
      subPath.points.removePoint(0);
      points.removePoint(points.length - 1);
      points.addAll(subPath.points);
      visibleObstacles.addAll(subPath.visibleObstacles);
      end = subPath.end;
      subPath = null;
    }
  }
  /**
   * Refreshes the exclude field on the obstacles in the list. Excludes all
   * obstacles that contain the start or end point for this path.
   * @param allObstacleslist of all obstacles
   */
  void refreshExcludedObstacles(List allObstacles) {
    excludedObstacles.clear();
    for (int i = 0; i < allObstacles.length; i++) {
      Obstacle o = allObstacles[i];
      o.exclude = false;
      if (o.containsPoint(start)) {
        if (o.containsProper(start)) o.exclude = true; else {
        }
      }
      if (o.containsPoint(end)) {
        if (o.containsProper(end)) o.exclude = true; else {
        }
      }
      if (o.exclude && !excludedObstacles.contains(o)) excludedObstacles.add(o);
    }
  }
  /**
   * Resets the fields for everything in the solve after the visibility graph
   * steps.
   */
  void resetPartial() {
    isMarked = false;
    isInverted = false;
    subPath = null;
    isDirty = false;
    grownSegments.clear();
    points.removeAllPoints();
  }
  /**
   * Sets the list of bend points to the given list and dirties the path.
   * @param bendPointsthe list of bend points
   */
  void setBendPoints(PointList bendPoints) {
    this.bendpoints = bendPoints;
    isDirty = true;
  }
  /**
   * Sets the end point for this path to the given point.
   * @param endthe new end point for this path
   */
  void setEndPoint(Point end) {
    if (end == this.end) return;
    this.end = new Vertex.fromPoint(end, null);
    isDirty = true;
  }
  /**
   * Sets the start point for this path to the given point.
   * @param startthe new start point for this path
   */
  void setStartPoint(Point start) {
    if (start == this.start) return;
    this.start = new Vertex.fromPoint(start, null);
    isDirty = true;
  }
  /**
   * Returns <code>true</code> if the path is clean and intersects the given
   * obstacle. Also dirties the path in the process.
   * @since 3.0
   * @param obsthe obstacle
   * @return <code>true</code> if a clean path touches the obstacle
   */
  bool testAndSet(Obstacle obs) {
    var current, next;
    if (isDirty) return false;
    if (excludedObstacles.contains(obs)) return false;
    Segment seg1 = new Segment(obs.topLeft, obs.bottomRight);
    Segment seg2 = new Segment(obs.topRight, obs.bottomLeft);
    for (int s = 0; s < points.length - 1; s++) {
      current = points[s];
      next = points[s + 1];
      if (seg1.intersects2(current, next) ||
          seg2.intersects2(current, next) ||
          obs.containsPoint(current) ||
          obs.containsPoint(next)) {
        isDirty = true;
        return true;
      }
    }
    return false;
  }
}
