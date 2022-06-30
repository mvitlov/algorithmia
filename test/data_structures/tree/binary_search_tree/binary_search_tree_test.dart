import 'package:algorithmia/data_structures/tree/binary_search_tree/binary_search_tree.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BinarySearchTree', () {
    test('should create binary search tree', () {
      final bst = BinarySearchTree();

      expect(bst, isNotNull);
      expect(bst.root, isNotNull);
      expect(bst.root.value, isNull);
      expect(bst.root.left, isNull);
      expect(bst.root.right, isNull);
    });

    test('should insert values', () {
      final bst = BinarySearchTree<int, String>();

      final insertedNode1 = bst.insert(10);
      final insertedNode2 = bst.insert(20);
      bst.insert(5);

      expect(bst.toString(), equals('5,10,20'));
      expect(insertedNode1.value, equals(10));
      expect(insertedNode2.value, equals(20));
    });

    test('should check if value exists', () {
      final bst = BinarySearchTree();

      bst.insert(10);
      bst.insert(20);
      bst.insert(5);

      expect(bst.contains(20), isTrue);
      expect(bst.contains(40), isFalse);
    });

    test('should remove nodes', () {
      final bst = BinarySearchTree<int, String>();

      bst.insert(10);
      bst.insert(20);
      bst.insert(5);

      expect(bst.toString(), equals('5,10,20'));

      final removed1 = bst.remove(5);
      expect(bst.toString(), equals('10,20'));
      expect(removed1, isTrue);

      final removed2 = bst.remove(20);
      expect(bst.toString(), equals('10'));
      expect(removed2, isTrue);
    });

    test('should insert object values', () {
      int nodeValueCompareFunction(MapEntry<String, int> a, MapEntry<String, int> b) {
        if (a.value == b.value) {
          return 0;
        }

        return a.value < b.value ? -1 : 1;
      }

      const obj1 = MapEntry('obj1', 1);
      const obj2 = MapEntry('obj2', 2);
      const obj3 = MapEntry('obj3', 3);

      final bst = BinarySearchTree<MapEntry<String, int>, String>(nodeValueCompareFunction);

      bst.insert(obj2);
      bst.insert(obj3);
      bst.insert(obj1);

      expect(bst.toString((value) => value.key), equals('obj1,obj2,obj3'));
    });

    test('should be traversed to sorted array', () {
      final bst = BinarySearchTree<int, String>();

      bst.insert(10);
      bst.insert(-10);
      bst.insert(20);
      bst.insert(-20);
      bst.insert(25);
      bst.insert(6);

      expect(bst.toString(), equals('-20,-10,6,10,20,25'));
      expect(bst.root.height, equals(2));

      bst.insert(4);

      expect(bst.toString(), equals('-20,-10,4,6,10,20,25'));
      expect(bst.root.height, equals(3));
    });
  });
}
