import 'package:algorithmia/data_structures/heap/max_heap.dart';
import 'package:algorithmia/utils/comparator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MaxHeap', () {
    test('should create an empty max heap', () {
      final maxHeap = MaxHeap();

      expect(maxHeap, isNotNull);
      expect(maxHeap.peek(), isNull);
      expect(maxHeap.isEmpty(), isTrue);
    });

    test('should add items to the heap and heapify it up', () {
      final maxHeap = MaxHeap<int>();

      maxHeap.add(5);
      expect(maxHeap.isEmpty(), isFalse);
      expect(maxHeap.peek(), equals(5));
      expect(maxHeap.toString(), equals('5'));

      maxHeap.add(3);
      expect(maxHeap.peek(), equals(5));
      expect(maxHeap.toString(), equals('5,3'));

      maxHeap.add(10);
      expect(maxHeap.peek(), equals(10));
      expect(maxHeap.toString(), equals('10,3,5'));

      maxHeap.add(1);
      expect(maxHeap.peek(), equals(10));
      expect(maxHeap.toString(), equals('10,3,5,1'));

      maxHeap.add(1);
      expect(maxHeap.peek(), equals(10));
      expect(maxHeap.toString(), equals('10,3,5,1,1'));

      expect(maxHeap.poll(), equals(10));
      expect(maxHeap.toString(), equals('5,3,1,1'));

      expect(maxHeap.poll(), equals(5));
      expect(maxHeap.toString(), equals('3,1,1'));

      expect(maxHeap.poll(), equals(3));
      expect(maxHeap.toString(), equals('1,1'));
    });

    test('should poll items from the heap and heapify it down', () {
      final maxHeap = MaxHeap();

      maxHeap.add(5);
      maxHeap.add(3);
      maxHeap.add(10);
      maxHeap.add(11);
      maxHeap.add(1);

      expect(maxHeap.toString(), equals('11,10,5,3,1'));

      expect(maxHeap.poll(), equals(11));
      expect(maxHeap.toString(), equals('10,3,5,1'));

      expect(maxHeap.poll(), equals(10));
      expect(maxHeap.toString(), equals('5,3,1'));

      expect(maxHeap.poll(), equals(5));
      expect(maxHeap.toString(), equals('3,1'));

      expect(maxHeap.poll(), equals(3));
      expect(maxHeap.toString(), equals('1'));

      expect(maxHeap.poll(), equals(1));
      expect(maxHeap.toString(), equals(''));

      expect(maxHeap.poll(), isNull);
      expect(maxHeap.toString(), isEmpty);
    });

    test('should heapify down through the right branch as well', () {
      final maxHeap = MaxHeap();

      maxHeap.add(3);
      maxHeap.add(12);
      maxHeap.add(10);

      expect(maxHeap.toString(), equals('12,3,10'));

      maxHeap.add(11);
      expect(maxHeap.toString(), equals('12,11,10,3'));

      expect(maxHeap.poll(), equals(12));
      expect(maxHeap.toString(), equals('11,3,10'));
    });

    test('should be possible to find item indices in heap', () {
      final maxHeap = MaxHeap<int>();

      maxHeap.add(3);
      maxHeap.add(12);
      maxHeap.add(10);
      maxHeap.add(11);
      maxHeap.add(11);

      expect(maxHeap.toString(), equals('12,11,10,3,11'));

      expect(maxHeap.find(5), isEmpty);
      expect(maxHeap.find(12), equals([0]));
      expect(maxHeap.find(11), equals([1, 4]));
    });

    test('should be possible to remove items from heap with heapify down', () {
      final maxHeap = MaxHeap();

      maxHeap.add(3);
      maxHeap.add(12);
      maxHeap.add(10);
      maxHeap.add(11);
      maxHeap.add(11);

      expect(maxHeap.toString(), equals('12,11,10,3,11'));

      expect(maxHeap.remove(12).toString(), equals('11,11,10,3'));
      expect(maxHeap.remove(12).peek(), equals(11));
      expect(maxHeap.remove(11).toString(), equals('10,3'));
      expect(maxHeap.remove(10).peek(), equals(3));
    });

    test('should be possible to remove items from heap with heapify up', () {
      final maxHeap = MaxHeap();

      maxHeap.add(3);
      maxHeap.add(10);
      maxHeap.add(5);
      maxHeap.add(6);
      maxHeap.add(7);
      maxHeap.add(4);
      maxHeap.add(6);
      maxHeap.add(8);
      maxHeap.add(2);
      maxHeap.add(1);

      expect(maxHeap.toString(), equals('10,8,6,7,6,4,5,3,2,1'));
      expect(maxHeap.remove(4).toString(), equals('10,8,6,7,6,1,5,3,2'));
      expect(maxHeap.remove(3).toString(), equals('10,8,6,7,6,1,5,2'));
      expect(maxHeap.remove(5).toString(), equals('10,8,6,7,6,1,2'));
      expect(maxHeap.remove(10).toString(), equals('8,7,6,2,6,1'));
      expect(maxHeap.remove(6).toString(), equals('8,7,1,2'));
      expect(maxHeap.remove(2).toString(), equals('8,7,1'));
      expect(maxHeap.remove(1).toString(), equals('8,7'));
      expect(maxHeap.remove(7).toString(), equals('8'));
      expect(maxHeap.remove(8).toString(), equals(''));
    });

    test('should be possible to remove items from heap with custom finding comparator', () {
      final maxHeap = MaxHeap<String>();
      maxHeap.add('a');
      maxHeap.add('bb');
      maxHeap.add('ccc');
      maxHeap.add('dddd');

      expect(maxHeap.toString(), equals('dddd,ccc,bb,a'));

      final comparator = Comparator<String>((a, b) {
        if (a.length == b.length) {
          return 0;
        }
        return a.length < b.length ? -1 : 1;
      });

      maxHeap.remove('hey', comparator);
      expect(maxHeap.toString(), equals('dddd,a,bb'));
    });
  });
}
