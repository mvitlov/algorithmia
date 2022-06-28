import 'package:algorithmia/data_structures/heap/min_heap.dart';
import 'package:algorithmia/utils/comparator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MinHeap', () {
    test('should create an empty min heap', () {
      final minHeap = MinHeap<int>();

      expect(minHeap, isNotNull);
      expect(minHeap.peek(), isNull);
      expect(minHeap.isEmpty(), isTrue);
    });

    test('should add items to the heap and heapify it up', () {
      final minHeap = MinHeap<int>();

      minHeap.add(5);
      expect(minHeap.isEmpty(), isFalse);
      expect(minHeap.peek(), equals(5));
      expect(minHeap.toString(), equals('5'));

      minHeap.add(3);
      expect(minHeap.peek(), equals(3));
      expect(minHeap.toString(), equals('3,5'));

      minHeap.add(10);
      expect(minHeap.peek(), equals(3));
      expect(minHeap.toString(), equals('3,5,10'));

      minHeap.add(1);
      expect(minHeap.peek(), equals(1));
      expect(minHeap.toString(), equals('1,3,10,5'));

      minHeap.add(1);
      expect(minHeap.peek(), equals(1));
      expect(minHeap.toString(), equals('1,1,10,5,3'));

      expect(minHeap.poll(), equals(1));
      expect(minHeap.toString(), equals('1,3,10,5'));

      expect(minHeap.poll(), equals(1));
      expect(minHeap.toString(), equals('3,5,10'));

      expect(minHeap.poll(), equals(3));
      expect(minHeap.toString(), equals('5,10'));
    });

    test('should poll items from the heap and heapify it down', () {
      final minHeap = MinHeap<int>();

      minHeap.add(5);
      minHeap.add(3);
      minHeap.add(10);
      minHeap.add(11);
      minHeap.add(1);

      expect(minHeap.toString(), equals('1,3,10,11,5'));

      expect(minHeap.poll(), equals(1));
      expect(minHeap.toString(), equals('3,5,10,11'));

      expect(minHeap.poll(), equals(3));
      expect(minHeap.toString(), equals('5,11,10'));

      expect(minHeap.poll(), equals(5));
      expect(minHeap.toString(), equals('10,11'));

      expect(minHeap.poll(), equals(10));
      expect(minHeap.toString(), equals('11'));

      expect(minHeap.poll(), equals(11));
      expect(minHeap.toString(), equals(''));

      expect(minHeap.poll(), isNull);
      expect(minHeap.toString(), equals(''));
    });

    test('should heapify down through the right branch as well', () {
      final minHeap = MinHeap();

      minHeap.add(3);
      minHeap.add(12);
      minHeap.add(10);

      expect(minHeap.toString(), equals('3,12,10'));

      minHeap.add(11);
      expect(minHeap.toString(), equals('3,11,10,12'));

      expect(minHeap.poll(), equals(3));
      expect(minHeap.toString(), equals('10,11,12'));
    });

    test('should be possible to find item indices in heap', () {
      final minHeap = MinHeap<int>();

      minHeap.add(3);
      minHeap.add(12);
      minHeap.add(10);
      minHeap.add(11);
      minHeap.add(11);

      expect(minHeap.toString(), equals('3,11,10,12,11'));

      expect(minHeap.find(5), equals([]));
      expect(minHeap.find(3), equals([0]));
      expect(minHeap.find(11), equals([1, 4]));
    });

    test('should be possible to remove items from heap with heapify down', () {
      final minHeap = MinHeap<int>();

      minHeap.add(3);
      minHeap.add(12);
      minHeap.add(10);
      minHeap.add(11);
      minHeap.add(11);

      expect(minHeap.toString(), equals('3,11,10,12,11'));

      expect(minHeap.remove(3).toString(), equals('10,11,11,12'));
      expect(minHeap.remove(3).peek(), equals(10));
      expect(minHeap.remove(11).toString(), equals('10,12'));
      expect(minHeap.remove(3).peek(), equals(10));
    });

    test('should be possible to remove items from heap with heapify up', () {
      final minHeap = MinHeap<int>();

      minHeap.add(3);
      minHeap.add(10);
      minHeap.add(5);
      minHeap.add(6);
      minHeap.add(7);
      minHeap.add(4);
      minHeap.add(6);
      minHeap.add(8);
      minHeap.add(2);
      minHeap.add(1);

      expect(minHeap.toString(), equals('1,2,4,6,3,5,6,10,8,7'));
      expect(minHeap.remove(8).toString(), equals('1,2,4,6,3,5,6,10,7'));
      expect(minHeap.remove(7).toString(), equals('1,2,4,6,3,5,6,10'));
      expect(minHeap.remove(1).toString(), equals('2,3,4,6,10,5,6'));
      expect(minHeap.remove(2).toString(), equals('3,6,4,6,10,5'));
      expect(minHeap.remove(6).toString(), equals('3,5,4,10'));
      expect(minHeap.remove(10).toString(), equals('3,5,4'));
      expect(minHeap.remove(5).toString(), equals('3,4'));
      expect(minHeap.remove(3).toString(), equals('4'));
      expect(minHeap.remove(4).toString(), equals(''));
    });

    test('should be possible to remove items from heap with custom finding comparator', () {
      final minHeap = MinHeap<String>();
      minHeap.add('dddd');
      minHeap.add('ccc');
      minHeap.add('bb');
      minHeap.add('a');

      expect(minHeap.toString(), equals('a,bb,ccc,dddd'));

      final comparator = Comparator<String>((String a, String b) {
        if (a.length == b.length) {
          return 0;
        }

        return a.length < b.length ? -1 : 1;
      });

      minHeap.remove('hey', comparator);
      expect(minHeap.toString(), equals('a,bb,dddd'));
    });

    test('should remove values from heap and correctly re-order the tree', () {
      final minHeap = MinHeap<int>();

      minHeap.add(1);
      minHeap.add(2);
      minHeap.add(3);
      minHeap.add(4);
      minHeap.add(5);
      minHeap.add(6);
      minHeap.add(7);
      minHeap.add(8);
      minHeap.add(9);

      expect(minHeap.toString(), equals('1,2,3,4,5,6,7,8,9'));

      minHeap.remove(2);
      expect(minHeap.toString(), equals('1,4,3,8,5,6,7,9'));

      minHeap.remove(4);
      expect(minHeap.toString(), equals('1,5,3,8,9,6,7'));
    });
  });
}
