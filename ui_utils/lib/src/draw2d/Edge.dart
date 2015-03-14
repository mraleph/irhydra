/**
 * Copyright (c) 2003, 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * IBM Corporation - initial API and implementation
 */

part of draw2d.graph;

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


  Edge(this.source, this.target, {this.delta: 1, this.weight: 1}) {
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

  /** Returns the effective source offset for this edge. */
  int get sourceOffset => source.offsetOutgoing;

  /** Returns the effective target offset for this edge. */
  int get targetOffset => target.offsetIncoming;

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

  void setPoints(PointList points) {
    this.points = points;
    start = points.first;
    end = points.last;
  }

  toString() => "Edge($source, $target)";
}
