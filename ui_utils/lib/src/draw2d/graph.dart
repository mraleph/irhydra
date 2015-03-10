// Copyright 2013 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library draw2d.graph;

import 'dart:math' as math;
import 'dart:collection' as collection;

part "BreakCycles.dart";
part "CollapsedEdges.dart";
part "CompoundBreakCycles.dart";
part "CompoundDirectedGraph.dart";
part "CompoundDirectedGraphLayout.dart";
part "CompoundHorizontalPlacement.dart";
part "CompoundPopulateRanks.dart";
part "CompoundRankSolver.dart";
part "CompoundTransposeMetrics.dart";
part "CompoundVerticalPlacement.dart";
part "ConvertCompoundGraph.dart";
part "Dimension.dart";
part "DirectedGraph.dart";
part "DirectedGraphLayout.dart";
part "Edge.dart";
part "EdgeList.dart";
part "Geometry.dart";
part "GraphUtilities.dart";
part "GraphVisitor.dart";
part "HorizontalPlacement.dart";
part "InitialRankSolver.dart";
part "Insets.dart";
part "InvertEdges.dart";
part "LocalOptimizer.dart";
part "MinCross.dart";
part "NestingTree.dart";
part "Node.dart";
part "NodeCluster.dart";
part "NodeList.dart";
part "NodePair.dart";
part "Obstacle.dart";
part "Path.dart";
part "Point.dart";
part "PointList.dart";
part "PopulateRanks.dart";
part "PositionConstants.dart";
part "Rank.dart";
part "RankAssignmentSolver.dart";
part "RankList.dart";
part "RankSorter.dart";
part "Rectangle.dart";
part "RevertableChange.dart";
part "RouteEdges.dart";
part "Segment.dart";
part "ShortestPathRouter.dart";
part "SortSubgraphs.dart";
part "SpanningTreeVisitor.dart";
part "Subgraph.dart";
part "SubgraphBoundary.dart";
part "TightSpanningTreeSolver.dart";
part "Transform.dart";
part "TransposeMetrics.dart";
part "Vertex.dart";
part "VerticalPlacement.dart";
part "VirtualNodeCreation.dart";

class Integer {
  static const MAX_VALUE = (1 << 30) - 1;
  static const MIN_VALUE = -MAX_VALUE;
}

class Math {
  static min(x, y) => math.min(x, y);
  static max(x, y) => math.max(x, y);
  static floor(num n) => n.floor();
  static ceil(num n) => n.ceil();
  static round(num n) => n.round();
  static abs(num n) => n.abs();
  static toDegrees(num n) {
    return 180 * n / math.PI;
  }
}

class Collections {
  static reverse(List l) {
    final mid = l.length ~/ 2;
    for (var i = 0, j = l.length - 1; i < mid; i++, j--) {
      var temp = l[i];
      l[i] = l[j];
      l[j] = temp;
    }
  }

  static removeAll(from, es) {
    for (var e in es) remove(from, e);
  }

  static remove(from, e) {
    final i = from.indexOf(e);
    if (i != -1) {
      from.removeAt(i);
    }
  }
}

class NullMap {
  final map = new Map();

  var nullValue;

  operator [](key) {
    if (key == null) return nullValue;
    return map[key];
  }

  operator []= (key, value) {
    if (key == null) { nullValue = value; return; }
    map[key] = value;
  }
}

/** A helper class to quickly implement lists backed by built-in list type. */
class ListBase<T> extends collection.ListBase<T> {
  final list = new List<T>();

  T operator[] (index) => list[index];
  operator[]=(index, T value) { list[index] = value; }
  get length => list.length;
  set length(value) { list.length = value; }
}