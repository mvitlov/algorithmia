class DoublyLinkedListNode<V> {
  V value;
  DoublyLinkedListNode<V>? next;
  DoublyLinkedListNode<V>? previous;

  DoublyLinkedListNode(this.value, {this.next, this.previous});

  @override
  String toString([String Function(V value)? callback]) {
    return callback != null ? callback(value) : '$value';
  }
}
