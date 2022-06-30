import 'package:algorithmia/data_structures/graph/graph_edge.dart';
import 'package:algorithmia/data_structures/graph/graph_vertex.dart';

class Graph<T> {
  final bool isDirected;
  late final Map<String, GraphVertex<T>> vertices;
  late final Map<String, GraphEdge<T>> edges;
  Graph({this.isDirected = false}) {
    vertices = {};
    edges = {};
  }

  Graph<T> addVertex(GraphVertex<T> newVertex) {
    vertices[newVertex.getKey()] = newVertex;
    return this;
  }

  GraphVertex<T>? getVertexByKey(String vertexKey) {
    return vertices[vertexKey];
  }

  List<GraphVertex<T>> getNeighbors(GraphVertex<T> vertex) {
    return vertex.getNeighbors();
  }

  List<GraphVertex<T>> getAllVertices() {
    return vertices.values.toList();
  }

  List<GraphEdge<T>> getAllEdges() {
    return edges.values.toList();
  }

  Graph<T> addEdge(GraphEdge<T> edge) {
    // Try to find and end start vertices.
    var startVertex = getVertexByKey(edge.startVertex.getKey());
    var endVertex = getVertexByKey(edge.endVertex.getKey());

    // Insert start vertex if it wasn't inserted.
    if (startVertex == null) {
      addVertex(edge.startVertex);
      startVertex = getVertexByKey(edge.startVertex.getKey());
    }

    // Insert end vertex if it wasn't inserted.
    if (endVertex == null) {
      addVertex(edge.endVertex);
      endVertex = getVertexByKey(edge.endVertex.getKey());
    }

    // Check if edge has been already added.
    if (edges.containsKey(edge.getKey())) {
      throw Exception('Edge has already been added before');
    } else {
      edges[edge.getKey()] = edge;
    }

    // Add edge to the vertices.
    if (isDirected) {
      // If graph IS directed then add the edge only to start vertex.
      startVertex!.addEdge(edge);
    } else {
      // If graph ISN'T directed then add the edge to both vertices.
      startVertex!.addEdge(edge);
      endVertex!.addEdge(edge);
    }

    return this;
  }

  void deleteEdge(GraphEdge<T> edge) {
    // Delete edge from the list of edges.
    if (edges.containsKey(edge.getKey())) {
      edges.remove(edge.getKey());
    } else {
      throw Exception('Edge not found in graph');
    }

    // Try to find and end start vertices and delete edge from them.
    final startVertex = getVertexByKey(edge.startVertex.getKey());
    final endVertex = getVertexByKey(edge.endVertex.getKey());

    startVertex?.deleteEdge(edge);
    endVertex?.deleteEdge(edge);
  }

  GraphEdge<T>? findEdge(GraphVertex<T> startVertex, GraphVertex<T> endVertex) {
    final vertex = getVertexByKey(startVertex.getKey());

    return vertex?.findEdge(endVertex);
  }

  int getWeight() {
    return getAllEdges().fold<int>(0, (weight, graphEdge) => weight + graphEdge.weight);
  }

  Graph<T> reverse() {
    getAllEdges().forEach((edge) {
      // Delete straight edge from graph and from vertices.
      deleteEdge(edge);

      // Reverse the edge.
      edge.reverse();

      // Add reversed edge back to the graph and its vertices.
      addEdge(edge);
    });

    return this;
  }

  Map<String, int> getVerticesIndices() {
    final verticesIndices = <String, int>{};
    var index = 0;
    getAllVertices().forEach((vertex) {
      verticesIndices[vertex.getKey()] = index;
      index++;
    });

    return verticesIndices;
  }

  List<List<int?>> getAdjacencyMatrix() {
    final vertices = getAllVertices();
    final verticesIndices = getVerticesIndices();

    // Init matrix with infinities meaning that there is no ways of
    // getting from one vertex to another yet.
    /* final adjacencyMatrix =      Array(vertices.length).fill(null).map(() => {
      return Array(vertices.length).fill(Infinity);
    }); */

    // List<List<int?>> adjacencyMatrix =
    //     List.filled(vertices.length, null).map((_) => List.filled(vertices.length, null)).toList();

    final List<List<int?>> adjacencyMatrix =
        List.generate(vertices.length, (_) => List.generate(vertices.length, (_) => null));

    // Fill the columns.
    var vertexIndex = 0;
    for (var vertex in vertices) {
      vertex.getNeighbors().forEach((neighbor) {
        final neighborIndex = verticesIndices[neighbor.getKey()]!;
        adjacencyMatrix[vertexIndex][neighborIndex] = findEdge(vertex, neighbor)!.weight;
      });
      vertexIndex++;
    }

    return adjacencyMatrix;
  }

  @override
  String toString() {
    return vertices.keys.join(',');
  }
}
