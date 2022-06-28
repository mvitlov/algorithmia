import 'package:algorithmia/data_structures/queue/queue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Queue', () {
    test('should create empty queue', () {
      final queue = Queue<int>();
      expect(queue, isNotNull);
      expect(queue.linkedList, isNotNull);
    });

    test('should enqueue data to queue', () {
      final queue = Queue<int>();

      queue.enqueue(1);
      queue.enqueue(2);

      expect(queue.toString(), equals('(1, 2)'));
    });

    test('should be possible to enqueue/dequeue objects', () {
      final queue = Queue<MapEntry<String, String>>();

      queue.enqueue(const MapEntry('key1', 'test1'));
      queue.enqueue(const MapEntry('key2', 'test2'));

      String stringifier(MapEntry<String, String> value) => '${value.key}:${value.value}';

      expect(queue.toString(stringifier), equals('(key1:test1, key2:test2)'));
      expect(queue.dequeue()!.value, equals('test1'));
      expect(queue.dequeue()!.value, equals('test2'));
    });

    test('should peek data from queue', () {
      final queue = Queue<int>();

      expect(queue.peek(), isNull);

      queue.enqueue(1);
      queue.enqueue(2);

      expect(queue.peek(), equals(1));
    });

    test('should check if queue is empty', () {
      final queue = Queue<int>();

      expect(queue.isEmpty(), isTrue);

      queue.enqueue(1);

      expect(queue.isEmpty(), isFalse);
    });

    test('should dequeue from queue in FIFO order', () {
      final queue = Queue<int>();

      queue.enqueue(1);
      queue.enqueue(2);

      expect(queue.dequeue(), equals(1));
      expect(queue.dequeue(), equals(2));
      expect(queue.dequeue(), isNull);
      expect(queue.isEmpty(), isTrue);
    });
  });
}
