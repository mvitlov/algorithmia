import 'package:algorithmia/utils/comparator.dart';
import 'doubly_linked_list_node.dart';

class DoublyLinkedList<T> {
  DoublyLinkedListNode<T>? head;
  DoublyLinkedListNode<T>? tail;
  late Comparator<T> compare;

  DoublyLinkedList([CompareFunction<T>? comparatorFunction]) : compare = Comparator(comparatorFunction);

  DoublyLinkedList<T> prepend(T value) {
    // Make new node to be a head.
    final newNode = DoublyLinkedListNode(value, next: head);

    // If there is head, then it won't be head anymore.
    // Therefore, make its previous reference to be new node (new head).
    // Then mark the new node as head.
    if (head != null) {
      head!.previous = newNode;
    }
    head = newNode;

    // If there is no tail yet let's make new node a tail.
    tail ??= newNode;

    return this;
  }

  DoublyLinkedList<T> append(T value) {
    final newNode = DoublyLinkedListNode(value);

    // If there is no head yet let's make new node a head.
    if (head == null) {
      head = newNode;
      tail = newNode;

      return this;
    }

    // Attach new node to the end of linked list.
    tail?.next = newNode;

    // Attach current tail to the new node's previous reference.
    newNode.previous = tail;

    // Set new node to be the tail of linked list.
    tail = newNode;

    return this;
  }

  DoublyLinkedListNode<T>? delete(T value) {
    if (head == null) {
      return null;
    }

    DoublyLinkedListNode<T>? deletedNode;
    var currentNode = head;

    while (currentNode != null) {
      if (compare.equal(currentNode.value, value)) {
        deletedNode = currentNode;

        if (deletedNode == head) {
          // If HEAD is going to be deleted...

          // Set head to second node, which will become new head.
          head = deletedNode.next;

          // Set new head's previous to null.
          if (head != null) {
            head!.previous = null;
          }

          // If all the nodes in list has same value that is passed as argument
          // then all nodes will get deleted, therefore tail needs to be updated.
          if (deletedNode == tail) {
            tail = null;
          }
        } else if (deletedNode == tail) {
          // If TAIL is going to be deleted...

          // Set tail to second last node, which will become new tail.
          tail = deletedNode.previous;
          tail?.next = null;
        } else {
          // If MIDDLE node is going to be deleted...
          final previousNode = deletedNode.previous;
          final nextNode = deletedNode.next;

          previousNode?.next = nextNode;
          nextNode?.previous = previousNode;
        }
      }

      currentNode = currentNode.next;
    }

    return deletedNode;
  }

  DoublyLinkedListNode<T>? find({T? value, bool Function(T value)? callback}) {
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

  DoublyLinkedListNode<T>? deleteTail() {
    if (tail == null) {
      // No tail to delete.
      return null;
    }

    if (head == tail) {
      // There is only one node in linked list.
      final deletedTail = tail;
      head = null;
      tail = null;

      return deletedTail;
    }

    // If there are many nodes in linked list...
    final deletedTail = tail;

    tail = tail?.previous;
    tail?.next = null;

    return deletedTail;
  }

  DoublyLinkedListNode<T>? deleteHead() {
    if (head == null) {
      return null;
    }

    final deletedHead = head;

    if (head?.next != null) {
      head = head?.next;
      head?.previous = null;
    } else {
      head = null;
      tail = null;
    }

    return deletedHead;
  }

  List<DoublyLinkedListNode<T>> toArray() {
    final nodes = <DoublyLinkedListNode<T>>[];

    var currentNode = head;
    while (currentNode != null) {
      nodes.add(currentNode);
      currentNode = currentNode.next;
    }

    return nodes;
  }

  DoublyLinkedList<T> fromArray(List<T> values) {
    for (var value in values) {
      append(value);
    }
    return this;
  }

  @override
  String toString([String Function(T value)? callback]) {
    return toArray().map((node) => node.toString(callback)).toString();
  }

  DoublyLinkedList<T> reverse() {
    var currNode = head;
    DoublyLinkedListNode<T>? prevNode;
    DoublyLinkedListNode<T>? nextNode;

    while (currNode != null) {
      // Store next node.
      nextNode = currNode.next;
      prevNode = currNode.previous;

      // Change next node of the current node so it would link to previous node.
      currNode.next = prevNode;
      currNode.previous = nextNode;

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
