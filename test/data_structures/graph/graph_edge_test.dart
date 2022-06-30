import 'package:algorithmia/data_structures/graph/graph_edge.dart';
import 'package:algorithmia/data_structures/graph/graph_vertex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GraphEdge', () {
    test('should create graph edge with default weight', () {
      final startVertex = GraphVertex('A');
      final endVertex = GraphVertex('B');
      final edge = GraphEdge(startVertex: startVertex, endVertex: endVertex);

      expect(edge.getKey(), equals('A_B'));
      expect(edge.toString(), equals('A_B'));
      expect(edge.startVertex, equals(startVertex));
      expect(edge.endVertex, equals(endVertex));
      expect(edge.weight, equals(0));
    });

    test('should create graph edge with predefined weight', () {
      final startVertex = GraphVertex('A');
      final endVertex = GraphVertex('B');
      final edge = GraphEdge(startVertex: startVertex, endVertex: endVertex, weight: 10);

      expect(edge.startVertex, equals(startVertex));
      expect(edge.endVertex, equals(endVertex));
      expect(edge.weight, equals(10));
    });

    test('should be possible to do edge reverse', () {
      final vertexA = GraphVertex('A');
      final vertexB = GraphVertex('B');
      final edge = GraphEdge(startVertex: vertexA, endVertex: vertexB, weight: 10);

      expect(edge.startVertex, equals(vertexA));
      expect(edge.endVertex, equals(vertexB));
      expect(edge.weight, equals(10));

      edge.reverse();

      expect(edge.startVertex, equals(vertexB));
      expect(edge.endVertex, equals(vertexA));
      expect(edge.weight, equals(10));
    });
  });
}
