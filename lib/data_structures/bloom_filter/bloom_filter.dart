import 'bloom_filter_storage.dart';

class BloomFilter {
  final int size;
  late final BloomFilterStorage storage;

  BloomFilter([this.size = 100]) {
    // Bloom filter size directly affects the likelihood of false positives.
    // The bigger the size the lower the likelihood of false positives.
    storage = _createStore(size);
  }

  void insert(String item) {
    final hashValues = getHashValues(item);

    // Set each hashValue index to true.
    for (var val in hashValues) {
      storage.setValue(val);
    }
  }

  bool mayContain(String item) {
    final hashValues = getHashValues(item);

    for (var hashIndex = 0; hashIndex < hashValues.length; hashIndex += 1) {
      if (!storage.getValue(hashValues[hashIndex])) {
        // We know that the item was definitely not inserted.
        return false;
      }
    }
    // The item may or may not have been inserted.
    return true;
  }

  BloomFilterStorage _createStore(int size) {
    return BloomFilterStorage(size);
  }

  int hash1(String item) {
    var hash = 0;

    for (var charIndex = 0; charIndex < item.length; charIndex += 1) {
      final char = item.codeUnitAt(charIndex);
      hash = (hash << 5) + hash + char;
      hash &= hash; // Convert to 32bit integer
      hash = (hash).abs();
    }

    return hash % size;
  }

  int hash2(String item) {
    var hash = 5381;

    for (var charIndex = 0; charIndex < item.length; charIndex += 1) {
      final char = item.codeUnitAt(charIndex);
      hash = (hash << 5) + hash + char; /* hash * 33 + c */
    }

    return (hash % size).abs();
  }

  int hash3(String item) {
    var hash = 0;

    for (var charIndex = 0; charIndex < item.length; charIndex += 1) {
      final char = item.codeUnitAt(charIndex);
      hash = (hash << 5) - hash;
      hash += char;
      hash &= hash; // Convert to 32bit integer
    }

    return (hash % size).abs();
  }

  List<int> getHashValues(String item) {
    return [hash1(item), hash2(item), hash3(item)];
  }
}
