import 'package:algorithmia/data_structures/graph/graph_edge.dart';
import 'package:algorithmia/data_structures/linked_list/linked_list.dart';
import 'package:algorithmia/data_structures/linked_list/linked_list_node.dart';

class GraphVertex<T> {
  final T value;
  late final LinkedList<GraphEdge<T>> edges;
  GraphVertex(this.value) {
    edgeComparator(GraphEdge<T> edgeA, GraphEdge<T> edgeB) {
      if (edgeA.getKey() == edgeB.getKey()) {
        return 0;
      }

      return edgeA.getKey().compareTo(edgeB.getKey());
    }

    // Normally you would store string value like vertex name.
    // But generally it may be any object as well
    edges = LinkedList(edgeComparator);
  }

  GraphVertex<T> addEdge(GraphEdge<T> edge) {
    edges.append(edge);

    return this;
  }

  void deleteEdge(GraphEdge<T> edge) {
    edges.delete(edge);
  }

  List<GraphVertex<T>> getNeighbors() {
    final edges = this.edges.toArray();

    GraphVertex<T> neighborsConverter(LinkedListNode<GraphEdge<T>> node) {
      return node.value.startVertex == this ? node.value.endVertex : node.value.startVertex;
    }

    // Return either start or end vertex.
    // For undirected graphs it is possible that current vertex will be the end one.
    return edges.map(neighborsConverter).toList();
  }

  List<GraphEdge<T>> getEdges() {
    return edges.toArray().map((linkedListNode) => linkedListNode.value).toList();
  }

  int getDegree() {
    return edges.toArray().length;
  }

  bool hasEdge(GraphEdge<T> requiredEdge) {
    LinkedListNode<GraphEdge<T>>? edgeNode = edges.find(
      callback: (edge) => edge == requiredEdge,
    );

    return edgeNode != null;
  }

  bool hasNeighbor(GraphVertex<T> vertex) {
    LinkedListNode<GraphEdge<T>>? vertexNode = edges.find(
      callback: (edge) => edge.startVertex == vertex || edge.endVertex == vertex,
    );

    return vertexNode != null;
  }

  GraphEdge<T>? findEdge(GraphVertex<T> vertex) {
    bool edgeFinder(GraphEdge<T> edge) {
      return edge.startVertex == vertex || edge.endVertex == vertex;
    }

    return edges.find(callback: edgeFinder)?.value;
  }

  String getKey([String Function(T value)? keyCallback]) {
    return toString(keyCallback);
  }

  GraphVertex<T> deleteAllEdges() {
    getEdges().forEach((edge) => deleteEdge(edge));
    return this;
  }

  @override
  String toString([String Function(T value)? callback]) {
    return callback != null ? callback(value) : '$value';
  }
}
