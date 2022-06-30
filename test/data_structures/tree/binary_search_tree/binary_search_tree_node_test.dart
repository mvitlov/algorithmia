import 'package:algorithmia/data_structures/tree/binary_search_tree/binary_search_tree_node.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BinarySearchTreeNode', () {
    test('should create binary search tree', () {
      final bstNode = BinarySearchTreeNode(2);

      expect(bstNode.value, equals(2));
      expect(bstNode.left, isNull);
      expect(bstNode.right, isNull);
    });

    test('should insert in itself if it is empty', () {
      final bstNode = BinarySearchTreeNode<int, String>(null);
      bstNode.insert(1);

      expect(bstNode.value, equals(1));
      expect(bstNode.left, isNull);
      expect(bstNode.right, isNull);
    });

    test('should insert nodes in correct order', () {
      final bstNode = BinarySearchTreeNode(2);
      final insertedNode1 = bstNode.insert(1);

      expect(insertedNode1.value, equals(1));
      expect(bstNode.toString(), equals('1,2'));
      expect(bstNode.contains(1), isTrue);
      expect(bstNode.contains(3), isFalse);

      final insertedNode2 = bstNode.insert(3);

      expect(insertedNode2.value, equals(3));
      expect(bstNode.toString(), equals('1,2,3'));
      expect(bstNode.contains(3), isTrue);
      expect(bstNode.contains(4), isFalse);

      bstNode.insert(7);

      expect(bstNode.toString(), equals('1,2,3,7'));
      expect(bstNode.contains(7), isTrue);
      expect(bstNode.contains(8), isFalse);

      bstNode.insert(4);

      expect(bstNode.toString(), equals('1,2,3,4,7'));
      expect(bstNode.contains(4), isTrue);
      expect(bstNode.contains(8), isFalse);

      bstNode.insert(6);

      expect(bstNode.toString(), equals('1,2,3,4,6,7'));
      expect(bstNode.contains(6), isTrue);
      expect(bstNode.contains(8), isFalse);
    });

    test('should not insert duplicates', () {
      final bstNode = BinarySearchTreeNode(2);
      bstNode.insert(1);

      expect(bstNode.toString(), equals('1,2'));
      expect(bstNode.contains(1), isTrue);
      expect(bstNode.contains(3), isFalse);

      bstNode.insert(1);

      expect(bstNode.toString(), equals('1,2'));
      expect(bstNode.contains(1), isTrue);
      expect(bstNode.contains(3), isFalse);
    });

    test('should find min node', () {
      final node = BinarySearchTreeNode(10);

      node.insert(20);
      node.insert(30);
      node.insert(5);
      node.insert(40);
      node.insert(1);

      expect(node.findMin(), isNotNull);
      expect(node.findMin().value, equals(1));
    });

    test('should be possible to attach meta information to binary search tree nodes', () {
      final node = BinarySearchTreeNode<int, String>(10);

      node.insert(20);
      final node1 = node.insert(30);
      node.insert(5);
      node.insert(40);
      final node2 = node.insert(1);

      node.meta.set('color', 'red');
      node1.meta.set('color', 'black');
      node2.meta.set('color', 'white');

      expect(node.meta.get('color'), equals('red'));

      expect(node.findMin(), isNotNull);
      expect(node.findMin().value, equals(1));
      expect(node.findMin().meta.get('color'), equals('white'));
      expect(node.find(30)?.meta.get('color'), equals('black'));
    });

    test('should find node', () {
      final node = BinarySearchTreeNode(10);

      node.insert(20);
      node.insert(30);
      node.insert(5);
      node.insert(40);
      node.insert(1);

      expect(node.find(6), isNull);
      expect(node.find(5), isNotNull);
      expect(node.find(5)?.value, equals(5));
    });

    test('should remove leaf nodes', () {
      final bstRootNode = BinarySearchTreeNode<int, String>(null);

      bstRootNode.insert(10);
      bstRootNode.insert(20);
      bstRootNode.insert(5);

      expect(bstRootNode.toString(), equals('5,10,20'));

      final removed1 = bstRootNode.remove(5);
      expect(bstRootNode.toString(), equals('10,20'));
      expect(removed1, isTrue);

      final removed2 = bstRootNode.remove(20);
      expect(bstRootNode.toString(), equals('10'));
      expect(removed2, isTrue);
    });

    test('should remove nodes with one child', () {
      final bstRootNode = BinarySearchTreeNode<int, String>(null);

      bstRootNode.insert(10);
      bstRootNode.insert(20);
      bstRootNode.insert(5);
      bstRootNode.insert(30);

      expect(bstRootNode.toString(), equals('5,10,20,30'));

      bstRootNode.remove(20);
      expect(bstRootNode.toString(), equals('5,10,30'));

      bstRootNode.insert(1);
      expect(bstRootNode.toString(), equals('1,5,10,30'));

      bstRootNode.remove(5);
      expect(bstRootNode.toString(), equals('1,10,30'));
    });

    test('should remove nodes with two children', () {
      final bstRootNode = BinarySearchTreeNode<int, String>(null);

      bstRootNode.insert(10);
      bstRootNode.insert(20);
      bstRootNode.insert(5);
      bstRootNode.insert(30);
      bstRootNode.insert(15);
      bstRootNode.insert(25);

      expect(bstRootNode.toString(), equals('5,10,15,20,25,30'));
      expect(bstRootNode.find(20)?.left?.value, equals(15));
      expect(bstRootNode.find(20)?.right?.value, equals(30));

      bstRootNode.remove(20);
      expect(bstRootNode.toString(), equals('5,10,15,25,30'));

      bstRootNode.remove(15);
      expect(bstRootNode.toString(), equals('5,10,25,30'));

      bstRootNode.remove(10);
      expect(bstRootNode.toString(), equals('5,25,30'));
      expect(bstRootNode.value, equals(25));

      bstRootNode.remove(25);
      expect(bstRootNode.toString(), equals('5,30'));

      bstRootNode.remove(5);
      expect(bstRootNode.toString(), equals('30'));
    });

    test('should remove node with no parent', () {
      final bstRootNode = BinarySearchTreeNode<int, String>(null);
      expect(bstRootNode.toString(), equals(''));

      bstRootNode.insert(1);
      bstRootNode.insert(2);
      expect(bstRootNode.toString(), equals('1,2'));

      bstRootNode.remove(1);
      expect(bstRootNode.toString(), equals('2'));

      bstRootNode.remove(2);
      expect(bstRootNode.toString(), equals(''));
    });

    test('should throw error when trying to remove not existing node', () {
      final bstRootNode = BinarySearchTreeNode<int, String>(null);

      bstRootNode.insert(10);
      bstRootNode.insert(20);

      void removeNotExistingElementFromTree() {
        bstRootNode.remove(30);
      }

      expect(removeNotExistingElementFromTree, throwsException);
    });

    test('should be possible to use objects as node values', () {
      int nodeValueComparatorCallback(Map? a, Map? b) {
        final normalizedA = a ?? {'value': null};
        final normalizedB = b ?? {'value': null};

        if (normalizedA['value'] == normalizedB['value']) {
          return 0;
        }

        return normalizedA['value'] < normalizedB['value'] ? -1 : 1;
      }

      final obj1 = {'key': 'obj1', 'value': 1, 'toString': () => 'obj1'};
      final obj2 = {'key': 'obj2', 'value': 2, 'toString': () => 'obj2'};
      final obj3 = {'key': 'obj3', 'value': 3, 'toString': () => 'obj3'};

      final bstNode = BinarySearchTreeNode(obj2, compareFunction: nodeValueComparatorCallback);
      bstNode.insert(obj1);

      expect(bstNode.toString((value) => (value['toString'] as Function)()), equals('obj1,obj2'));
      expect(bstNode.contains(obj1), isTrue);
      expect(bstNode.contains(obj3), isFalse);

      bstNode.insert(obj3);

      expect(bstNode.toString((value) => (value['toString'] as Function)()), equals('obj1,obj2,obj3'));
      expect(bstNode.contains(obj3), isTrue);

      expect(bstNode.findMin().value, equals(obj1));
    });

    test('should abandon removed node', () {
      final rootNode = BinarySearchTreeNode('foo');
      rootNode.insert('bar');
      final childNode = rootNode.find('bar');
      rootNode.remove('bar');

      expect(childNode?.parent, isNull);
    });
  });
}
