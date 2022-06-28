import 'package:algorithmia/data_structures/linked_list/linked_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LinkedList', () {
    test('should create empty linked list', () {
      final linkedList = LinkedList();
      expect(linkedList.toString(), equals('()'));
    });

    test('should append node to linked list', () {
      final linkedList = LinkedList();

      expect(linkedList.head, isNull);
      expect(linkedList.tail, isNull);

      linkedList.append(1);
      linkedList.append(2);

      expect(linkedList.toString(), equals('(1, 2)'));
      expect(linkedList.tail?.next, isNull);
    });

    test('should prepend node to linked list', () {
      final linkedList = LinkedList<int>();

      linkedList.prepend(2);
      expect(linkedList.head.toString(), equals('2'));
      expect(linkedList.tail.toString(), equals('2'));

      linkedList.append(1);
      linkedList.prepend(3);

      expect(linkedList.toString(), equals('(3, 2, 1)'));
    });

    test('should insert node to linked list', () {
      final linkedList = LinkedList<int>(((a, b) => 0));

      linkedList.insert(4, 3);
      expect(linkedList.head.toString(), equals('4'));
      expect(linkedList.tail.toString(), equals('4'));

      linkedList.insert(3, 2);
      linkedList.insert(2, 1);
      linkedList.insert(1, -7);
      linkedList.insert(10, 9);

      expect(linkedList.toString(), equals('(1, 4, 2, 3, 10)'));
    });

    test('should delete node by value from linked list', () {
      final linkedList = LinkedList<int>();

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
      expect(linkedList.toString(), equals('(1, 1, 2, 4, 5)'));

      linkedList.delete(3);
      expect(linkedList.toString(), equals('(1, 1, 2, 4, 5)'));

      linkedList.delete(1);
      expect(linkedList.toString(), equals('(2, 4, 5)'));

      expect(linkedList.head.toString(), equals('2'));
      expect(linkedList.tail.toString(), equals('5'));

      linkedList.delete(5);
      expect(linkedList.toString(), equals('(2, 4)'));

      expect(linkedList.head.toString(), equals('2'));
      expect(linkedList.tail.toString(), equals('4'));

      linkedList.delete(4);
      expect(linkedList.toString(), equals('(2)'));

      expect(linkedList.head.toString(), equals('2'));
      expect(linkedList.tail.toString(), equals('2'));

      linkedList.delete(2);
      expect(linkedList.toString(), equals('()'));
    });

    test('should delete linked list tail', () {
      final linkedList = LinkedList<int>(((a, b) => 0));

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
      final linkedList = LinkedList<int>();

      expect(linkedList.deleteHead(), isNull);

      linkedList.append(1);
      linkedList.append(2);

      expect(linkedList.head.toString(), equals('1'));
      expect(linkedList.tail.toString(), equals('2'));

      final deletedNode1 = linkedList.deleteHead();

      expect(deletedNode1?.value, equals(1));
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
      final linkedList = LinkedList<MapEntry<String, int>>();

      const nodeValue1 = MapEntry('key1', 1);
      const nodeValue2 = MapEntry('key2', 2);

      linkedList.append(nodeValue1).prepend(nodeValue2);

      String nodeStringifier(MapEntry<String, int> value) => '${value.key}:${value.value}';

      expect(linkedList.toString(nodeStringifier), equals('(key2:2, key1:1)'));
    });

    test('should find node by value', () {
      final linkedList = LinkedList<int>();

      expect(linkedList.find(value: 5), isNull);

      linkedList.append(1);
      expect(linkedList.find(value: 1), isNotNull);

      linkedList.append(2).append(3);

      final node = linkedList.find(value: 2);

      expect(node?.value, equals(2));
      expect(linkedList.find(value: 5), isNull);
    });

    test('should find node by callback', () {
      final linkedList = LinkedList<Map<String, dynamic>>();

      linkedList.append({'value': 1, 'key': 'test1'}).append({'value': 2, 'key': 'test2'}).append(
          {'value': 3, 'key': 'test3'});

      final node = linkedList.find(callback: (value) => value['key'] == 'test2');

      expect(node, isNotNull);
      expect(node?.value['value'], equals(2));
      expect(node?.value['key'], equals('test2'));
      expect(linkedList.find(callback: (value) => value['key'] == 'test5'), isNull);
    });

    test('should create linked list from array', () {
      final linkedList = LinkedList();
      linkedList.fromArray([1, 1, 2, 3, 3, 3, 4, 5]);

      expect(linkedList.toString(), equals('(1, 1, 2, 3, 3, 3, 4, 5)'));
    });

    test('should find node by means of custom compare function', () {
      int comparatorFunction(Map<String, dynamic> a, Map<String, dynamic> b) {
        return (a['customValue'] as String).compareTo(b['customValue'] as String);
      }

      final linkedList = LinkedList(comparatorFunction);

      linkedList.append({'value': 1, 'customValue': 'test1'}).append({'value': 2, 'customValue': 'test2'}).append(
          {'value': 3, 'customValue': 'test3'});

      final node = linkedList.find(
        value: {'value': 2, 'customValue': 'test2'},
      );

      expect(node, isNotNull);
      expect(node?.value['value'], equals(2));
      expect(node?.value['customValue'], equals('test2'));
      expect(linkedList.find(value: {'value': 2, 'customValue': 'test5'}), isNull);
    });

    test('should find preferring callback over compare function', () {
      int greaterThan(int value, int compareTo) => (value > compareTo ? 0 : 1);

      final linkedList = LinkedList(greaterThan);
      linkedList.fromArray([1, 2, 3, 4, 5]);

      var node = linkedList.find(value: 3);
      expect(node?.value, equals(4));

      node = linkedList.find(callback: (value) => value < 3);
      expect(node?.value, equals(1));
    });

    test('should convert to array', () {
      final linkedList = LinkedList();
      linkedList.append(1);
      linkedList.append(2);
      linkedList.append(3);
      expect(linkedList.toArray().join(','), equals('1,2,3'));
    });

    test('should reverse linked list', () {
      final linkedList = LinkedList<int>();

      // Add test values to linked list.
      linkedList.append(1).append(2).append(3);

      expect(linkedList.toString(), equals('(1, 2, 3)'));
      expect(linkedList.head?.value, equals(1));
      expect(linkedList.tail?.value, equals(3));

      // Reverse linked list.
      linkedList.reverse();
      expect(linkedList.toString(), equals('(3, 2, 1)'));
      expect(linkedList.head?.value, equals(3));
      expect(linkedList.tail?.value, equals(1));

      // Reverse linked list back to initial state.
      linkedList.reverse();
      expect(linkedList.toString(), equals('(1, 2, 3)'));
      expect(linkedList.head?.value, equals(1));
      expect(linkedList.tail?.value, equals(3));
    });
  });
}
