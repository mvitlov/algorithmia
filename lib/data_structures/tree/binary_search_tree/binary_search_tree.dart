import 'package:algorithmia/data_structures/tree/binary_search_tree/binary_search_tree_node.dart';
import 'package:algorithmia/utils/comparator.dart';

class BinarySearchTree<T, M> {
  late BinarySearchTreeNode<T, M> root;
  late final Comparator<T> nodeComparator;
  BinarySearchTree([CompareFunction<T>? nodeValueCompareFunction]) {
    root = BinarySearchTreeNode(null, compareFunction: nodeValueCompareFunction);
    // Steal node comparator from the root.
    nodeComparator = root.nodeValueComparator;
  }

  BinarySearchTreeNode<T, M> insert(T value) {
    return root.insert(value);
  }

  bool contains(T value) {
    return root.contains(value);
  }

  bool remove(T value) {
    return root.remove(value);
  }

  @override
  String toString([String Function(T value)? callback]) {
    return root.toString(callback);
  }
}
