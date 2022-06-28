typedef DSKeyCallbackFunction<K, V> = K Function(V value);

class DisjointSetItem<K, V> {
  V value;
  final DSKeyCallbackFunction<K, V>? keyCallback;
  DisjointSetItem<K, V>? parent;
  late Map<K, DisjointSetItem<K, V>> children;

  DisjointSetItem(this.value, {this.keyCallback}) {
    children = {};
  }

  K getKey() {
    // Allow user to define custom key generator.
    if (keyCallback != null) {
      return keyCallback!(value);
    }

    // Otherwise use value as a key by default.
    return value as K;
  }

  DisjointSetItem<K, V> getRoot() {
    return isRoot() ? this : parent!.getRoot();
  }

  bool isRoot() {
    return parent == null;
  }

  int getRank() {
    if (getChildren().isEmpty) {
      return 0;
    }

    var rank = 0;

    getChildren().forEach((child) {
      // Count child itself.
      rank += 1;

      // Also add all children of current child.
      rank += child.getRank();
    });

    return rank;
  }

  List<DisjointSetItem<K, V>> getChildren() {
    return List.from(children.values);
  }

  DisjointSetItem<K, V> setParent(
    DisjointSetItem<K, V> parentItem, {
    bool forceSettingParentChild = true,
  }) {
    parent = parentItem;

    if (forceSettingParentChild) {
      parentItem.addChild(this);
    }

    return this;
  }

  DisjointSetItem<K, V> addChild(DisjointSetItem<K, V> childItem) {
    children[childItem.getKey()] = childItem;
    childItem.setParent(this, forceSettingParentChild: false);

    return this;
  }
}
