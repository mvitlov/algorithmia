import 'package:algorithmia/data_structures/graph/graph_edge.dart';
import 'package:algorithmia/data_structures/graph/graph_vertex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GraphVertex', () {
    test('should create graph vertex', () {
      final vertex = GraphVertex('A');

      expect(vertex, isNotNull);
      expect(vertex.value, equals('A'));
      expect(vertex.toString(), equals('A'));
      expect(vertex.getKey(), equals('A'));
      expect(vertex.edges.toString(), equals('()'));
      expect(vertex.getEdges(), equals([]));
    });

    test('should add edges to vertex and check if it exists', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      vertexA.addEdge(edgeAB);

      expect(vertexA.hasEdge(edgeAB), isTrue);
      expect(vertexB.hasEdge(edgeAB), isFalse);
      expect(vertexA.getEdges().length, equals(1));
      expect(vertexA.getEdges()[0].toString(), equals('A_B'));
    });

    test('should delete edges from vertex', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      final edgeAC = GraphEdge(startVertex: vertexA, endVertex: vertexC);
      vertexA.addEdge(edgeAB).addEdge(edgeAC);

      expect(vertexA.hasEdge(edgeAB), isTrue);
      expect(vertexB.hasEdge(edgeAB), isFalse);

      expect(vertexA.hasEdge(edgeAC), isTrue);
      expect(vertexC.hasEdge(edgeAC), isFalse);

      expect(vertexA.getEdges().length, equals(2));

      expect(vertexA.getEdges()[0].toString(), equals('A_B'));
      expect(vertexA.getEdges()[1].toString(), equals('A_C'));

      vertexA.deleteEdge(edgeAB);
      expect(vertexA.hasEdge(edgeAB), isFalse);
      expect(vertexA.hasEdge(edgeAC), isTrue);
      expect(vertexA.getEdges()[0].toString(), equals('A_C'));

      vertexA.deleteEdge(edgeAC);
      expect(vertexA.hasEdge(edgeAB), isFalse);
      expect(vertexA.hasEdge(edgeAC), isFalse);
      expect(vertexA.getEdges().length, equals(0));
    });

    test('should delete all edges from vertex', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      final edgeAC = GraphEdge(startVertex: vertexA, endVertex: vertexC);
      vertexA.addEdge(edgeAB).addEdge(edgeAC);

      expect(vertexA.hasEdge(edgeAB), isTrue);
      expect(vertexB.hasEdge(edgeAB), isFalse);

      expect(vertexA.hasEdge(edgeAC), isTrue);
      expect(vertexC.hasEdge(edgeAC), isFalse);

      expect(vertexA.getEdges().length, equals(2));

      vertexA.deleteAllEdges();

      expect(vertexA.hasEdge(edgeAB), isFalse);
      expect(vertexB.hasEdge(edgeAB), isFalse);

      expect(vertexA.hasEdge(edgeAC), isFalse);
      expect(vertexC.hasEdge(edgeAC), isFalse);

      expect(vertexA.getEdges().length, equals(0));
    });

    test('should return vertex neighbors in case if current node is start one', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      final edgeAC = GraphEdge(startVertex: vertexA, endVertex: vertexC);
      vertexA.addEdge(edgeAB).addEdge(edgeAC);

      expect(vertexB.getNeighbors(), equals([]));

      final neighbors = vertexA.getNeighbors();

      expect(neighbors.length, equals(2));
      expect(neighbors[0], equals(vertexB));
      expect(neighbors[1], equals(vertexC));
    });

    test('should return vertex neighbors in case if current node is end one', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');

      final edgeBA = GraphEdge(startVertex: vertexB, endVertex: vertexA);
      final edgeCA = GraphEdge(startVertex: vertexC, endVertex: vertexA);
      vertexA.addEdge(edgeBA).addEdge(edgeCA);

      expect(vertexB.getNeighbors(), equals([]));

      final neighbors = vertexA.getNeighbors();

      expect(neighbors.length, equals(2));
      expect(neighbors[0], equals(vertexB));
      expect(neighbors[1], equals(vertexC));
    });

    test('should check if vertex has specific neighbor', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      vertexA.addEdge(edgeAB);

      expect(vertexA.hasNeighbor(vertexB), isTrue);
      expect(vertexA.hasNeighbor(vertexC), isFalse);
    });

    test('should find edge by vertex', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final vertexC = GraphVertex('C');

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      vertexA.addEdge(edgeAB);

      expect(vertexA.findEdge(vertexB), equals(edgeAB));
      expect(vertexA.findEdge(vertexC), isNull);
    });

    test('should calculate vertex degree', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');

      expect(vertexA.getDegree(), equals(0));

      final edgeAB = GraphEdge(startVertex: vertexA, endVertex: vertexB);
      vertexA.addEdge(edgeAB);

      expect(vertexA.getDegree(), equals(1));

      final edgeBA = GraphEdge(startVertex: vertexB, endVertex: vertexA);
      vertexA.addEdge(edgeBA);

      expect(vertexA.getDegree(), equals(2));

      vertexA.addEdge(edgeAB);
      expect(vertexA.getDegree(), equals(3));

      expect(vertexA.getEdges().length, equals(3));
    });
  });
}
