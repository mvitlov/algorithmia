import 'package:algorithmia/data_structures/hash_table/hash_table.dart';

class TrieNode {
  final String character;
  bool isCompleteWord;
  late final HashTable<TrieNode> children;

  TrieNode(this.character, {this.isCompleteWord = false}) {
    children = HashTable<TrieNode>();
  }

  TrieNode? getChild(String character) {
    return children.get(character);
  }

  TrieNode addChild(String character, {bool isCompleteWord = false}) {
    if (!children.has(character)) {
      children.set(character, TrieNode(character, isCompleteWord: isCompleteWord));
    }

    final childNode = children.get(character)!;

    // In cases similar to adding "car" after "carpet" we need to mark "r" character as complete.
    childNode.isCompleteWord = childNode.isCompleteWord || isCompleteWord;

    return childNode;
  }

  TrieNode removeChild(String character) {
    final childNode = getChild(character);

    // Delete childNode only if:
    // - childNode has NO children,
    // - childNode.isCompleteWord === false.
    if (childNode != null && !childNode.isCompleteWord && !childNode.hasChildren()) {
      children.delete(character);
    }

    return this;
  }

  bool hasChild(String character) {
    return children.has(character);
  }

  bool hasChildren() {
    return children.getKeys().isNotEmpty;
  }

  List<String> suggestChildren() {
    return [...children.getKeys()];
  }

  @override
  String toString() {
    var childrenAsString = suggestChildren().join(',');
    childrenAsString = childrenAsString.isNotEmpty ? ':$childrenAsString' : '';
    final isCompleteString = isCompleteWord ? '*' : '';

    return '$character$isCompleteString$childrenAsString';
  }
}
