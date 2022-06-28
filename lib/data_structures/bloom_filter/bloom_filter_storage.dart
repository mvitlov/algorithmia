class BloomFilterStorage {
  late final List<bool> storage;
  BloomFilterStorage(int size) : storage = List.filled(size, false);

  bool getValue(int index) => storage[index];
  void setValue(int index) => storage[index] = true;
}
