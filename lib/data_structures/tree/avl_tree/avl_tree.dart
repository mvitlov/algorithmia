import 'package:algorithmia/data_structures/tree/binary_search_tree/binary_search_tree.dart';
import 'package:algorithmia/data_structures/tree/binary_search_tree/binary_search_tree_node.dart';

class AvlTree<T> extends BinarySearchTree<T, dynamic> {
  @override
  BinarySearchTreeNode<T, dynamic> insert(T value) {
    // Do the normal BST insert.
    var result = super.insert(value);

    // Let's move up to the root and check balance factors along the way.
    var currentNode = root.find(value);
    while (currentNode != null) {
      balance(currentNode);
      currentNode = currentNode.parent;
    }
    return result;
  }

  @override
  bool remove(T value) {
    // Do standard BST removal.
    final result = super.remove(value);

    // Balance the tree starting from the root node.
    balance(root);

    return result;
  }

  void balance(BinarySearchTreeNode<T, dynamic> node) {
    // If balance factor is not OK then try to balance the node.
    if (node.balanceFactor > 1) {
      // Left rotation.
      if (node.left!.balanceFactor > 0) {
        // Left-Left rotation
        rotateLeftLeft(node);
      } else if (node.left!.balanceFactor < 0) {
        // Left-Right rotation.
        rotateLeftRight(node);
      }
    } else if (node.balanceFactor < -1) {
      // Right rotation.
      if (node.right!.balanceFactor < 0) {
        // Right-Right rotation
        rotateRightRight(node);
      } else if (node.right!.balanceFactor > 0) {
        // Right-Left rotation.
        rotateRightLeft(node);
      }
    }
  }

  void rotateLeftLeft(BinarySearchTreeNode<T, dynamic> rootNode) {
    // Detach left node from root node.
    final leftNode = rootNode.left;
    rootNode.setLeft(null);

    // Make left node to be a child of rootNode's parent.
    if (rootNode.parent != null) {
      rootNode.parent?.setLeft(leftNode);
    } else if (rootNode == root) {
      // If root node is root then make left node to be a new root.
      root = leftNode ?? BinarySearchTreeNode(null);
    }

    // If left node has a right child then detach it and
    // attach it as a left child for rootNode.
    if (leftNode?.right != null) {
      rootNode.setLeft(leftNode?.right);
    }

    // Attach rootNode to the right of leftNode.
    leftNode?.setRight(rootNode);
  }

  void rotateLeftRight(BinarySearchTreeNode<T, dynamic> rootNode) {
    // Detach left node from rootNode since it is going to be replaced.
    final leftNode = rootNode.left;
    rootNode.setLeft(null);

    // Detach right node from leftNode.
    final leftRightNode = leftNode?.right;
    leftNode?.setRight(null);

    // Preserve leftRightNode's left subtree.
    if (leftRightNode?.left != null) {
      leftNode?.setRight(leftRightNode?.left);
      leftRightNode?.setLeft(null);
    }

    // Attach leftRightNode to the rootNode.
    rootNode.setLeft(leftRightNode);

    // Attach leftNode as left node for leftRight node.
    leftRightNode?.setLeft(leftNode);

    // Do left-left rotation.
    rotateLeftLeft(rootNode);
  }

  void rotateRightLeft(BinarySearchTreeNode<T, dynamic> rootNode) {
    // Detach right node from rootNode since it is going to be replaced.
    final rightNode = rootNode.right;
    rootNode.setRight(null);

    // Detach left node from rightNode.
    final rightLeftNode = rightNode?.left;
    rightNode?.setLeft(null);

    if (rightLeftNode?.right != null) {
      rightNode?.setLeft(rightLeftNode?.right);
      rightLeftNode?.setRight(null);
    }

    // Attach rightLeftNode to the rootNode.
    rootNode.setRight(rightLeftNode);

    // Attach rightNode as right node for rightLeft node.
    rightLeftNode?.setRight(rightNode);

    // Do right-right rotation.
    rotateRightRight(rootNode);
  }

  void rotateRightRight(BinarySearchTreeNode<T, dynamic> rootNode) {
    // Detach right node from root node.
    final rightNode = rootNode.right;
    rootNode.setRight(null);

    // Make right node to be a child of rootNode's parent.
    if (rootNode.parent != null) {
      rootNode.parent!.setRight(rightNode);
    } else if (rootNode == root) {
      // If root node is root then make right node to be a new root.
      root = rightNode ?? BinarySearchTreeNode(null);
    }

    // If right node has a left child then detach it and
    // attach it as a right child for rootNode.
    if (rightNode?.left != null) {
      rootNode.setRight(rightNode?.left);
    }

    // Attach rootNode to the left of rightNode.
    rightNode?.setLeft(rootNode);
  }
}
