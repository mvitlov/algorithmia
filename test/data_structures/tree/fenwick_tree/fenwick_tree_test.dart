import 'package:algorithmia/data_structures/tree/fenwick_tree/fenwick_tree.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FenwickTree', () {
    test('should create empty fenwick tree of correct size', () {
      final tree1 = FenwickTree(5);
      expect(tree1.length, equals(5 + 1));

      for (var i = 0; i < 5; i += 1) {
        expect(tree1.valueAt(i), equals(0));
      }

      final tree2 = FenwickTree(50);
      expect(tree2.length, equals(50 + 1));
    });

    test('should create correct fenwick tree', () {
      const inputArray = [3, 2, -1, 6, 5, 4, -3, 3, 7, 2, 3];

      final tree = FenwickTree(inputArray.length);
      expect(tree.length, equals(inputArray.length + 1));

      var index = 0;
      for (var value in inputArray) {
        tree.increase(index + 1, value);
        index++;
      }

      expect(tree.values, equals([0, 3, 5, -1, 10, 5, 9, -3, 19, 7, 9, 3]));

      expect(tree.query(1), equals(3));
      expect(tree.query(2), equals(5));
      expect(tree.query(3), equals(4));
      expect(tree.query(4), equals(10));
      expect(tree.query(5), equals(15));
      expect(tree.query(6), equals(19));
      expect(tree.query(7), equals(16));
      expect(tree.query(8), equals(19));
      expect(tree.query(9), equals(26));
      expect(tree.query(10), equals(28));
      expect(tree.query(11), equals(31));

      expect(tree.queryRange(1, 1), equals(3));
      expect(tree.queryRange(1, 2), equals(5));
      expect(tree.queryRange(2, 4), equals(7));
      expect(tree.queryRange(6, 9), equals(11));

      tree.increase(3, 1);

      expect(tree.query(1), equals(3));
      expect(tree.query(2), equals(5));
      expect(tree.query(3), equals(5));
      expect(tree.query(4), equals(11));
      expect(tree.query(5), equals(16));
      expect(tree.query(6), equals(20));
      expect(tree.query(7), equals(17));
      expect(tree.query(8), equals(20));
      expect(tree.query(9), equals(27));
      expect(tree.query(10), equals(29));
      expect(tree.query(11), equals(32));

      expect(tree.queryRange(1, 1), equals(3));
      expect(tree.queryRange(1, 2), equals(5));
      expect(tree.queryRange(2, 4), equals(8));
      expect(tree.queryRange(6, 9), equals(11));
    });

    test('should correctly execute queries', () {
      final tree = FenwickTree(5);

      tree.increase(1, 4);
      tree.increase(3, 7);

      expect(tree.query(1), equals(4));
      expect(tree.query(3), equals(11));
      expect(tree.query(5), equals(11));
      expect(tree.queryRange(2, 3), equals(7));

      tree.increase(2, 5);
      expect(tree.query(5), equals(16));

      tree.increase(1, 3);
      expect(tree.queryRange(1, 1), equals(7));
      expect(tree.query(5), equals(19));
      expect(tree.queryRange(1, 5), equals(19));
    });

    test('should throw exceptions', () {
      final tree = FenwickTree(5);

      increaseAtInvalidLowIndex() {
        tree.increase(0, 1);
      }

      increaseAtInvalidHighIndex() {
        tree.increase(10, 1);
      }

      queryInvalidLowIndex() {
        tree.query(0);
      }

      queryInvalidHighIndex() {
        tree.query(10);
      }

      rangeQueryInvalidIndex() {
        tree.queryRange(3, 2);
      }

      expect(increaseAtInvalidLowIndex, throwsException);
      expect(increaseAtInvalidHighIndex, throwsException);
      expect(queryInvalidLowIndex, throwsException);
      expect(queryInvalidHighIndex, throwsException);
      expect(rangeQueryInvalidIndex, throwsException);
    });
  });
}
