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
 * A graph consisting of nodes and directed edges. A DirectedGraph serves as the
 * input to a graph layout algorithm. The algorithm will place the graph's nodes
 * and edges according to certain goals, such as short, non-crossing edges, and
 * readability.
 * @author hudsonr
 * @since 2.1.2
 */
class DirectedGraph {
  int direction = PositionConstants.SOUTH;
  /**
   * The default padding to be used for nodes which don't specify any padding.
   * Padding is the amount of empty space to be left around a node. The
   * default value is undefined.
   */
  Insets defaultPadding = new Insets.round(16);
  /**
   * All of the edges in the graph.
   */
  EdgeList edges = new EdgeList();
  /**
   * All of the nodes in the graph.
   */
  NodeList nodes = new NodeList();
  /**
   * For internal use only. The list of rows which makeup the final graph
   * layout.
   * @deprecated
   */
  RankList ranks = new RankList();
  Node forestRoot;
  Insets margin = new Insets.round(0);
  List<int> rankLocations;
  List<List<int>> cellLocations;
  Dimension size = new Dimension(0, 0);
  /**
   * Returns the default padding for nodes.
   * @return the default padding
   * @since 3.2
   */
  Insets getDefaultPadding() {
    return defaultPadding;
  }
  /**
   * Returns the direction in which the graph will be layed out.
   * @return the layout direction
   * @since 3.2
   */
  int getDirection() {
    return direction;
  }
  /**
   * Sets the outer margin for the entire graph. The margin is the space in
   * which nodes should not be placed.
   * @return the graph's margin
   * @since 3.2
   */
  Insets getMargin() {
    return margin;
  }

  Insets getPadding(Node node) =>
    node.padding == null ? defaultPadding : node.padding;

  Node getNode(int rank, int index) {
    if (ranks.length <= rank) return null;
    Rank r = ranks[rank];
    if (r.length <= index) return null;
    return r[index];
  }

  /**
   * Removes the given edge from the graph.
   * @param edgethe edge to be removed
   */
  void removeEdge(Edge edge) {
    edges.remove(edge);
    edge.source.outgoing.remove(edge);
    edge.target.incoming.remove(edge);
    if (edge.vNodes != null) {
      for (var node in edge.vNodes) {
        removeNode(node);
      }
    }
  }
  /**
   * Removes the given node from the graph. Does not remove the node's edges.
   * @param nodethe node to remove
   */
  void removeNode(Node node) {
    nodes.remove(node);
    if (ranks != null) ranks[node.rank].remove(node);
  }
  /**
   * Sets the default padding for all nodes in the graph. Padding is the empty
   * space left around the <em>outside</em> of each node. The default padding
   * is used for all nodes which do not specify a specific amount of padding
   * (i.e., their padding is <code>null</code>).
   * @param insetsthe padding
   */
  void setDefaultPadding(Insets insets) {
    defaultPadding = insets;
  }
  /**
   * Sets the layout direction for the graph. Edges will be layed out in the
   * specified direction (unless the graph contains cycles). Supported values
   * are:
   * <UL>
   * <LI>{@link org.eclipse.draw2d.PositionConstants#EAST}<LI>{@link org.eclipse.draw2d.PositionConstants#SOUTH}</UL>
   * <P>
   * The default direction is south.
   * @param directionthe layout direction
   * @since 3.2
   */
  void setDirection(int direction) {
    this.direction = direction;
  }
  /**
   * Sets the graphs margin.
   * @param insetsthe graph's margin
   * @since 3.2
   */
  void setMargin(Insets insets) {
    this.margin = insets;
  }
  Dimension getLayoutSize() {
    return size;
  }
}
