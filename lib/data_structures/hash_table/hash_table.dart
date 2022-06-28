import '../linked_list/linked_list.dart';
import '../linked_list/linked_list_node.dart';

const defaultHashTableSize = 32;

/// Hash table size directly affects on the number of collisions.
/// The bigger the hash table size the less collisions you'll get.
/// For demonstrating purposes hash table size is small to show how collisions
/// are being handled.
class HashTable<T> {
  late final List<LinkedList<MapEntry<String, T>>> buckets;
  late final Map<String, int> keys;

  HashTable([int hashTableSize = defaultHashTableSize]) {
    buckets = List.generate(hashTableSize, (_) => LinkedList<MapEntry<String, T>>());

    // Just to keep track of all actual keys in a fast way.
    keys = {};
  }

  int hash(String key) {
    // For simplicity reasons we will just use character codes sum of all characters of the key
    // to calculate the hash.
    //
    // But you may also use more sophisticated approaches like polynomial string hash to reduce the
    // number of collisions:
    //
    // hash = charCodeAt(0) * PRIME^(n-1) + charCodeAt(1) * PRIME^(n-2) + ... + charCodeAt(n-1)
    //
    // where charCodeAt(i) is the i-th character code of the key, n is the length of the key and
    // PRIME is just any prime number like 31.
    final hash = key.split('').fold<int>(0, (int value, String symbol) => value + symbol.codeUnitAt(0));

    // Reduce hash number so it would fit hash table size.
    return hash % buckets.length;
  }

  void set(String key, T value) {
    final keyHash = hash(key);
    keys[key] = keyHash;

    final bucketLinkedList = buckets[keyHash];
    final node = bucketLinkedList.find(callback: (nodeValue) => nodeValue.key == key);

    if (node == null) {
      // Insert new node.
      bucketLinkedList.append(MapEntry(key, value));
    } else {
      // Update value of existing node.
      node.value = MapEntry(key, value);
    }
  }

  LinkedListNode<MapEntry<String, T>>? delete(String key) {
    final keyHash = hash(key);
    keys.remove(key);
    final bucketLinkedList = buckets[keyHash];
    final node = bucketLinkedList.find(callback: (MapEntry<String, T> nodeValue) => nodeValue.key == key);

    if (node != null) {
      return bucketLinkedList.delete(node.value);
    }

    return null;
  }

  T? get(String key) {
    final bucketLinkedList = buckets[hash(key)];
    final node = bucketLinkedList.find(callback: (MapEntry<String, T> nodeValue) => nodeValue.key == key);

    return node?.value.value;
  }

  bool has(String key) {
    return keys.containsKey(key);
  }

  List<String> getKeys() {
    return keys.keys.toList();
  }

  List<T> getValues() {
    return buckets.fold<List<T>>(<T>[], (List<T> values, bucket) {
      final bucketValues = bucket.toArray().map((linkedListNode) => linkedListNode.value.value);
      return [...values, ...bucketValues];
    });
  }
}
