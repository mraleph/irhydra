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
 * Bends a collection of {@link Path Paths} around rectangular obstacles. This
 * class maintains a list of paths and obstacles. Updates can be made to the
 * paths and/or obstacles, and then an incremental solve can be invoked.
 * <P>
 * The algorithm will attempt to find the shortest non-intersecting path between
 * each path's start and end points. Once all paths have been found, they will
 * be offset based on how many paths bend around the same corner of each
 * obstacle.
 * <P>
 * The worst-case performance of this algorithm is p * s * n^2, where p is the
 * number of paths, n is the number of obstacles, and s is the average number of
 * segments in each path's final solution.
 * <P>
 * This class is not intended to be subclassed.
 * @author Whitney Sorenson
 * @author Randy Hudson
 * @since 3.0
 */
class ShortestPathRouter {
  /**
   * The number of times to grow obstacles and test for intersections. This is
   * a tradeoff between performance and quality of output.
   */
  static final int NUM_GROW_PASSES = 2;
  int spacing = 4;
  bool growPassChangedObstacles = false;
  List orderedPaths;
  Map pathsToChildPaths;
  List stack;
  List subPaths;
  List userObstacles;
  List userPaths;
  List workingPaths;
  ShortestPathRouter() {
    userPaths = new List();
    workingPaths = new List();
    pathsToChildPaths = new Map();
    userObstacles = new List();
  }
  /**
   * Adds an obstacle with the given bounds to the obstacles.
   * @param rectthe bounds of this obstacle
   * @return <code>true</code> if the added obstacle has dirtied one or more
   * paths
   */
  bool addObstacle(Rectangle rect) {
    return internalAddObstacle(new Obstacle(rect, this));
  }
  /**
   * Adds a path to the routing.
   * @param paththe path to add.
   */
  void addPath(Path path) {
    userPaths.add(path);
    workingPaths.add(path);
  }
  /**
   * Fills the point lists of the Paths to the correct bent points.
   */
  void bendPaths() {
    for (int i = 0; i < orderedPaths.length; i++) {
      Path path = orderedPaths[i];
      Segment segment = null;
      path.points.addPoint(new Point(path.start.x, path.start.y));
      for (int v = 0; v < path.grownSegments.length; v++) {
        segment = path.grownSegments[v];
        Vertex vertex = segment.end;
        if (vertex != null && v < path.grownSegments.length - 1) {
          if (vertex.type == Vertex.INNIE) {
            vertex.count++;
            path.points.addPoint(vertex.bend(vertex.count));
          } else {
            path.points.addPoint(vertex.bend(vertex.totalCount));
            vertex.totalCount--;
          }
        }
      }
      path.points.addPoint(new Point(path.end.x, path.end.y));
    }
  }
  /**
   * Checks a vertex to see if its offset should shrink
   * @param vertexthe vertex to check
   */
  void checkVertexForIntersections(Vertex vertex) {
    if (vertex.nearestObstacle != 0 || vertex.nearestObstacleChecked) return;
    int sideLength, x, y;
    sideLength = 2 * (vertex.totalCount * getSpacing()) + 1;
    if ((vertex.positionOnObstacle & PositionConstants.NORTH) > 0) y = vertex.y - sideLength; else y = vertex.y;
    if ((vertex.positionOnObstacle & PositionConstants.EAST) > 0) x = vertex.x; else x = vertex.x - sideLength;
    Rectangle r = new Rectangle(x, y, sideLength, sideLength);
    int xDist, yDist;
    for (int o = 0; o < userObstacles.length; o++) {
      Obstacle obs = userObstacles[o];
      if (obs != vertex.obs && r.intersects(obs)) {
        int pos = obs.getPosition(vertex);
        if (pos == 0) continue;
        if ((pos & PositionConstants.NORTH) > 0) yDist = obs.y - vertex.y; else yDist = vertex.y - obs.bottom() + 1;
        if ((pos & PositionConstants.EAST) > 0) xDist = vertex.x - obs.right() + 1; else xDist = obs.x - vertex.x;
        if (Math.max(xDist, yDist) < vertex.nearestObstacle || vertex.nearestObstacle == 0) {
          vertex.nearestObstacle = Math.max(xDist, yDist);
          vertex.updateOffset();
        }
      }
    }
    vertex.nearestObstacleChecked = true;
  }
  /**
   * Checks all vertices along paths for intersections
   */
  void checkVertexIntersections() {
    for (int i = 0; i < workingPaths.length; i++) {
      Path path = workingPaths[i];
      for (int s = 0; s < path.segments.length - 1; s++) {
        Vertex vertex = (path.segments[s]).end;
        checkVertexForIntersections(vertex);
      }
    }
  }
  /**
   * Frees up fields which aren't needed between invocations.
   */
  void cleanup() {
    for (int i = 0; i < workingPaths.length; i++) {
      Path path = workingPaths[i];
      path.cleanup();
    }
  }
  /**
   * Counts how many paths are on given vertices in order to increment their
   * total count.
   */
  void countVertices() {
    for (int i = 0; i < workingPaths.length; i++) {
      Path path = workingPaths[i];
      for (int v = 0; v < path.segments.length - 1; v++) (path.segments[v]).end.totalCount++;
    }
  }
  /**
   * Dirties the paths that are on the given vertex
   * @param vertexthe vertex that has the paths
   */
  bool dirtyPathsOn(Vertex vertex) {
    List paths = vertex.paths;
    if (paths != null && paths.length != 0) {
      for (int i = 0; i < paths.length; i++) (paths[i]).isDirty = true;
      return true;
    }
    return false;
  }
  /**
   * Returns the closest vertex to the given segment.
   * @param v1the first vertex
   * @param v2the second vertex
   * @param segmentthe segment
   * @return v1, or v2 whichever is closest to the segment
   */
  Vertex getNearestVertex(Vertex v1, Vertex v2, Segment segment) {
    if (segment.start.getDistance(v1) + segment.end.getDistance(v1) > segment.start.getDistance(v2) + segment.end.getDistance(v2)) return v2; else return v1;
  }
  /**
   * Returns the spacing maintained between paths.
   * @return the default path spacing
   * @see #setSpacing(int)
   * @since 3.2
   */
  int getSpacing() {
    return spacing;
  }
  /**
   * Returns the subpath for a split on the given path at the given segment.
   * @param paththe path
   * @param segmentthe segment
   * @return the new subpath
   */
  Path getSubpathForSplit(Path path, Segment segment) {
    Path newPath = path.getSubPath(segment);
    workingPaths.add(newPath);
    subPaths.add(newPath);
    return newPath;
  }
  /**
   * Grows all obstacles in in routing and tests for new intersections
   */
  void growObstacles() {
    growPassChangedObstacles = false;
    for (int i = 0; i < NUM_GROW_PASSES; i++) {
      if (i == 0 || growPassChangedObstacles) growObstaclesPass();
    }
  }
  /**
   * Performs a single pass of the grow obstacles step, this can be repeated
   * as desired. Grows obstacles, then tests paths against the grown
   * obstacles.
   */
  void growObstaclesPass() {
    for (int i = 0; i < userObstacles.length; i++) (userObstacles[i]).growVertices();
    for (int i = 0; i < workingPaths.length; i++) {
      Path path = workingPaths[i];
      for (int e = 0; e < path.excludedObstacles.length; e++) (path.excludedObstacles[e]).exclude = true;
      if (path.grownSegments.length == 0) {
        for (int s = 0; s < path.segments.length; s++) testOffsetSegmentForIntersections(path.segments[s], -1, path);
      } else {
        int counter = 0;
        List currentSegments = new List.from(path.grownSegments);
        for (int s = 0; s < currentSegments.length; s++)
          counter += testOffsetSegmentForIntersections(currentSegments[s], s + counter, path);
      }
      for (int e = 0; e < path.excludedObstacles.length; e++) (path.excludedObstacles[e]).exclude = false;
    }
    for (int i = 0; i < userObstacles.length; i++) (userObstacles[i]).shrinkVertices();
  }
  /**
   * Adds an obstacle to the routing
   * @param obsthe obstacle
   */
  bool internalAddObstacle(Obstacle obs) {
    userObstacles.add(obs);
    return testAndDirtyPaths(obs);
  }
  /**
   * Removes an obstacle from the routing.
   * @param rectthe bounds of the obstacle
   * @return the obstacle removed
   */
  bool internalRemoveObstacle(Rectangle rect) {
    Obstacle obs = null;
    int index = -1;
    for (int i = 0; i < userObstacles.length; i++) {
      obs = userObstacles[i];
      if (obs == rect) {
        index = i;
        break;
      }
    }
    userObstacles.removeAt(index);
    bool result = false;
    result = dirtyPathsOn(obs.bottomLeft) || result;
    result = dirtyPathsOn(obs.topLeft) || result;
    result = dirtyPathsOn(obs.bottomRight) || result;
    result = dirtyPathsOn(obs.topRight) || result;
    for (int p = 0; p < workingPaths.length; p++) {
      Path path = workingPaths[p];
      if (path.isDirty) continue;
      if (path.isObstacleVisible(obs)) path.isDirty = result = true;
    }
    return result;
  }
  /**
   * Labels the given path's vertices as innies, or outies, as well as
   * determining if this path is inverted.
   * @param paththe path
   */
  void labelPath(Path path) {
    Segment segment = null;
    Segment nextSegment = null;
    Vertex vertex = null;
    bool agree = false;
    for (int v = 0; v < path.grownSegments.length - 1; v++) {
      segment = path.grownSegments[v];
      nextSegment = path.grownSegments[v + 1];
      vertex = segment.end;
      int crossProduct = segment.crossProduct(new Segment(vertex, vertex.obs.center));
      if (vertex.type == Vertex.NOT_SET) {
        labelVertex(segment, crossProduct, path);
      } else if (!path.isInverted && ((crossProduct > 0 && vertex.type == Vertex.OUTIE) || (crossProduct < 0 && vertex.type == Vertex.INNIE))) {
        if (agree) {
          stack.add(getSubpathForSplit(path, segment));
          return;
        } else {
          path.isInverted = true;
          path.invertPriorVertices(segment);
        }
      } else if (path.isInverted && ((crossProduct < 0 && vertex.type == Vertex.OUTIE) || (crossProduct > 0 && vertex.type == Vertex.INNIE))) {
        stack.add(getSubpathForSplit(path, segment));
        return;
      } else agree = true;
      if (vertex.paths != null) {
        for (int i = 0; i < vertex.paths.length; i++) {
          Path nextPath = vertex.paths[i];
          if (!nextPath.isMarked) {
            nextPath.isMarked = true;
            stack.add(nextPath);
          }
        }
      }
      vertex.addPath(path, segment, nextSegment);
    }
  }
  /**
   * Labels all path's vertices in the routing.
   */
  void labelPaths() {
    Path path = null;
    for (int i = 0; i < workingPaths.length; i++) {
      path = workingPaths[i];
      stack.add(path);
    }
    while (!stack.isEmpty) {
      path = stack.removeLast();
      if (!path.isMarked) {
        path.isMarked = true;
        labelPath(path);
      }
    }
    for (int i = 0; i < workingPaths.length; i++) {
      path = workingPaths[i];
      path.isMarked = false;
    }
  }
  /**
   * Labels the vertex at the end of the semgent based on the cross product.
   * @param segmentthe segment to this vertex
   * @param crossProductthe cross product of this segment and a segment to the
   * obstacles center
   * @param paththe path
   */
  void labelVertex(Segment segment, int crossProduct, Path path) {
    if (crossProduct > 0) {
      if (path.isInverted) segment.end.type = Vertex.OUTIE; else segment.end.type = Vertex.INNIE;
    } else if (crossProduct < 0) {
      if (path.isInverted) segment.end.type = Vertex.INNIE; else segment.end.type = Vertex.OUTIE;
    } else if (segment.start.type != Vertex.NOT_SET) segment.end.type = segment.start.type; else segment.end.type = Vertex.INNIE;
  }
  /**
   * Orders the path by comparing its angle at shared vertices with other
   * paths.
   * @param paththe path
   */
  void orderPath(Path path) {
    if (path.isMarked) return;
    path.isMarked = true;
    Segment segment = null;
    Vertex vertex = null;
    for (int v = 0; v < path.grownSegments.length - 1; v++) {
      segment = path.grownSegments[v];
      vertex = segment.end;
      double thisAngle = vertex.cachedCosines[path];
      if (path.isInverted) thisAngle = -thisAngle;
      for (int i = 0; i < vertex.paths.length; i++) {
        Path vPath = vertex.paths[i];
        if (!vPath.isMarked) {
          double otherAngle = (vertex.cachedCosines[vPath]).doubleValue();
          if (vPath.isInverted) otherAngle = -otherAngle;
          if (otherAngle < thisAngle) orderPath(vPath);
        }
      }
    }
    orderedPaths.add(path);
  }
  /**
   * Orders all paths in the graph.
   */
  void orderPaths() {
    for (int i = 0; i < workingPaths.length; i++) {
      Path path = workingPaths[i];
      orderPath(path);
    }
  }
  /**
   * Populates the parent paths with all the child paths that were created to
   * represent bendpoints.
   */
  void recombineChildrenPaths() {
    for (var path in pathsToChildPaths.keys) {
      path.fullReset();
      List childPaths = pathsToChildPaths[path];
      Path childPath = null;
      for (int i = 0; i < childPaths.length; i++) {
        childPath = childPaths[i];
        path.points.addAll(childPath.getPoints());
        path.points.removePoint(path.points.length - 1);
        path.segments.addAll(childPath.segments);
        path.visibleObstacles.addAll(childPath.visibleObstacles);
      }
      path.points.addPoint(childPath.points.last);
    }
  }
  /**
   * Reconnects all subpaths.
   */
  void recombineSubpaths() {
    for (int p = 0; p < orderedPaths.length; p++) {
      Path path = orderedPaths[p];
      path.reconnectSubPaths();
    }

    Collections.removeAll(orderedPaths, subPaths);
    Collections.removeAll(workingPaths, subPaths);
    subPaths = null;
  }
  /**
   * Removes the obstacle with the rectangle's bounds from the routing.
   * @param rectthe bounds of the obstacle to remove
   * @return <code>true</code> if the removal has dirtied one or more paths
   */
  bool removeObstacle(Rectangle rect) {
    return internalRemoveObstacle(rect);
  }
  /**
   * Removes the given path from the routing.
   * @param paththe path to remove.
   * @return <code>true</code> if the removal may have affected one of the
   * remaining paths
   */
  bool removePath(Path path) {
    Collections.remove(userPaths, path);
    List children = pathsToChildPaths[path];
    if (children == null) {
      Collections.remove(workingPaths, path);
    } else {
      Collections.removeAll(workingPaths, children);
    }
    return true;
  }
  /**
   * Resets exclude field on all obstacles
   */
  void resetObstacleExclusions() {
    for (int i = 0; i < userObstacles.length; i++) (userObstacles[i]).exclude = false;
  }
  /**
   * Resets all vertices found on paths and obstacles.
   */
  void resetVertices() {
    for (int i = 0; i < userObstacles.length; i++) {
      Obstacle obs = userObstacles[i];
      obs.reset();
    }
    for (int i = 0; i < workingPaths.length; i++) {
      Path path = workingPaths[i];
      path.start.fullReset();
      path.end.fullReset();
    }
  }
  /**
   * Sets the default spacing between paths. The spacing is the minimum
   * distance that path should be offset from other paths or obstacles. The
   * default value is 4. When this value can not be satisfied, paths will be
   * squeezed together uniformly.
   * @param spacingthe path spacing
   * @since 3.2
   */
  void setSpacing(int spacing) {
    this.spacing = spacing;
  }
  /**
   * Updates the points in the paths in order to represent the current
   * solution with the given paths and obstacles.
   * @return returns the list of paths which were updated.
   */
  List solve() {
    solveDirtyPaths();
    countVertices();
    checkVertexIntersections();
    growObstacles();
    subPaths = new List();
    stack = new List();
    labelPaths();
    stack = null;
    orderedPaths = new List();
    orderPaths();
    bendPaths();
    recombineSubpaths();
    orderedPaths = null;
    subPaths = null;
    recombineChildrenPaths();
    cleanup();
    return new List.from(userPaths);
  }
  /**
   * Solves paths that are dirty.
   * @return number of dirty paths
   */
  int solveDirtyPaths() {
    int numSolved = 0;
    for (int i = 0; i < userPaths.length; i++) {
      Path path = userPaths[i];
      if (!path.isDirty) continue;
      List children = pathsToChildPaths[path];
      int prevCount = 1, newCount = 1;
      if (children == null) children = []; else prevCount = children.length;
      if (path.getBendPoints() != null) newCount = path.getBendPoints().length + 1;
      if (prevCount != newCount) children = regenerateChildPaths(path, children, prevCount, newCount);
      refreshChildrenEndpoints(path, children);
    }
    for (int i = 0; i < workingPaths.length; i++) {
      Path path = workingPaths[i];
      path.refreshExcludedObstacles(userObstacles);
      if (!path.isDirty) {
        path.resetPartial();
        continue;
      }
      numSolved++;
      path.fullReset();
      bool pathFoundCheck = path.generateShortestPath(userObstacles);
      if (!pathFoundCheck || path.end.cost > path.threshold) {
        resetVertices();
        path.fullReset();
        path.threshold = 0.0;
        pathFoundCheck = path.generateShortestPath(userObstacles);
      }
      resetVertices();
    }
    resetObstacleExclusions();
    if (numSolved == 0) resetVertices();
    return numSolved;
  }
  /**
   * @since 3.0
   * @param path
   * @param children
   */
  void refreshChildrenEndpoints(Path path, List children) {
    Point previous = path.getStartPoint();
    Point next;
    PointList bendpoints = path.getBendPoints();
    Path child;
    for (int i = 0; i < children.length; i++) {
      if (i < bendpoints.length) {
        next = bendpoints[i];
      } else {
        next = path.getEndPoint();
      }
      child = children[i];
      child.setStartPoint(previous);
      child.setEndPoint(next);
      previous = next;
    }
  }
  /**
   * @since 3.0
   * @param path
   * @param children
   */
  List regenerateChildPaths(Path path, List children, int currentSize, int newSize) {
    if (currentSize == 1) {
      Collections.remove(workingPaths, path);
      currentSize = 0;
      children = new List(newSize);
      pathsToChildPaths[path] = children;
    } else if (newSize == 1) {
      Collections.removeAll(workingPaths, children);
      workingPaths.add(path);
      pathsToChildPaths.remove(path);
      return [];
    }
    while (currentSize < newSize) {
      Path child = new Path();
      workingPaths.add(child);
      children.add(child);
      currentSize++;
    }
    while (currentSize > newSize) {
      Path child = children.removeLast();
      Collections.remove(workingPaths, child);
      currentSize--;
    }
    return children;
  }
  /**
   * Tests a segment that has been offset for new intersections
   * @param segmentthe segment
   * @param indexthe index of the segment along the path
   * @param paththe path
   * @return 1 if new segments have been inserted
   */
  int testOffsetSegmentForIntersections(Segment segment, int index, Path path) {
    for (int i = 0; i < userObstacles.length; i++) {
      Obstacle obs = userObstacles[i];
      if (segment.end.obs == obs || segment.start.obs == obs || obs.exclude) continue;
      Vertex vertex = null;
      int offset = getSpacing();
      if (segment.getSlope() < 0) {
        if (segment.intersects(obs.topLeft.x - offset, obs.topLeft.y - offset, obs.bottomRight.x + offset, obs.bottomRight.y + offset)) vertex = getNearestVertex(obs.topLeft, obs.bottomRight, segment); else if (segment.intersects(obs.bottomLeft.x - offset, obs.bottomLeft.y + offset, obs.topRight.x + offset, obs.topRight.y - offset)) vertex = getNearestVertex(obs.bottomLeft, obs.topRight, segment);
      } else {
        if (segment.intersects(obs.bottomLeft.x - offset, obs.bottomLeft.y + offset, obs.topRight.x + offset, obs.topRight.y - offset)) vertex = getNearestVertex(obs.bottomLeft, obs.topRight, segment); else if (segment.intersects(obs.topLeft.x - offset, obs.topLeft.y - offset, obs.bottomRight.x + offset, obs.bottomRight.y + offset)) vertex = getNearestVertex(obs.topLeft, obs.bottomRight, segment);
      }
      if (vertex != null) {
        Rectangle vRect = vertex.getDeformedRectangle(offset);
        if (segment.end.obs != null) {
          Rectangle endRect = segment.end.getDeformedRectangle(offset);
          if (vRect.intersects(endRect)) continue;
        }
        if (segment.start.obs != null) {
          Rectangle startRect = segment.start.getDeformedRectangle(offset);
          if (vRect.intersects(startRect)) continue;
        }
        Segment newSegmentStart = new Segment(segment.start, vertex);
        Segment newSegmentEnd = new Segment(vertex, segment.end);
        vertex.totalCount++;
        vertex.nearestObstacleChecked = false;
        vertex.shrink();
        checkVertexForIntersections(vertex);
        vertex.grow();
        if (vertex.nearestObstacle != 0) vertex.updateOffset();
        growPassChangedObstacles = true;
        if (index != -1) {
          Collections.remove(path.grownSegments, segment);
          path.grownSegments.insert(index, newSegmentStart);
          path.grownSegments.insert(index + 1, newSegmentEnd);
        } else {
          path.grownSegments.add(newSegmentStart);
          path.grownSegments.add(newSegmentEnd);
        }
        return 1;
      }
    }
    if (index == -1) path.grownSegments.add(segment);
    return 0;
  }
  /**
   * Tests all paths against the given obstacle
   * @param obsthe obstacle
   */
  bool testAndDirtyPaths(Obstacle obs) {
    bool result = false;
    for (int i = 0; i < workingPaths.length; i++) {
      Path path = workingPaths[i];
      result = path.testAndSet(obs) || result;
    }
    return result;
  }
  /**
   * Updates the position of an existing obstacle.
   * @param oldBoundsthe old bounds(used to find the obstacle)
   * @param newBoundsthe new bounds
   * @return <code>true</code> if the change the current results to become
   * stale
   */
  bool updateObstacle(Rectangle oldBounds, Rectangle newBounds) {
    bool result = internalRemoveObstacle(oldBounds);
    result = addObstacle(newBounds) || result;
    return result;
  }
}
