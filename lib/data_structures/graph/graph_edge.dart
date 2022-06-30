import 'graph_vertex.dart';

class GraphEdge<T> {
  GraphVertex<T> startVertex;
  GraphVertex<T> endVertex;
  int weight;
  GraphEdge({required this.startVertex, required this.endVertex, this.weight = 0});

  String getKey([String Function(T value)? keyCallback]) {
    final startVertexKey = startVertex.getKey(keyCallback);
    final endVertexKey = endVertex.getKey(keyCallback);
    return '${startVertexKey}_$endVertexKey';
  }

  GraphEdge<T> reverse() {
    final tmp = startVertex;
    startVertex = endVertex;
    endVertex = tmp;

    return this;
  }

  @override
  String toString() {
    return getKey();
  }
}
