import 'dart:math';

import 'package:algorithmia/data_structures/hash_table/hash_table.dart';
import 'package:algorithmia/utils/comparator.dart';

class BinarySearchTreeNode<T, M> {
  T? value;
  BinarySearchTreeNode<T, M>? left;
  BinarySearchTreeNode<T, M>? right;
  BinarySearchTreeNode<T, M>? parent;

  final CompareFunction<T>? compareFunction;

  late final Comparator<T> nodeValueComparator;
  late final HashTable<M> meta;

  BinarySearchTreeNode(this.value, {this.compareFunction}) {
    meta = HashTable<M>();
    nodeValueComparator = Comparator(compareFunction);
  }

  BinarySearchTreeNode<T, M> insert(T value) {
    if (this.value == null) {
      this.value = value;

      return this;
    }

    if (nodeValueComparator.lessThan(value, this.value as T)) {
      // Insert to the left.
      if (left != null) {
        return left!.insert(value);
      }

      final newNode = BinarySearchTreeNode<T, M>(value, compareFunction: compareFunction);
      setLeft(newNode);

      return newNode;
    }

    if (nodeValueComparator.greaterThan(value, this.value as T)) {
      // Insert to the right.
      if (right != null) {
        return right!.insert(value);
      }

      final newNode = BinarySearchTreeNode<T, M>(value, compareFunction: compareFunction);
      setRight(newNode);

      return newNode;
    }

    return this;
  }

  BinarySearchTreeNode<T, M>? find(T value) {
    // Check the root.
    if (this.value == value) {
      return this;
    }

    if (nodeValueComparator.lessThan(value, this.value as T) && left != null) {
      // Check left nodes.
      return left!.find(value);
    }

    if (nodeValueComparator.greaterThan(value, this.value as T) && right != null) {
      // Check right nodes.
      return right!.find(value);
    }

    return null;
  }

  bool contains(T value) {
    return find(value) != null;
  }

  remove(T value) {
    final nodeToRemove = find(value);

    if (nodeToRemove == null) {
      throw Exception('Item not found in the tree');
    }

    final parent = nodeToRemove.parent;

    if (nodeToRemove.left == null && nodeToRemove.right == null) {
      // Node is a leaf and thus has no children.
      if (parent != null) {
        // Node has a parent. Just remove the pointer to this node from the parent.
        parent.removeChild(nodeToRemove);
      } else {
        // Node has no parent. Just erase current node value.
        nodeToRemove.setValue(null);
      }
    } else if (nodeToRemove.left != null && nodeToRemove.right != null) {
      // Node has two children.
      // Find the next biggest value (minimum value in the right branch)
      // and replace current value node with that next biggest value.
      final nextBiggerNode = nodeToRemove.right!.findMin();

      if (nextBiggerNode != nodeToRemove.right) {
        remove(nextBiggerNode.value as T);
        nodeToRemove.setValue(nextBiggerNode.value);
      } else {
        // In case if next right value is the next bigger one and it doesn't have left child
        // then just replace node that is going to be deleted with the right node.
        nodeToRemove.setValue(nodeToRemove.right!.value);
        nodeToRemove.setRight(nodeToRemove.right!.right);
      }
    } else {
      // Node has only one child.
      // Make this child to be a direct child of current node's parent.
      /** @var BinarySearchTreeNode */
      final childNode = nodeToRemove.left ?? nodeToRemove.right;

      if (parent != null) {
        parent.replaceChild(nodeToRemove, childNode);
      } else {
        BinarySearchTreeNode.copyNode(childNode!, nodeToRemove);
      }
    }

    // Clear the parent of removed node.
    nodeToRemove.parent = null;

    return true;
  }

  BinarySearchTreeNode<T, M> findMin() {
    if (left == null) {
      return this;
    }

    return left!.findMin();
  }

/* 

 */

  BinarySearchTreeNode<T, M> setLeft(BinarySearchTreeNode<T, M>? node) {
    // Reset parent for left node since it is going to be detached.
    if (left != null) {
      left!.parent = null;
    }

    // Attach new node to the left.
    left = node;

    // Make current node to be a parent for new left one.
    if (left != null) {
      left!.parent = this;
    }

    return this;
  }

  BinarySearchTreeNode<T, M> setRight(BinarySearchTreeNode<T, M>? node) {
    // Reset parent for right node since it is going to be detached.
    if (right != null) {
      right!.parent = null;
    }

    // Attach new node to the right.
    right = node;

    // Make current node to be a parent for new right one.
    if (right != null) {
      right!.parent = this;
    }

    return this;
  }

  bool removeChild(BinarySearchTreeNode<T, M> nodeToRemove) {
    if (left != null && left == nodeToRemove) {
      left = null;
      return true;
    }

    if (right != null && right == nodeToRemove) {
      right = null;
      return true;
    }

    return false;
  }

  bool replaceChild(BinarySearchTreeNode<T, M>? nodeToReplace, BinarySearchTreeNode<T, M>? replacementNode) {
    if (nodeToReplace == null || replacementNode == null) {
      return false;
    }

    if (left != null && left == nodeToReplace) {
      left = replacementNode;
      return true;
    }

    if (right != null && right == nodeToReplace) {
      right = replacementNode;
      return true;
    }

    return false;
  }

  BinarySearchTreeNode<T, M> setValue(T? value) {
    this.value = value;
    return this;
  }

  static void copyNode<B, C>(BinarySearchTreeNode<B, C> sourceNode, BinarySearchTreeNode<B, C> targetNode) {
    targetNode.setValue(sourceNode.value);
    targetNode.setLeft(sourceNode.left);
    targetNode.setRight(sourceNode.right);
  }

  List<T> traverseInOrder() {
    var traverse = <T>[];

    // Add left node.
    if (left != null) {
      traverse = [...traverse, ...left!.traverseInOrder()];
    }

    // Add root.

    if (value != null) {
      traverse.add(value as T);
    }

    // Add right node.
    if (right != null) {
      traverse = [...traverse, ...right!.traverseInOrder()];
    }

    return traverse;
  }

  int get leftHeight {
    if (left == null) {
      return 0;
    }

    return left!.height + 1;
  }

  int get rightHeight {
    if (right == null) {
      return 0;
    }

    return right!.height + 1;
  }

  int get height {
    return max(leftHeight, rightHeight);
  }

  int get balanceFactor {
    return leftHeight - rightHeight;
  }

  @override
  String toString([String Function(T value)? callback]) {
    return callback != null ? traverseInOrder().map(callback).join(',') : traverseInOrder().join(',');
  }
}
