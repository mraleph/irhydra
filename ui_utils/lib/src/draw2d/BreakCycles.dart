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
 * This visitor eliminates cycles in the graph using a "greedy" heuristic. Nodes
 * which are sources and sinks are marked and placed in a source and sink list,
 * leaving only nodes involved in cycles. A remaining node with the highest
 * (outgoing-incoming) edges score is then chosen greedily as if it were a
 * source. The process is repeated until all nodes have been marked and placed
 * in a list. The lists are then concatenated, and any edges which go backwards
 * in this list will be inverted during the layout procedure.
 * @author Daniel Lee
 * @since 2.1.2
 */
class BreakCycles extends GraphVisitor {
  final NodeList graphNodes = new NodeList();

  void visit(DirectedGraph g) {
    graphNodes.resetFlags();
    for (var n in g.nodes) {
      setIncomingCount(n, n.incoming.length);
      graphNodes.add(n);
    }

    if (containsCycles(g)) {
      breakCycles(g);
    }
  }

  void revisit(DirectedGraph g) {
    for (var edge in g.edges) {
      if (edge.isFeedback) edge.invert();
    }
  }

  bool allNodesFlagged() => graphNodes.list.every((n) => n.flag);

  void breakCycles(DirectedGraph g) {
    initializeDegrees(g);
    greedyCycleRemove(g);
    invertEdges(g);
  }

  bool containsCycles(DirectedGraph g) {
    List noLefts = new List();

    for (var node in graphNodes.list) {
      if (getIncomingCount(node) == 0) {
        sortedInsert(noLefts, node);
      }
    }

    while (noLefts.length > 0) {
      final node = noLefts.removeLast();
      node.flag = true;

      for (Edge edge in node.outgoing.list) {
        final right = edge.target;
        setIncomingCount(right, getIncomingCount(right) - 1);
        if (getIncomingCount(right) == 0) {
          sortedInsert(noLefts, right);
        }
      }
    }

    return !allNodesFlagged();
  }

  Node findNodeWithMaxDegree() {
    int max = Integer.MIN_VALUE;
    Node maxNode = null;
    for (var node in graphNodes.list) {
      if (getDegree(node) >= max && !node.flag) {
        max = getDegree(node);
        maxNode = node;
      }
    }
    return maxNode;
  }

  void greedyCycleRemove(DirectedGraph g) {
    final sL = new NodeList();
    final sR = new NodeList();

    do {
      bool hasSink;
      do {
        hasSink = false;
        for (var node in graphNodes) {
          if (getOutDegree(node) == 0 && !node.flag) {
            hasSink = true;
            node.flag = true;
            updateIncoming(node);
            sR.add(node);
            break;
          }
        }
      } while (hasSink);
      bool hasSource;
      do {
        hasSource = false;
        for (var node in graphNodes) {
          if (getInDegree(node) == 0 && !node.flag) {
            hasSource = true;
            node.flag = true;
            updateOutgoing(node);
            sL.add(node);
            break;
          }
        }
      } while (hasSource);
      Node max = findNodeWithMaxDegree();
      if (max != null) {
        sL.add(max);
        max.flag = true;
        updateIncoming(max);
        updateOutgoing(max);
      }
    } while (!allNodesFlagged());

    int orderIndex = 0;
    for (int i = 0; i < sL.length; i++) {
      setOrderIndex(sL[i], orderIndex++);
    }
    for (int i = sR.length - 1; i >= 0; i--) {
      setOrderIndex(sR[i], orderIndex++);
    }
  }

  void initializeDegrees(DirectedGraph g) {
    graphNodes.resetFlags();
    for (var n in g.nodes) {
      setInDegree(n, n.incoming.length);
      setOutDegree(n, n.outgoing.length);
      setDegree(n, n.outgoing.length - n.incoming.length);
    }
  }

  void invertEdges(DirectedGraph g) {
    for (var e in g.edges) {
      if (getOrderIndex(e.source) > getOrderIndex(e.target)) {
        e.invert();
        e.isFeedback = true;
      }
    }
  }

  void sortedInsert(List list, Node node) {
    int insert = 0;
    while (insert < list.length && list[insert].sortValue > node.sortValue) {
      insert++;
    }
    list.insert(insert, node);
  }

  void updateIncoming(Node n) {
    for (int i = 0; i < n.incoming.length; i++) {
      Node inSource = n.incoming[i].source;
      if (inSource.flag == false) {
        setOutDegree(inSource, getOutDegree(inSource) - 1);
        setDegree(inSource, getOutDegree(inSource) - getInDegree(inSource));
      }
    }
  }

  void updateOutgoing(Node n) {
    for (int i = 0; i < n.outgoing.length; i++) {
      Node out = n.outgoing[i].target;
      if (out.flag == false) {
        setInDegree(out, getInDegree(out) - 1);
        setDegree(out, getOutDegree(out) - getInDegree(out));
      }
    }
  }

  int getDegree(Node n) => n.workingInts[3];
  void setDegree(Node n, int deg) {
    n.workingInts[3] = deg;
  }

  int getIncomingCount(Node n) => n.workingInts[0];
  void setIncomingCount(Node n, int count) {
    n.workingInts[0] = count;
  }

  int getInDegree(Node n) => n.workingInts[1];
  void setInDegree(Node n, int deg) {
    n.workingInts[1] = deg;
  }

  int getOrderIndex(Node n) => n.workingInts[0];
  void setOutDegree(Node n, int deg) {
    n.workingInts[2] = deg;
  }

  int getOutDegree(Node n) => n.workingInts[2];
  void setOrderIndex(Node n, int index) {
    n.workingInts[0] = index;
  }
}
