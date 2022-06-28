import 'package:algorithmia/data_structures/doubly_linked_list/doubly_linked_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DoublyLinkedList', () {
    test('should create empty linked list', () {
      final linkedList = DoublyLinkedList();
      expect(linkedList.toString(), equals('()'));
    });

    test('should append node to linked list', () {
      final linkedList = DoublyLinkedList<int>();

      expect(linkedList.head, isNull);
      expect(linkedList.tail, isNull);

      linkedList.append(1);
      linkedList.append(2);

      expect(linkedList.head?.next?.value, equals(2));
      expect(linkedList.tail?.previous?.value, equals(1));
      expect(linkedList.toString(), equals('(1, 2)'));
    });

    test('should prepend node to linked list', () {
      final linkedList = DoublyLinkedList();

      linkedList.prepend(2);
      expect(linkedList.head.toString(), equals('2'));
      expect(linkedList.tail.toString(), equals('2'));

      linkedList.append(1);
      linkedList.prepend(3);

      expect(linkedList.head?.next?.next?.previous, equals(linkedList.head?.next));
      expect(linkedList.tail?.previous?.next, equals(linkedList.tail));
      expect(linkedList.tail?.previous?.value, equals(2));
      expect(linkedList.toString(), equals('(3, 2, 1)'));
    });

    test('should create linked list from array', () {
      final linkedList = DoublyLinkedList<int>();
      linkedList.fromArray([1, 1, 2, 3, 3, 3, 4, 5]);

      expect(linkedList.toString(), equals('(1, 1, 2, 3, 3, 3, 4, 5)'));
    });

    test('should delete node by value from linked list', () {
      final linkedList = DoublyLinkedList();

      expect(linkedList.delete(5), isNull);

      linkedList.append(1);
      linkedList.append(1);
      linkedList.append(2);
      linkedList.append(3);
      linkedList.append(3);
      linkedList.append(3);
      linkedList.append(4);
      linkedList.append(5);

      expect(linkedList.head.toString(), equals('1'));
      expect(linkedList.tail.toString(), equals('5'));

      final deletedNode = linkedList.delete(3);
      expect(deletedNode?.value, equals(3));
      expect(linkedList.tail?.previous?.previous?.value, equals(2));
      expect(linkedList.toString(), equals('(1, 1, 2, 4, 5)'));

      linkedList.delete(3);
      expect(linkedList.toString(), equals('(1, 1, 2, 4, 5)'));

      linkedList.delete(1);
      expect(linkedList.toString(), equals('(2, 4, 5)'));

      expect(linkedList.head.toString(), equals('2'));
      expect(linkedList.head?.next?.next, equals(linkedList.tail));
      expect(linkedList.tail?.previous?.previous, equals(linkedList.head));
      expect(linkedList.tail.toString(), equals('5'));

      linkedList.delete(5);
      expect(linkedList.toString(), equals('(2, 4)'));

      expect(linkedList.head.toString(), equals('2'));
      expect(linkedList.tail.toString(), equals('4'));

      linkedList.delete(4);
      expect(linkedList.toString(), equals('(2)'));

      expect(linkedList.head.toString(), equals('2'));
      expect(linkedList.tail.toString(), equals('2'));
      expect(linkedList.head, equals(linkedList.tail));

      linkedList.delete(2);
      expect(linkedList.toString(), equals('()'));
    });

    test('should delete linked list tail', () {
      final linkedList = DoublyLinkedList();

      expect(linkedList.deleteTail(), isNull);

      linkedList.append(1);
      linkedList.append(2);
      linkedList.append(3);

      expect(linkedList.head.toString(), equals('1'));
      expect(linkedList.tail.toString(), equals('3'));

      final deletedNode1 = linkedList.deleteTail();

      expect(deletedNode1?.value, equals(3));
      expect(linkedList.toString(), equals('(1, 2)'));
      expect(linkedList.head.toString(), equals('1'));
      expect(linkedList.tail.toString(), equals('2'));

      final deletedNode2 = linkedList.deleteTail();

      expect(deletedNode2?.value, equals(2));
      expect(linkedList.toString(), equals('(1)'));
      expect(linkedList.head.toString(), equals('1'));
      expect(linkedList.tail.toString(), equals('1'));

      final deletedNode3 = linkedList.deleteTail();

      expect(deletedNode3?.value, equals(1));
      expect(linkedList.toString(), equals('()'));
      expect(linkedList.head, isNull);
      expect(linkedList.tail, isNull);
    });

    test('should delete linked list head', () {
      final linkedList = DoublyLinkedList();

      expect(linkedList.deleteHead(), isNull);

      linkedList.append(1);
      linkedList.append(2);

      expect(linkedList.head.toString(), equals('1'));
      expect(linkedList.tail.toString(), equals('2'));

      final deletedNode1 = linkedList.deleteHead();

      expect(deletedNode1?.value, equals(1));
      expect(linkedList.head?.previous, isNull);
      expect(linkedList.toString(), equals('(2)'));
      expect(linkedList.head.toString(), equals('2'));
      expect(linkedList.tail.toString(), equals('2'));

      final deletedNode2 = linkedList.deleteHead();

      expect(deletedNode2?.value, equals(2));
      expect(linkedList.toString(), equals('()'));
      expect(linkedList.head, isNull);
      expect(linkedList.tail, isNull);
    });

    test('should be possible to store objects in the list and to print them out', () {
      final linkedList = DoublyLinkedList<MapEntry<String, int>>();

      const nodeValue1 = MapEntry('key1', 1);
      const nodeValue2 = MapEntry('key2', 2);

      linkedList.append(nodeValue1).prepend(nodeValue2);

      String nodeStringifier(MapEntry<String, int> value) => '${value.key}:${value.value}';

      expect(linkedList.toString(nodeStringifier), equals('(key2:2, key1:1)'));
    });

    test('should find node by value', () {
      final linkedList = DoublyLinkedList<int>();

      expect(linkedList.find(value: 5), isNull);

      linkedList.append(1);
      expect(linkedList.find(value: 1), isNotNull);

      linkedList.append(2).append(3);

      final node = linkedList.find(value: 2);

      expect(node?.value, equals(2));
      expect(linkedList.find(value: 5), isNull);
    });

    test('should find node by callback', () {
      final linkedList = DoublyLinkedList<MapEntry<String, int>>();

      linkedList
          .append(const MapEntry('test1', 1))
          .append(const MapEntry('test2', 2))
          .append(const MapEntry('test3', 3));

      final node = linkedList.find(callback: (value) => value.key == 'test2');

      expect(node, isNotNull);
      expect(node!.value.value, equals(2));
      expect(node.value.key, equals('test2'));
      expect(linkedList.find(callback: (value) => value.key == 'test5'), isNull);
    });

    test('should find node by means of custom compare function', () {
      int comparatorFunction(Map a, Map b) {
        if (a['customValue'] == b['customValue']) {
          return 0;
        }

        return (a['customValue'] as String).compareTo(b['customValue'] as String);
      }

      final linkedList = DoublyLinkedList<Map<String, dynamic>>(comparatorFunction);

      linkedList.append({'value': 1, 'customValue': 'test1'}).append({'value': 2, 'customValue': 'test2'}).append(
          {'value': 3, 'customValue': 'test3'});

      final node = linkedList.find(
        value: {'value': 2, 'customValue': 'test2'},
      );

      expect(node, isNotNull);
      expect(node!.value['value'], equals(2));
      expect(node.value['customValue'], equals('test2'));
      expect(linkedList.find(value: {'value': 2, 'customValue': 'test5'}), isNull);
    });

    test('should reverse linked list', () {
      final linkedList = DoublyLinkedList();

      // Add test values to linked list.
      linkedList.append(1).append(2).append(3).append(4);

      expect(linkedList.toString(), equals('(1, 2, 3, 4)'));
      expect(linkedList.head?.value, equals(1));
      expect(linkedList.tail?.value, equals(4));

      // Reverse linked list.
      linkedList.reverse();

      expect(linkedList.toString(), equals('(4, 3, 2, 1)'));

      expect(linkedList.head?.previous, isNull);
      expect(linkedList.head?.value, equals(4));
      expect(linkedList.head?.next?.value, equals(3));
      expect(linkedList.head?.next?.next?.value, equals(2));
      expect(linkedList.head?.next?.next?.next?.value, equals(1));

      expect(linkedList.tail?.next, isNull);
      expect(linkedList.tail?.value, equals(1));
      expect(linkedList.tail?.previous?.value, equals(2));
      expect(linkedList.tail?.previous?.previous?.value, equals(3));
      expect(linkedList.tail?.previous?.previous?.previous?.value, equals(4));

      // Reverse linked list back to initial state.
      linkedList.reverse();

      expect(linkedList.toString(), equals('(1, 2, 3, 4)'));

      expect(linkedList.head?.previous, isNull);
      expect(linkedList.head?.value, equals(1));
      expect(linkedList.head?.next?.value, equals(2));
      expect(linkedList.head?.next?.next?.value, equals(3));
      expect(linkedList.head?.next?.next?.next?.value, equals(4));

      expect(linkedList.tail?.next, isNull);
      expect(linkedList.tail?.value, equals(4));
      expect(linkedList.tail?.previous?.value, equals(3));
      expect(linkedList.tail?.previous?.previous?.value, equals(2));
      expect(linkedList.tail?.previous?.previous?.previous?.value, equals(1));
    });
  });
}
