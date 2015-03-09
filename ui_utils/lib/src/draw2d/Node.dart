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
  int x = 0;
  int y = 0;

  int width = 50;
  int height = 40;

  Insets padding;

  /** Arbitrary data attached to this node. */
  var data;
  bool flag = false;

  /** The edges for which this node is the target. */
  EdgeList incoming = new EdgeList();

  /** The edges for which this node is the source. */
  EdgeList outgoing = new EdgeList();

  int index = 0;
  int rank = 0;
  double sortValue = 0.0;
  Node left, right;
  List<Object> workingData = new List<Object>(3);
  List<int> workingInts = new List<int>.filled(4, 0);

  Node({this.data: null});

  /** Returns the incoming attachment point. */
  int get offsetIncoming => width ~/ 2;

  /** Returns the outgoing attachment point. */
  int get offsetOutgoing => width ~/ 2;

  String toString() => "N($data)";

  iteratorNeighbors() => new NeighborsIterator(this);
}
