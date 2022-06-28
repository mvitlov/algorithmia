import 'package:algorithmia/data_structures/doubly_linked_list/doubly_linked_list_node.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DoublyLinkedListNode', () {
    test('should create list node with value', () {
      final node = DoublyLinkedListNode(1);

      expect(node.value, equals(1));
      expect(node.next, isNull);
      expect(node.previous, isNull);
    });

    test('should create list node with object as a value', () {
      const nodeValue = MapEntry('test', 1);
      final node = DoublyLinkedListNode(nodeValue);

      expect(node.value.value, equals(1));
      expect(node.value.key, equals('test'));
      expect(node.next, isNull);
      expect(node.previous, isNull);
    });

    test('should link nodes together', () {
      final node2 = DoublyLinkedListNode(2);
      final node1 = DoublyLinkedListNode(1, next: node2);
      final node3 = DoublyLinkedListNode(10, next: node1, previous: node2);

      expect(node1.next, isNotNull);
      expect(node1.previous, isNull);
      expect(node2.next, isNull);
      expect(node2.previous, isNull);
      expect(node3.next, isNotNull);
      expect(node3.previous, isNotNull);
      expect(node1.value, equals(1));
      expect(node1.next?.value, equals(2));
      expect(node3.next?.value, equals(1));
      expect(node3.previous?.value, equals(2));
    });

    test('should convert node to string', () {
      final node = DoublyLinkedListNode(1);

      expect(node.toString(), equals('1'));

      node.value = 10;
      expect(node.toString(), equals('10'));
    });

    test('should convert node to string with custom stringifier', () {
      const nodeValue = MapEntry('test', 1);
      final node = DoublyLinkedListNode(nodeValue);
      String toStringCallback(MapEntry<String, int> value) => 'value: ${value.value}, key: ${value.key}';

      expect(node.toString(toStringCallback), equals('value: 1, key: test'));
    });
  });
}
