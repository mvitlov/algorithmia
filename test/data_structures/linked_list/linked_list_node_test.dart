import 'package:algorithmia/data_structures/linked_list/linked_list_node.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LinkedListNode', () {
    test('should create list node with value', () {
      final node = LinkedListNode(value: 1);

      expect(node.value, equals(1));
      expect(node.next, isNull);
    });

    test('should create list node with object as a value', () {
      const nodeValue = {'value': 1, 'key': 'test'};
      final node = LinkedListNode(value: nodeValue);

      expect(node.value['value'], equals(1));
      expect(node.value['key'], equals('test'));
      expect(node.next, isNull);
    });

    test('should link nodes together', () {
      final node2 = LinkedListNode(value: 2);
      final node1 = LinkedListNode(value: 1, next: node2);

      expect(node1.next, isNotNull);
      expect(node2.next, isNull);
      expect(node1.value, equals(1));
      expect(node1.next?.value, equals(2));
    });

    test('should convert node to string', () {
      final node = LinkedListNode(value: 1);

      expect(node.toString(), equals('1'));

      node.value = 222333;
      expect(node.toString(), equals('222333'));
    });

    test('should convert node to string with custom stringifier', () {
      const nodeValue = MapEntry('test', 1);
      final node = LinkedListNode(value: nodeValue);
      String toStringCallback(MapEntry<String, int> value) => 'value: ${value.value}, key: ${value.key}';
      expect(node.toString(toStringCallback), equals('value: 1, key: test'));
    });
  });
}
