import 'package:algorithmia/data_structures/tree/avl_tree/avl_tree.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AvlTree', () {
    test('should do simple left-left rotation', () {
      final tree = AvlTree();

      tree.insert(4);
      tree.insert(3);
      tree.insert(2);

      expect(tree.toString(), equals('2,3,4'));
      expect(tree.root.value, equals(3));
      expect(tree.root.height, equals(1));

      tree.insert(1);

      expect(tree.toString(), equals('1,2,3,4'));
      expect(tree.root.value, equals(3));
      expect(tree.root.height, equals(2));

      tree.insert(0);

      expect(tree.toString(), equals('0,1,2,3,4'));
      expect(tree.root.value, equals(3));
      expect(tree.root.left?.value, equals(1));
      expect(tree.root.height, equals(2));
    });

    test('should do complex left-left rotation', () {
      final tree = AvlTree();

      tree.insert(30);
      tree.insert(20);
      tree.insert(40);
      tree.insert(10);

      expect(tree.root.value, equals(30));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('10,20,30,40'));

      tree.insert(25);
      expect(tree.root.value, equals(30));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('10,20,25,30,40'));

      tree.insert(5);
      expect(tree.root.value, equals(20));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('5,10,20,25,30,40'));
    });

    test('should do simple right-right rotation', () {
      final tree = AvlTree();

      tree.insert(2);
      tree.insert(3);
      tree.insert(4);

      expect(tree.toString(), equals('2,3,4'));
      expect(tree.root.value, equals(3));
      expect(tree.root.height, equals(1));

      tree.insert(5);

      expect(tree.toString(), equals('2,3,4,5'));
      expect(tree.root.value, equals(3));
      expect(tree.root.height, equals(2));

      tree.insert(6);

      expect(tree.toString(), equals('2,3,4,5,6'));
      expect(tree.root.value, equals(3));
      expect(tree.root.right?.value, equals(5));
      expect(tree.root.height, equals(2));
    });

    test('should do complex right-right rotation', () {
      final tree = AvlTree();

      tree.insert(30);
      tree.insert(20);
      tree.insert(40);
      tree.insert(50);

      expect(tree.root.value, equals(30));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('20,30,40,50'));

      tree.insert(35);
      expect(tree.root.value, equals(30));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('20,30,35,40,50'));

      tree.insert(55);
      expect(tree.root.value, equals(40));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('20,30,35,40,50,55'));
    });

    test('should do left-right rotation', () {
      final tree = AvlTree();

      tree.insert(30);
      tree.insert(20);
      tree.insert(25);

      expect(tree.root.height, equals(1));
      expect(tree.root.value, equals(25));
      expect(tree.toString(), equals('20,25,30'));
    });

    test('should do right-left rotation', () {
      final tree = AvlTree();

      tree.insert(30);
      tree.insert(40);
      tree.insert(35);

      expect(tree.root.height, equals(1));
      expect(tree.root.value, equals(35));
      expect(tree.toString(), equals('30,35,40'));
    });

    test('should create balanced tree: case #1', () {
      // @see: https://www.youtube.com/watch?v=rbg7Qf8GkQ4&t=839s
      final tree = AvlTree();

      tree.insert(1);
      tree.insert(2);
      tree.insert(3);

      expect(tree.root.value, equals(2));
      expect(tree.root.height, equals(1));
      expect(tree.toString(), equals('1,2,3'));

      tree.insert(6);

      expect(tree.root.value, equals(2));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('1,2,3,6'));

      tree.insert(15);

      expect(tree.root.value, equals(2));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('1,2,3,6,15'));

      tree.insert(-2);

      expect(tree.root.value, equals(2));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('-2,1,2,3,6,15'));

      tree.insert(-5);

      expect(tree.root.value, equals(2));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('-5,-2,1,2,3,6,15'));

      tree.insert(-8);

      expect(tree.root.value, equals(2));
      expect(tree.root.height, equals(3));
      expect(tree.toString(), equals('-8,-5,-2,1,2,3,6,15'));
    });

    test('should create balanced tree: case #2', () {
      // @see https://www.youtube.com/watch?v=7m94k2Qhg68
      final tree = AvlTree();

      tree.insert(43);
      tree.insert(18);
      tree.insert(22);
      tree.insert(9);
      tree.insert(21);
      tree.insert(6);

      expect(tree.root.value, equals(18));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('6,9,18,21,22,43'));

      tree.insert(8);

      expect(tree.root.value, equals(18));
      expect(tree.root.height, equals(2));
      expect(tree.toString(), equals('6,8,9,18,21,22,43'));
    });

    test('should do left right rotation and keeping left right node safe: case #1', () {
      final tree = AvlTree();

      tree.insert(30);
      tree.insert(15);
      tree.insert(40);
      tree.insert(10);
      tree.insert(18);
      tree.insert(35);
      tree.insert(45);
      tree.insert(5);
      tree.insert(12);

      expect(tree.toString(), equals('5,10,12,15,18,30,35,40,45'));
      expect(tree.root.height, equals(3));

      tree.insert(11);

      expect(tree.toString(), equals('5,10,11,12,15,18,30,35,40,45'));
      expect(tree.root.height, equals(3));
    });

    test('should do left right rotation and keeping left right node safe: case #2', () {
      final tree = AvlTree();

      tree.insert(30);
      tree.insert(15);
      tree.insert(40);
      tree.insert(10);
      tree.insert(18);
      tree.insert(35);
      tree.insert(45);
      tree.insert(42);
      tree.insert(47);

      expect(tree.toString(), equals('10,15,18,30,35,40,42,45,47'));
      expect(tree.root.height, equals(3));

      tree.insert(43);

      expect(tree.toString(), equals('10,15,18,30,35,40,42,43,45,47'));
      expect(tree.root.height, equals(3));
    });

    test('should remove values from the tree with right-right rotation', () {
      final tree = AvlTree();

      tree.insert(10);
      tree.insert(20);
      tree.insert(30);
      tree.insert(40);

      expect(tree.toString(), equals('10,20,30,40'));

      tree.remove(10);

      expect(tree.toString(), equals('20,30,40'));
      expect(tree.root.value, equals(30));
      expect(tree.root.left?.value, equals(20));
      expect(tree.root.right?.value, equals(40));
      expect(tree.root.balanceFactor, equals(0));
    });

    test('should remove values from the tree with left-left rotation', () {
      final tree = AvlTree();

      tree.insert(10);
      tree.insert(20);
      tree.insert(30);
      tree.insert(5);

      expect(tree.toString(), equals('5,10,20,30'));

      tree.remove(30);

      expect(tree.toString(), equals('5,10,20'));
      expect(tree.root.value, equals(10));
      expect(tree.root.left?.value, equals(5));
      expect(tree.root.right?.value, equals(20));
      expect(tree.root.balanceFactor, equals(0));
    });

    test('should keep balance after removal', () {
      final tree = AvlTree();

      tree.insert(1);
      tree.insert(2);
      tree.insert(3);
      tree.insert(4);
      tree.insert(5);
      tree.insert(6);
      tree.insert(7);
      tree.insert(8);
      tree.insert(9);

      expect(tree.toString(), equals('1,2,3,4,5,6,7,8,9'));
      expect(tree.root.value, equals(4));
      expect(tree.root.height, equals(3));
      expect(tree.root.balanceFactor, equals(-1));

      tree.remove(8);

      expect(tree.root.value, equals(4));
      expect(tree.root.balanceFactor, equals(-1));

      tree.remove(9);

      expect(tree.contains(8), isFalse);
      expect(tree.contains(9), isFalse);
      expect(tree.toString(), equals('1,2,3,4,5,6,7'));
      expect(tree.root.value, equals(4));
      expect(tree.root.height, equals(2));
      expect(tree.root.balanceFactor, equals(0));
    });
  });
}
