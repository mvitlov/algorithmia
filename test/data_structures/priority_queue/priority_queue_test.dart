import 'package:algorithmia/data_structures/priority_queue/priority_queue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PriorityQueue', () {
    test('should insert items to the queue and respect priorities', () {
      final priorityQueue = PriorityQueue();

      priorityQueue.enqueue(10, 1);
      expect(priorityQueue.peek(), equals(10));

      priorityQueue.enqueue(5, 2);
      expect(priorityQueue.peek(), equals(10));

      priorityQueue.enqueue(100, 0);
      expect(priorityQueue.peek(), equals(100));
    });

    test('should be possible to use objects in priority queue', () {
      final priorityQueue = PriorityQueue<Map<String, String>>();

      const user1 = {'name': 'Mike'};
      const user2 = {'name': 'Bill'};
      const user3 = {'name': 'Jane'};

      priorityQueue.enqueue(user1, 1);
      expect(priorityQueue.peek(), equals(user1));

      priorityQueue.enqueue(user2, 2);
      expect(priorityQueue.peek(), equals(user1));

      priorityQueue.enqueue(user3, 0);
      expect(priorityQueue.peek(), equals(user3));
    });

    test('should poll from queue with respect to priorities', () {
      final priorityQueue = PriorityQueue<int>();

      priorityQueue.enqueue(10, 1);
      priorityQueue.enqueue(5, 2);
      priorityQueue.enqueue(100, 0);
      priorityQueue.enqueue(200, 0);

      expect(priorityQueue.poll(), equals(100));
      expect(priorityQueue.poll(), equals(200));
      expect(priorityQueue.poll(), equals(10));
      expect(priorityQueue.poll(), equals(5));
    });

    test('should be possible to change priority of head node', () {
      final priorityQueue = PriorityQueue<int>();

      priorityQueue.enqueue(10, 1);
      priorityQueue.enqueue(5, 2);
      priorityQueue.enqueue(100, 0);
      priorityQueue.enqueue(200, 0);

      expect(priorityQueue.peek(), equals(100));

      priorityQueue.changePriority(100, 10);
      priorityQueue.changePriority(10, 20);

      expect(priorityQueue.poll(), equals(200));
      expect(priorityQueue.poll(), equals(5));
      expect(priorityQueue.poll(), equals(100));
      expect(priorityQueue.poll(), equals(10));
    });

    test('should be possible to change priority of internal nodes', () {
      final priorityQueue = PriorityQueue<int>();

      priorityQueue.enqueue(10, 1);
      priorityQueue.enqueue(5, 2);
      priorityQueue.enqueue(100, 0);
      priorityQueue.enqueue(200, 0);

      expect(priorityQueue.peek(), equals(100));

      priorityQueue.changePriority(200, 10);
      priorityQueue.changePriority(10, 20);

      expect(priorityQueue.poll(), equals(100));
      expect(priorityQueue.poll(), equals(5));
      expect(priorityQueue.poll(), equals(200));
      expect(priorityQueue.poll(), equals(10));
    });

    test('should be possible to change priority along with node addition', () {
      final priorityQueue = PriorityQueue<int>();

      priorityQueue.enqueue(10, 1);
      priorityQueue.enqueue(5, 2);
      priorityQueue.enqueue(100, 0);
      priorityQueue.enqueue(200, 0);

      priorityQueue.changePriority(200, 10);
      priorityQueue.changePriority(10, 20);

      priorityQueue.enqueue(15, 15);

      expect(priorityQueue.poll(), equals(100));
      expect(priorityQueue.poll(), equals(5));
      expect(priorityQueue.poll(), equals(200));
      expect(priorityQueue.poll(), equals(15));
      expect(priorityQueue.poll(), equals(10));
    });

    test('should be possible to search in priority queue by value', () {
      final priorityQueue = PriorityQueue<int>();

      priorityQueue.enqueue(10, 1);
      priorityQueue.enqueue(5, 2);
      priorityQueue.enqueue(100, 0);
      priorityQueue.enqueue(200, 0);
      priorityQueue.enqueue(15, 15);

      expect(priorityQueue.hasValue(70), isFalse);
      expect(priorityQueue.hasValue(15), isTrue);
    });
  });
}
