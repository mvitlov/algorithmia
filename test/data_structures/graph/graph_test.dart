import 'package:algorithmia/data_structures/graph/graph.dart';
import 'package:algorithmia/data_structures/graph/graph_edge.dart';
import 'package:algorithmia/data_structures/graph/graph_vertex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Graph', () {
    test('should add vertices to graph', () {
      final graph = Graph<String>();

      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');

      graph.addVertex(vertexA).addVertex(vertexB);

      expect(graph.toString(), equals('A,B'));
      expect(graph.getVertexByKey(vertexA.getKey()), equals(vertexA));
      expect(graph.getVertexByKey(vertexB.getKey()), equals(vertexB));
    });

    test('should add edges to undirected graph', () {
      final graph = Graph<String>();

      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);

      graph.addEdge(edgeAB);

      expect(graph.getAllVertices().length, equals(2));
      expect(graph.getAllVertices()[0], equals(vertexA));
      expect(graph.getAllVertices()[1], equals(vertexB));

      final graphVertexA = graph.getVertexByKey(vertexA.getKey());
      final graphVertexB = graph.getVertexByKey(vertexB.getKey());

      expect(graph.toString(), equals('A,B'));
      expect(graphVertexA, isNotNull);
      expect(graphVertexB, isNotNull);

      expect(graph.getVertexByKey('not existing'), isNull);

      expect(graphVertexA?.getNeighbors().length, equals(1));
      expect(graphVertexA?.getNeighbors()[0], equals(vertexB));
      expect(graphVertexA?.getNeighbors()[0], equals(graphVertexB));

      expect(graphVertexB?.getNeighbors().length, equals(1));
      expect(graphVertexB?.getNeighbors()[0], equals(vertexA));
      expect(graphVertexB?.getNeighbors()[0], equals(graphVertexA));
    });

    test('should add edges to directed graph', () {
      final graph = Graph<String>(isDirected: true);

      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);

      graph.addEdge(edgeAB);

      final graphVertexA = graph.getVertexByKey(vertexA.getKey());
      final graphVertexB = graph.getVertexByKey(vertexB.getKey());

      expect(graph.toString(), equals('A,B'));
      expect(graphVertexA, isNotNull);
      expect(graphVertexB, isNotNull);

      expect(graphVertexA!.getNeighbors().length, equals(1));
      expect(graphVertexA.getNeighbors()[0], equals(vertexB));
      expect(graphVertexA.getNeighbors()[0], equals(graphVertexB));

      expect(graphVertexB!.getNeighbors().length, equals(0));
    });

    test('should find edge by vertices in undirected graph', () {
      final graph = Graph<String>();

      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB, weight: 10);

      graph.addEdge(edgeAB);

      final graphEdgeAB = graph.findEdge(vertexA, vertexB);
      final graphEdgeBA = graph.findEdge(vertexB, vertexA);
      final graphEdgeAC = graph.findEdge(vertexA, vertexC);
      final graphEdgeCA = graph.findEdge(vertexC, vertexA);

      expect(graphEdgeAC, isNull);
      expect(graphEdgeCA, isNull);
      expect(graphEdgeAB, equals(edgeAB));
      expect(graphEdgeBA, equals(edgeAB));
      expect(graphEdgeAB?.weight, equals(10));
    });

    test('should find edge by vertices in directed graph', () {
      final graph = Graph<String>(isDirected: true);

      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB, weight: 10);

      graph.addEdge(edgeAB);

      final graphEdgeAB = graph.findEdge(vertexA, vertexB);
      final graphEdgeBA = graph.findEdge(vertexB, vertexA);
      final graphEdgeAC = graph.findEdge(vertexA, vertexC);
      final graphEdgeCA = graph.findEdge(vertexC, vertexA);

      expect(graphEdgeAC, isNull);
      expect(graphEdgeCA, isNull);
      expect(graphEdgeBA, isNull);
      expect(graphEdgeAB!, equals(edgeAB));
      expect(graphEdgeAB.weight, equals(10));
    });

    test('should return vertex neighbors', () {
      final graph = Graph<String>(isDirected: true);

      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      final edgeAC = GraphEdge(startVertex: vertexA, endVertex: vertexC);

      graph.addEdge(edgeAB).addEdge(edgeAC);

      final neighbors = graph.getNeighbors(vertexA);

      expect(neighbors.length, equals(2));
      expect(neighbors[0], equals(vertexB));
      expect(neighbors[1], equals(vertexC));
    });

    test('should throw an error when trying to add edge twice', () {
      addSameEdgeTwice() {
        final graph = Graph<String>(isDirected: true);

        final vertexA = GraphVertex('A');
        final vertexB = GraphVertex('B');

        final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);

        graph.addEdge(edgeAB).addEdge(edgeAB);
      }

      expect(addSameEdgeTwice, throwsException);
    });

    test('should return the list of all added edges', () {
      final graph = Graph<String>(isDirected: true);

      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      final edgeBC = GraphEdge(startVertex: vertexB, endVertex: vertexC);

      graph.addEdge(edgeAB).addEdge(edgeBC);

      final edges = graph.getAllEdges();

      expect(edges.length, equals(2));
      expect(edges[0], equals(edgeAB));
      expect(edges[1], equals(edgeBC));
    });

    test('should calculate total graph weight for default graph', () {
      final graph = Graph<String>();

      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');
      final vertexD = GraphVertex('D');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      final edgeBC = GraphEdge(startVertex: vertexB, endVertex: vertexC);
      final edgeCD = GraphEdge(startVertex: vertexC, endVertex: vertexD);
      final edgeAD = GraphEdge(startVertex: vertexA, endVertex: vertexD);

      graph.addEdge(edgeAB).addEdge(edgeBC).addEdge(edgeCD).addEdge(edgeAD);

      expect(graph.getWeight(), equals(0));
    });

    test('should calculate total graph weight for weighted graph', () {
      final graph = Graph<String>();

      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');
      final vertexD = GraphVertex('D');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB, weight: 1);
      final edgeBC = GraphEdge(startVertex: vertexB, endVertex: vertexC, weight: 2);
      final edgeCD = GraphEdge(startVertex: vertexC, endVertex: vertexD, weight: 3);
      final edgeAD = GraphEdge(startVertex: vertexA, endVertex: vertexD, weight: 4);

      graph.addEdge(edgeAB).addEdge(edgeBC).addEdge(edgeCD).addEdge(edgeAD);

      expect(graph.getWeight(), equals(10));
    });

    test('should be possible to delete edges from graph', () {
      final graph = Graph<String>();

      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      final edgeBC = GraphEdge(startVertex: vertexB, endVertex: vertexC);
      final edgeAC = GraphEdge(startVertex: vertexA, endVertex: vertexC);

      graph.addEdge(edgeAB).addEdge(edgeBC).addEdge(edgeAC);

      expect(graph.getAllEdges().length, equals(3));

      graph.deleteEdge(edgeAB);

      expect(graph.getAllEdges().length, equals(2));
      expect(graph.getAllEdges()[0].getKey(), equals(edgeBC.getKey()));
      expect(graph.getAllEdges()[1].getKey(), equals(edgeAC.getKey()));
    });

    test('should should throw an error when trying to delete not existing edge', () {
      void deleteNotExistingEdge() {
        final graph = Graph<String>();

        final vertexA = GraphVertex('A');
        final vertexB = GraphVertex('B');
        final vertexC = GraphVertex('C');

        final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
        final edgeBC = GraphEdge(startVertex: vertexB, endVertex: vertexC);

        graph.addEdge(edgeAB);
        graph.deleteEdge(edgeBC);
      }

      expect(deleteNotExistingEdge, throwsException);
    });

    test('should be possible to reverse graph', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');
      final vertexD = GraphVertex('D');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      final edgeAC = GraphEdge(startVertex: vertexA, endVertex: vertexC);
      final edgeCD = GraphEdge(startVertex: vertexC, endVertex: vertexD);

      final graph = Graph<String>(isDirected: true);
      graph.addEdge(edgeAB).addEdge(edgeAC).addEdge(edgeCD);

      expect(graph.toString(), equals('A,B,C,D'));
      expect(graph.getAllEdges().length, equals(3));
      expect(graph.getNeighbors(vertexA).length, equals(2));
      expect(graph.getNeighbors(vertexA)[0].getKey(), equals(vertexB.getKey()));
      expect(graph.getNeighbors(vertexA)[1].getKey(), equals(vertexC.getKey()));
      expect(graph.getNeighbors(vertexB).length, equals(0));
      expect(graph.getNeighbors(vertexC).length, equals(1));
      expect(graph.getNeighbors(vertexC)[0].getKey(), equals(vertexD.getKey()));
      expect(graph.getNeighbors(vertexD).length, equals(0));

      graph.reverse();

      expect(graph.toString(), equals('A,B,C,D'));
      expect(graph.getAllEdges().length, equals(3));
      expect(graph.getNeighbors(vertexA).length, equals(0));
      expect(graph.getNeighbors(vertexB).length, equals(1));
      expect(graph.getNeighbors(vertexB)[0].getKey(), equals(vertexA.getKey()));
      expect(graph.getNeighbors(vertexC).length, equals(1));
      expect(graph.getNeighbors(vertexC)[0].getKey(), equals(vertexA.getKey()));
      expect(graph.getNeighbors(vertexD).length, equals(1));
      expect(graph.getNeighbors(vertexD)[0].getKey(), equals(vertexC.getKey()));
    });

    test('should return vertices indices', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');
      final vertexD = GraphVertex('D');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      final edgeBC = GraphEdge(startVertex: vertexB, endVertex: vertexC);
      final edgeCD = GraphEdge(startVertex: vertexC, endVertex: vertexD);
      final edgeBD = GraphEdge(startVertex: vertexB, endVertex: vertexD);

      final graph = Graph<String>();
      graph.addEdge(edgeAB).addEdge(edgeBC).addEdge(edgeCD).addEdge(edgeBD);

      final verticesIndices = graph.getVerticesIndices();
      expect(verticesIndices, equals({'A': 0, 'B': 1, 'C': 2, 'D': 3}));
    });

    test('should generate adjacency matrix for undirected graph', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');
      final vertexD = GraphVertex('D');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      final edgeBC = GraphEdge(startVertex: vertexB, endVertex: vertexC);
      final edgeCD = GraphEdge(startVertex: vertexC, endVertex: vertexD);
      final edgeBD = GraphEdge(startVertex: vertexB, endVertex: vertexD);

      final graph = Graph<String>();
      graph.addEdge(edgeAB).addEdge(edgeBC).addEdge(edgeCD).addEdge(edgeBD);

      final adjacencyMatrix = graph.getAdjacencyMatrix();
      expect(
          adjacencyMatrix,
          equals([
            [null, 0, null, null],
            [0, null, 0, 0],
            [null, 0, null, 0],
            [null, 0, 0, null],
          ]));
    });

    test('should generate adjacency matrix for directed graph', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');
      final vertexD = GraphVertex('D');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB, weight: 2);
      final edgeBC = GraphEdge(startVertex: vertexB, endVertex: vertexC, weight: 1);
      final edgeCD = GraphEdge(startVertex: vertexC, endVertex: vertexD, weight: 5);
      final edgeBD = GraphEdge(startVertex: vertexB, endVertex: vertexD, weight: 7);

      final graph = Graph<String>(isDirected: true);
      graph.addEdge(edgeAB).addEdge(edgeBC).addEdge(edgeCD).addEdge(edgeBD);

      final adjacencyMatrix = graph.getAdjacencyMatrix();
      expect(
          adjacencyMatrix,
          equals([
            [null, 2, null, null],
            [null, null, 1, 7],
            [null, null, null, 5],
            [null, null, null, null],
          ]));
    });
  });
}
