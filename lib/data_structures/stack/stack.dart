import '../linked_list/linked_list.dart';

class Stack<T> {
  late final LinkedList<T> linkedList;
  Stack() {
    // We're going to implement Stack based on LinkedList since these
    // structures are quite similar. Compare push/pop operations of the Stack
    // with prepend/deleteHead operations of LinkedList.
    linkedList = LinkedList();
  }

  bool get isEmpty {
    // The stack is empty if its linked list doesn't have a head.
    return linkedList.head == null;
  }

  T? peek() {
    if (isEmpty) {
      // If the linked list is empty then there is nothing to peek from.
      return null;
    }

    // Just read the value from the start of linked list without deleting it.
    return linkedList.head!.value;
  }

  void add(T value) {
    // Pushing means to lay the value on top of the stack. Therefore let's just add
    // the new value at the start of the linked list.
    linkedList.prepend(value);
  }

  T? pop() {
    // Let's try to delete the first node (the head) from the linked list.
    // If there is no head (the linked list is empty) just return null.
    return linkedList.deleteHead()?.value;
  }

  List<T> toList() {
    return linkedList.toArray().map((linkedListNode) => linkedListNode.value).toList();
  }

  @override
  String toString([String Function(T value)? callback]) {
    return linkedList.toString(callback);
  }
}
