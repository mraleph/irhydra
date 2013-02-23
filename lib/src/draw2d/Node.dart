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

class NeighborsIterator {
  final Node node;

  int offset = 0;
  EdgeList list;

  NeighborsIterator(node) : node = node, list = node.outgoing;

  next() {
    Edge edge = list[offset++];
    if (offset < list.length)
      return edge.opposite(node);
    if (list == node.outgoing) {
      list = node.incoming;
      offset = 0;
    } else
      list = null;
    return edge.opposite(node);
  }

  bool hasNext() {
    if (list == null)
      return false;
    if (offset < list.length)
      return true;
    if (list == node.outgoing) {
      list = node.incoming;
      offset = 0;
    }
    return offset < list.length;
  }

  void remove() {
    throw ("Remove not supported"); //$NON-NLS-1$
  }
}

/**
 * A node in a DirectedGraph. A node has 0 or more incoming and outgoing{@link Edge}s. A node is given a width and height by the client. When a
 * layout places the node in the graph, it will determine the node's x and y
 * location. It may also modify the node's height.
 * A node represents both the <EM>input</EM> and the <EM>output</EM> for a
 * layout algorithm. The following fields are used as input to a graph layout:
 * <UL>
 * <LI>{@link #width} - the node's width.
 * <LI>{@link #height} - the node's height.
 * <LI>{@link #outgoing} - the node's outgoing edges.
 * <LI>{@link #incoming} - the node's incoming edges.
 * <LI>padding - the amount of space to be left around the outside of the node.
 * <LI>{@link #incomingOffset} - the default attachment point for incoming
 * edges.
 * <LI>{@link #outgoingOffset} - the default attachment point for outgoing
 * edges.
 * <LI>parent - the parent subgraph containing this node.
 * </UL>
 * <P>
 * The following fields are calculated by a graph layout and comprise the
 * <EM>output</EM>:
 * <UL>
 * <LI>{@link #x} - the node's x location
 * <LI>{@link #y} - the node's y location
 * <LI>{@link #height} - the node's height may be stretched to match the height
 * of other nodes
 * </UL>
 * @author Randy Hudson
 * @since 2.1.2
 */
class Node {
  Node left, right;
  List<Object> workingData = new List<Object>.fixedLength(3);
  List<int> workingInts = new List<int>.fixedLength(4, fill: 0);
  /**
   * Clients may use this field to mark the Node with an arbitrary data
   * object.
   */
  var data;
  bool flag = false;
  /**
   * The height of this node. This value should be set prior to laying out the
   * directed graph. Depending on the layout rules, a node's height may be
   * expanded to match the height of other nodes around it.
   */
  int height = 40;
  /**
   * @deprecated use {@link #setRowConstraint(int)} and{@link #getRowConstraint()}
   */
  int rowOrder = -1;
  /**
   * The edges for which this node is the target.
   */
  EdgeList incoming = new EdgeList();
  /**
   * The default attachment point for incoming edges. <code>-1</code>
   * indicates that the node's horizontal center should be used.
   */
  int incomingOffset = -1;
  int index = 0;
  int nestingIndex = -1;
  /**
   * The edges for which this node is the source.
   */
  EdgeList outgoing = new EdgeList();
  Insets padding;
  int rank = 0;
  /**
   * @deprecated for internal use only
   */
  double sortValue = 0.0;
  /**
   * The node's outgoing offset attachment point.
   */
  int outgoingOffset = -1;
  /**
   * The node's width. The default value is 50.
   */
  int width = 50;
  /**
   * The node's x coordinate.
   */
  int x = 0;
  /**
   * The node's y coordinate.
   */
  int y = 0;

  Node({this.data: null});

  /**
   * Returns the incoming attachment point. This is the distance from the left
   * edge to the default incoming attachment point for edges. Each incoming
   * edge may have it's own attachment setting which takes priority over this
   * default one.
   * @return the incoming offset
   */
  int getOffsetIncoming() {
    if (incomingOffset == -1) return width ~/ 2;
    return incomingOffset;
  }
  /**
   * Returns the outgoing attachment point. This is the distance from the left
   * edge to the default outgoing attachment point for edges. Each outgoing
   * edge may have it's own attachment setting which takes priority over this
   * default one.
   * @return the outgoing offset
   */
  int getOffsetOutgoing() {
    if (outgoingOffset == -1) return width ~/ 2;
    return outgoingOffset;
  }
  /**
   * Returns the padding for this node or <code>null</code> if the default
   * padding for the graph should be used.
   * @return the padding or <code>null</code>
   */
  Insets getPadding() {
    return padding;
  }
  /**
   * For internal use only. Returns <code>true</code> if the given node is
   * equal to this node. This method is implemented for consitency with
   * Subgraph.
   * @param nodethe node in question
   * @return <code>true</code> if nested
   */
  bool isNested(Node node) {
    return node == this;
  }
  /**
   * Sets the padding. <code>null</code> indicates that the default padding
   * should be used.
   * @param paddingan insets or <code>null</code>
   */
  void setPadding(Insets padding) {
    this.padding = padding;
  }

  /**
   * Sets the row sorting constraint for this node. By default, a node's
   * constraint is <code>-1</code>. If two nodes have different values both >=
   * 0, the node with the smaller constraint will be placed to the left of the
   * other node. In all other cases no relative placement is guaranteed.
   * @param valuethe row constraint
   * @since 3.2
   */
  void setRowConstraint(int value) {
    this.rowOrder = value;
  }
  /**
   * Returns the row constraint for this node.
   * @return the row constraint
   * @since 3.2
   */
  int getRowConstraint() {
    return rowOrder;
  }
  /**
   * Sets the size of this node to the given dimension.
   * @param sizethe new size
   * @since 3.2
   */
  void setSize(Dimension size) {
    width = size.width;
    height = size.height;
  }
  /**
   * @see Object#toString()
   */
  String toString() {
    return "N($data)";
  }

  iteratorNeighbors() {
    return new NeighborsIterator(this);
  }

  /**
   * Returns a reference to a node located left from this one
   * @return <code>Node</code> on the left from this one
   * @since 3.4
   */
  Node getLeft() {
    return left;
  }
  /**
   * Returns a reference to a node located right from this one
   * @return <code>Node</code> on the right from this one
   * @since 3.4
   */
  Node getRight() {
    return right;
  }
}
