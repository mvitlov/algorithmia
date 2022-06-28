class LinkedListNode<V> {
  V value;
  LinkedListNode<V>? next;
  LinkedListNode({required this.value, this.next});

  @override
  String toString([String Function(V value)? callback]) {
    return callback != null ? callback(value) : '$value';
  }
}
