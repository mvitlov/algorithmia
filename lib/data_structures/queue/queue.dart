import '../linked_list/linked_list.dart';

class Queue<T> {
  late final LinkedList<T> linkedList;
  Queue() {
    // We're going to implement Queue based on LinkedList since the two
    // structures are quite similar. Namely, they both operate mostly on
    // the elements at the beginning and the end. Compare enqueue/dequeue
    // operations of Queue with append/deleteHead operations of LinkedList.
    linkedList = LinkedList<T>();
  }

  bool isEmpty() {
    return linkedList.head == null;
  }

  T? peek() {
    return isEmpty() ? null : linkedList.head!.value;
  }

  void enqueue(T value) {
    linkedList.append(value);
  }

  T? dequeue() {
    final removedHead = linkedList.deleteHead();
    return removedHead?.value;
  }

  @override
  String toString([String Function(T value)? callback]) {
    return linkedList.toString(callback);
  }
}
