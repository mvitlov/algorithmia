import 'package:algorithmia/data_structures/stack/stack.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Stack', () {
    test('should create empty stack', () {
      final stack = Stack();
      expect(stack, isNotNull);
      expect(stack.linkedList, isNotNull);
    });

    test('should stack data to stack', () {
      final stack = Stack<int>();

      stack.add(1);
      stack.add(2);

      expect(stack.toString(), equals('(2, 1)'));
    });

    test('should peek data from stack', () {
      final stack = Stack<int>();

      expect(stack.peek(), isNull);

      stack.add(1);
      stack.add(2);

      expect(stack.peek(), equals(2));
      expect(stack.peek(), equals(2));
    });

    test('should check if stack is empty', () {
      final stack = Stack<int>();

      expect(stack.isEmpty, isTrue);

      stack.add(1);

      expect(stack.isEmpty, isFalse);
    });

    test('should pop data from stack', () {
      final stack = Stack<int>();

      stack.add(1);
      stack.add(2);

      expect(stack.pop(), equals(2));
      expect(stack.pop(), equals(1));
      expect(stack.pop(), isNull);
      expect(stack.isEmpty, isTrue);
    });

    test('should be possible to push/pop objects', () {
      final stack = Stack<MapEntry<String, String>>();

      stack.add(const MapEntry('key1', 'test1'));
      stack.add(const MapEntry('key2', 'test2'));

      String stringifier(MapEntry<String, String> value) => '${value.key}:${value.value}';

      expect(stack.toString(stringifier), equals('(key2:test2, key1:test1)'));
      expect(stack.pop()?.value, equals('test2'));
      expect(stack.pop()?.value, equals('test1'));
    });

    test('should be possible to convert stack to array', () {
      final stack = Stack<int>();

      expect(stack.peek(), isNull);

      stack.add(1);
      stack.add(2);
      stack.add(3);

      expect(stack.toList(), equals([3, 2, 1]));
    });
  });
}
