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
 * A Node which may contain other nodes. A Subgraph is a compound or container
 * node. It may have incoming and outgoing edges just like a node. Subgraphs are
 * used in {@link CompoundDirectedGraph}s. A proper layout of a compound graph
 * ensures that all of a subgraph's children are placed inside its rectangular
 * region. Nodes which do not belong to the subgraph must be placed outside that
 * region.
 * <P>
 * A Subgraph may contain another Subgraph.
 * <P>
 * A Subgraph has additional geometric properties which describe the containing
 * box. They are:
 * <UL>
 * <LI>{@link #insets} - the size of the subgraph's border. A subgraph is
 * typically rendered as a thin rectangular box. Sometimes this box is labeled
 * or decorated. The insets can be used to reserve space for this purpose.
 * <LI>{@link #innerPadding} - the amount of empty space that must be preserved
 * just inside the subgraph's border. This is the minimum space between the
 * border, and the children node's contained inside the subgraph.
 * </UL>
 *
 * @author hudsonr
 * @since 2.1.2
 */
class Subgraph extends Node {

  /**
   * The children of this subgraph. Nodes may not belong to more than one
   * subgraph.
   */
  NodeList members = new NodeList();

  Node head;
  Node tail;
  Node left;
  Node right;
  int nestingTreeMin;

  /**
   * The space required for this subgraph's border. The default value is
   * undefined.
   */
  Insets insets = new Insets.round(1);

  /**
   * The minimum space between this subgraph's border and it's children.
   */
  Insets innerPadding = NO_INSETS;

  static final Insets NO_INSETS = new Insets.round(0);

  /**
   * Constructs a new subgraph with the given data object and parent subgraph.
   *
   * @see Node#Node(Object, Subgraph)
   * @param data
   *            an arbitrary data object
   * @param parent
   *            the parent
   */
  Subgraph(Object data, [Subgraph parent]) : super(data: data, parent: parent);

  /**
   * Adds the given node to this subgraph.
   *
   * @param n
   *            the node to add
   */
  void addMember(Node n) {
    members.add(n);
  }

  /**
   * Returns <code>true</code> if the given node is contained inside the
   * branch represented by this subgraph.
   *
   * @param n
   *            the node in question
   * @return <code>true</code> if nested
   */
  bool isNested(Node n) {
    return n.nestingIndex >= nestingTreeMin
        && n.nestingIndex <= nestingIndex;
  }

}
