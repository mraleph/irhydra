/**
 * Copyright (c) 2003, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */

part of graph;

/**
 * A directed Edge joining a source and target Node. Edges indicate the
 * dependencies between nodes. An Edge provides the information needed to
 * perform a graph layout, and it stores the result of the layout in its various
 * field. Therefore, it functions both as input and output. The input data
 * consists of:
 * <UL>
 * <LI>{@link #source} - the source Node
 * <LI>{@link #target} - the target Node
 * <LI>{@link #delta} - the minimum number of rows the edge should span
 * <LI>{@link #weight} - a hint indicating this edge's importance
 * <LI>{@link #width} - the edge's width
 * <LI>{@link #padding} - the amount of space to leave on either side of the
 * edge
 * <LI>[{@link #offsetSource}] - the edge's attachment point at the source node
 * <LI>[{@link #offsetTarget}] - the edge's attachment point at the target node
 * </UL>
 * <P>
 * The output of a layout consists of bending longer edges, and potentially
 * inverting edges to remove cycles in the graph. The output consists of:
 * <UL>
 * <LI>{@link #vNodes} - the virtual nodes (if any) which make up the bendpoints
 * <LI>{@link #isFeedback} - <code>true</code> if the edge points backwards
 * </UL>
 * @author hudsonr
 * @since 2.1.2
 */
class Edge {
  int cut = 0;
  /**
   * An arbitrary data field for use by clients.
   */
  Object data;
  /**
   * The minimum rank separation between the source and target nodes. The
   * default value is 1.
   * @deprecated use accessors instead
   */
  int delta = 1;
  /**
   * The ending point.
   * @deprecated use {@link #getPoints()}
   */
  Point end;

  bool flag = false;

  /**
   * <code>true</code> if the edge was a feedback edge. The layout
   * algorithm may invert one or more edges to remove all cycles from the
   * input. The set of edges that are inverted are referred to as the
   * "feedback" set.
   */
  bool isFeedback = false;

  /**
   * The edge's attachment point at the <em>source</em> node. The default
   * value is -1, which indicates that the edge should use the node's default{@link Node#getOffsetOutgoing() outgoing} attachment point.
   * @deprecated use accessors instead
   */
  int offsetSource = -1;
  /**
   * The edge's attachment point at the <em>target</em> node. The default
   * value is -1, which indicates that the edge should use the node's default{@link Node#getOffsetIncoming() incoming} attachment point.
   * @deprecated use accessors instead
   */
  int offsetTarget = -1;
  /**
   * The minimum amount of space to leave on both the left and right sides of
   * the edge.
   * @deprecated use accessors instead
   */
  int padding = 10;
  PointList points;
  /**
   * The source Node.
   */
  Node source;
  /**
   * The starting point.
   * @deprecated use {@link #getPoints()}
   */
  Point start;
  /**
   * The target Node.
   */
  Node target;
  bool tree = false;
  /**
   * The virtual nodes used to bend edges which go across one or more ranks.
   * Each virtual node is just a regular node which occupies some small amount
   * of space on a row. It's width is equivalent to the edge's width. Clients
   * can use each virtual node's location (x, y, width, and height) as the way
   * to position an edge which spans multiple rows.
   */
  NodeList vNodes;
  /**
   * A hint indicating how straight and short the edge should be relative to
   * other edges in the graph. The default value is <code>1</code>.
   */
  int weight = 1;
  /**
   * @deprecated use accessors instead
   */
  int width = 1;

  Edge(this.source, this.target, [this.delta = 1, this.weight = 1]) {
    source.outgoing.add(this);
    target.incoming.add(this);
  }

  /**
   * For internal use only. Returns the index of the {@link Node} (or{@link VirtualNode}) on this edge at the given rank. If this edge doesn't
   * have a node at the given rank, -1 is returned.
   * @param rankthe rank
   * @return the edges index at the given rank
   */
  int getIndexForRank(int rank) {
    if (source.rank == rank) return source.index;
    if (target.rank == rank) return target.index;
    if (vNodes != null) {
      return vNodes[rank - source.rank - 1].index;
    }
    return -1;
  }

  /**
   * For internal use only. Returns the target node's row minus the source
   * node's row.
   * @return the distance from the source to target ranks
   */
  int get length => (target.rank - source.rank);

  int get slack => (target.rank - source.rank) - delta;

  /**
   * Returns the effective source offset for this edge. The effective source
   * offset is either the {@link #offsetSource} field, or the source node's
   * default outgoing offset if that field's value is -1.
   * @return the source offset
   */
  int getSourceOffset() {
    if (offsetSource != -1) return offsetSource;
    return source.getOffsetOutgoing();
  }
  /**
   * Returns the effective target offset for this edge. The effective target
   * offset is either the {@link #offsetTarget} field, or the target node's
   * default incoming offset if that field's value is -1.
   * @return the target offset
   */
  int getTargetOffset() {
    if (offsetTarget != -1) return offsetTarget;
    return target.getOffsetIncoming();
  }
  int getWidth() {
    return width;
  }
  /**
   * Swaps the source and target nodes. If any positional data has been
   * calculated, it is inverted as well to reflect the new direction.
   * @since 2.1.2
   */
  void invert() {
    source.outgoing.remove(this);
    target.incoming.remove(this);
    Node oldTarget = target;
    target = source;
    source = oldTarget;
    int temp = offsetSource;
    offsetSource = offsetTarget;
    offsetTarget = temp;
    target.incoming.add(this);
    source.outgoing.add(this);
    if (points != null) points.reverse();
    if (vNodes != null) {
      NodeList newVNodes = new NodeList();
      for (int j = vNodes.length - 1; j >= 0; j--) {
        newVNodes.add(vNodes[j]);
      }
      vNodes = newVNodes;
    }
    if (start != null) {
      Point pt = start;
      start = end;
      end = pt;
    }
  }

  /**
   * For internal use only. Returns the node opposite the given node on this
   * edge.
   * @param endone end
   * @return the other end
   */
  Node opposite(Node end) {
    if (source == end) return target;
    return source;
  }

  /**
   * Sets the padding for this edge.
   * @param paddingthe padding
   * @since 3.2
   */
  void setPadding(int padding) {
    this.padding = padding;
  }
  void setPoints(PointList points) {
    this.points = points;
    start = points.first;
    end = points.last;
  }
  /**
   * Sets the source node and adds this edge to the new source's outgoing
   * edges. If the source node is previously set, removes this edge from the
   * old source's outgoing edges.
   * @param nodethe new source
   * @since 3.2
   */
  void setSource(Node node) {
    if (source == node) return;
    if (source != null) source.outgoing.remove(this);
    source = node;
    if (source != null) source.outgoing.add(this);
  }
  void setSourceOffset(int offset) {
    this.offsetSource = offset;
  }
  /**
   * Sets the target node and adds this edge to the new target's incoming
   * edges. If the target node is previously set, removes this edge from the
   * old target's incoming edges.
   * @param nodethe new target
   * @since 3.2
   */
  void setTarget(Node node) {
    if (target == node) return;
    if (target != null) target.incoming.remove(this);
    target = node;
    if (target != null) target.incoming.add(this);
  }
  void setTargetOffset(int offset) {
    this.offsetTarget = offset;
  }
  /**
   * Sets the width of the edge.
   * @param widththe new width
   * @since 3.2
   */
  void setWidth(int width) {
    this.width = width;
  }
  
  toString() => "Edge($source, $target)";
}
