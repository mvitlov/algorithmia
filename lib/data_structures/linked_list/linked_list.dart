import 'package:algorithmia/utils/comparator.dart';
import 'linked_list_node.dart';

class LinkedList<T> {
  LinkedListNode<T>? head;
  LinkedListNode<T>? tail;
  late Comparator<T> compare;

  LinkedList([CompareFunction<T>? compareFunction]) : compare = Comparator(compareFunction);

  LinkedList<T> prepend(T value) {
    // Make new node to be a head.
    final newNode = LinkedListNode(value: value, next: head);
    head = newNode;

    // If there is no tail yet let's make new node a tail.
    tail ??= newNode;

    return this;
  }

  LinkedList<T> append(T value) {
    final newNode = LinkedListNode(value: value);

    // If there is no head yet let's make new node a head.
    if (head == null) {
      head = newNode;
      tail = newNode;
      return this;
    }

    // Attach new node to the end of linked list.
    tail?.next = newNode;
    tail = newNode;

    return this;
  }

  LinkedList<T> insert(T value, int rawIndex) {
    final index = rawIndex < 0 ? 0 : rawIndex;
    if (index == 0) {
      prepend(value);
    } else {
      var count = 1;
      var currentNode = head;
      final newNode = LinkedListNode(value: value);
      while (currentNode != null) {
        if (count == index) break;
        currentNode = currentNode.next;
        count += 1;
      }
      if (currentNode != null) {
        newNode.next = currentNode.next;
        currentNode.next = newNode;
      } else {
        if (tail != null) {
          tail!.next = newNode;
          tail = newNode;
        } else {
          head = newNode;
          tail = newNode;
        }
      }
    }
    return this;
  }

  LinkedListNode<T>? delete(T value) {
    if (head == null) {
      return null;
    }

    LinkedListNode<T>? deletedNode;

    // If the head must be deleted then make next node that is different
    // from the head to be a new head.
    while (head != null && compare.equal(head!.value, value)) {
      deletedNode = head;
      head = head?.next;
    }

    var currentNode = head;

    if (currentNode != null) {
      // If next node must be deleted then make next node to be a next next one.
      while (currentNode?.next != null) {
        if (compare.equal(currentNode!.next!.value, value)) {
          deletedNode = currentNode.next;
          currentNode.next = currentNode.next?.next;
        } else {
          currentNode = currentNode.next;
        }
      }
    }

    // Check if tail must be deleted.
    if (compare.equal(tail!.value, value)) {
      tail = currentNode;
    }

    return deletedNode;
  }

  LinkedListNode<T>? find({T? value, bool Function(T value)? callback}) {
    if (head == null) {
      return null;
    }

    var currentNode = head;

    while (currentNode != null) {
      // If callback is specified then try to find node by callback.
      if (callback != null && callback(currentNode.value)) {
        return currentNode;
      }

      // If value is specified then try to compare by value..
      if (value != null && compare.equal(currentNode.value, value)) {
        return currentNode;
      }

      currentNode = currentNode.next;
    }

    return null;
  }

  LinkedListNode<T>? deleteTail() {
    final deletedTail = tail;

    if (head == tail) {
      // There is only one node in linked list.
      head = null;
      tail = null;

      return deletedTail;
    }

    // If there are many nodes in linked list...

    // Rewind to the last node and delete "next" link for the node before the last one.
    var currentNode = head;
    while (currentNode!.next != null) {
      if (currentNode.next?.next == null) {
        currentNode.next = null;
      } else {
        currentNode = currentNode.next;
      }
    }

    tail = currentNode;

    return deletedTail;
  }

  LinkedListNode<T>? deleteHead() {
    if (head == null) {
      return null;
    }

    final deletedHead = head;

    if (head?.next != null) {
      head = head!.next;
    } else {
      head = null;
      tail = null;
    }

    return deletedHead;
  }

  LinkedList<T> fromArray(List<T> values) {
    for (var value in values) {
      append(value);
    }
    return this;
  }

  List<LinkedListNode<T>> toArray() {
    final nodes = <LinkedListNode<T>>[];

    var currentNode = head;
    while (currentNode != null) {
      nodes.add(currentNode);
      currentNode = currentNode.next;
    }

    return nodes;
  }

  @override
  String toString([String Function(T value)? callback]) {
    return toArray().map((node) => node.toString(callback)).toString();
  }

  LinkedList<T> reverse() {
    var currNode = head;
    LinkedListNode<T>? prevNode;
    LinkedListNode<T>? nextNode;

    while (currNode != null) {
      // Store next node.
      nextNode = currNode.next;

      // Change next node of the current node so it would link to previous node.
      currNode.next = prevNode;

      // Move prevNode and currNode nodes one step forward.
      prevNode = currNode;
      currNode = nextNode;
    }

    // Reset head and tail.
    tail = head;
    head = prevNode;

    return this;
  }
}
