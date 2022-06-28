import 'disjoint_set_item.dart';

class DisjointSet<K, V> {
  DSKeyCallbackFunction<K, V> keyCallback;
  late final Map<K, DisjointSetItem<K, V>> items;

  DisjointSet(this.keyCallback) : items = {};

  DisjointSet<K, V> makeSet(V itemValue) {
    final disjointSetItem =
        DisjointSetItem(itemValue, keyCallback: keyCallback);

    if (!items.containsKey(disjointSetItem.getKey())) {
      // Add new item only in case if it not presented yet.
      items[disjointSetItem.getKey()] = disjointSetItem;
    }
    return this;
  }

  K? find(V itemValue) {
    final templateDisjointItem =
        DisjointSetItem(itemValue, keyCallback: keyCallback);

    // Try to find item itself;
    final requiredDisjointItem = items[templateDisjointItem.getKey()];

    if (requiredDisjointItem == null) {
      return null;
    }

    return requiredDisjointItem.getRoot().getKey();
  }

  DisjointSet<K, V> union(V valueA, V valueB) {
    final rootKeyA = find(valueA);
    final rootKeyB = find(valueB);

    if (rootKeyA == null || rootKeyB == null) {
      throw Exception('One or two values are not in sets');
    }

    if (rootKeyA == rootKeyB) {
      // In case if both elements are already in the same set then just return its key.
      return this;
    }

    final rootA = items[rootKeyA]!;
    final rootB = items[rootKeyB]!;

    if (rootA.getRank() < rootB.getRank()) {
      // If rootB's tree is bigger then make rootB to be a new root.
      rootB.addChild(rootA);

      return this;
    }

    // If rootA's tree is bigger then make rootA to be a new root.
    rootA.addChild(rootB);

    return this;
  }

  bool inSameSet(V valueA, V valueB) {
    final rootKeyA = find(valueA);
    final rootKeyB = find(valueB);

    if (rootKeyA == null || rootKeyB == null) {
      throw Exception('One or two values are not in sets');
    }

    return rootKeyA == rootKeyB;
  }
}
