import 'package:algorithmia/data_structures/trie/trie_node.dart';

const _headCharacter = '*';

class Trie {
  late TrieNode head;
  Trie() {
    head = TrieNode(_headCharacter);
  }

  Trie addWord(String word) {
    final characters = word.split('');
    var currentNode = head;

    for (var charIndex = 0; charIndex < characters.length; charIndex += 1) {
      final isComplete = charIndex == characters.length - 1;
      currentNode = currentNode.addChild(characters[charIndex], isCompleteWord: isComplete);
    }

    return this;
  }

  Trie deleteWord(String word) {
    void depthFirstDelete(TrieNode currentNode, [int charIndex = 0]) {
      if (charIndex >= word.length) {
        // Return if we're trying to delete the character that is out of word's scope.
        return;
      }

      final character = word[charIndex];
      final nextNode = currentNode.getChild(character);

      if (nextNode == null) {
        // Return if we're trying to delete a word that has not been added to the Trie.
        return;
      }

      // Go deeper.
      depthFirstDelete(nextNode, charIndex + 1);

      // Since we're going to delete a word let's un-mark its last character isCompleteWord flag.
      if (charIndex == (word.length - 1)) {
        nextNode.isCompleteWord = false;
      }

      // childNode is deleted only if:
      // - childNode has NO children
      // - childNode.isCompleteWord === false
      currentNode.removeChild(character);
    }

    // Start depth-first deletion from the head node.
    depthFirstDelete(head);

    return this;
  }

  List<String> suggestNextCharacters(String word) {
    final lastCharacter = getLastCharacterNode(word);

    if (lastCharacter == null) {
      return [];
    }

    return lastCharacter.suggestChildren();
  }

  bool doesWordExist(String word) {
    final lastCharacter = getLastCharacterNode(word);
    return lastCharacter != null && lastCharacter.isCompleteWord;
  }

  TrieNode? getLastCharacterNode(String word) {
    final characters = word.split('');
    TrieNode? currentNode = head;

    for (var charIndex = 0; charIndex < characters.length; charIndex += 1) {
      if (!currentNode!.hasChild(characters[charIndex])) {
        return null;
      }

      currentNode = currentNode.getChild(characters[charIndex]);
    }

    return currentNode;
  }
}
