import 'package:algorithmia/data_structures/trie/trie_node.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TrieNode', () {
    test('should create trie node', () {
      final trieNode = TrieNode('c', isCompleteWord: true);

      expect(trieNode.character, equals('c'));
      expect(trieNode.isCompleteWord, isTrue);
      expect(trieNode.toString(), equals('c*'));
    });

    test('should add child nodes', () {
      final trieNode = TrieNode('c');

      trieNode.addChild('a', isCompleteWord: true);
      trieNode.addChild('o');

      expect(trieNode.toString(), equals('c:a,o'));
    });

    test('should get child nodes', () {
      final trieNode = TrieNode('c');

      trieNode.addChild('a');
      trieNode.addChild('o');

      expect(trieNode.getChild('a').toString(), equals('a'));
      expect(trieNode.getChild('a')?.character, equals('a'));
      expect(trieNode.getChild('o').toString(), equals('o'));
      expect(trieNode.getChild('b'), isNull);
    });

    test('should check if node has children', () {
      final trieNode = TrieNode('c');

      expect(trieNode.hasChildren(), isFalse);

      trieNode.addChild('a');

      expect(trieNode.hasChildren(), isTrue);
    });

    test('should check if node has specific child', () {
      final trieNode = TrieNode('c');

      trieNode.addChild('a');
      trieNode.addChild('o');

      expect(trieNode.hasChild('a'), isTrue);
      expect(trieNode.hasChild('o'), isTrue);
      expect(trieNode.hasChild('b'), isFalse);
    });

    test('should suggest next children', () {
      final trieNode = TrieNode('c');

      trieNode.addChild('a');
      trieNode.addChild('o');

      expect(trieNode.suggestChildren(), equals(['a', 'o']));
    });

    test('should delete child node if the child node has NO children', () {
      final trieNode = TrieNode('c');
      trieNode.addChild('a');
      expect(trieNode.hasChild('a'), isTrue);

      trieNode.removeChild('a');
      expect(trieNode.hasChild('a'), isFalse);
    });

    test('should NOT delete child node if the child node has children', () {
      final trieNode = TrieNode('c');
      trieNode.addChild('a');
      final childNode = trieNode.getChild('a');
      childNode!.addChild('r');

      trieNode.removeChild('a');
      expect(trieNode.hasChild('a'), isTrue);
    });

    test('should NOT delete child node if the child node completes a word', () {
      final trieNode = TrieNode('c');

      trieNode.addChild('a', isCompleteWord: true);

      trieNode.removeChild('a');
      expect(trieNode.hasChild('a'), isTrue);
    });
  });
}
