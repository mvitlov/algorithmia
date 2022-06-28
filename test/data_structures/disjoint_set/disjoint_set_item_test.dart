import 'package:algorithmia/data_structures/disjoint_set/disjoint_set_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DisjointSetItem', () {
    test('should do basic manipulation with disjoint set item', () {
      final itemA = DisjointSetItem('A');
      final itemB = DisjointSetItem('B');
      final itemC = DisjointSetItem('C');
      final itemD = DisjointSetItem('D');

      expect(itemA.getRank(), equals(0));
      expect(itemA.getChildren(), isEmpty);
      expect(itemA.getKey(), equals('A'));
      expect(itemA.getRoot(), equals(itemA));
      expect(itemA.isRoot(), isTrue);
      expect(itemB.isRoot(), isTrue);

      itemA.addChild(itemB);
      itemD.setParent(itemC);

      expect(itemA.getRank(), equals(1));
      expect(itemC.getRank(), equals(1));

      expect(itemB.getRank(), equals(0));
      expect(itemD.getRank(), equals(0));

      expect(itemA.getChildren().length, equals(1));
      expect(itemC.getChildren().length, equals(1));

      expect(itemA.getChildren()[0], equals(itemB));
      expect(itemC.getChildren()[0], equals(itemD));

      expect(itemB.getChildren().length, equals(0));
      expect(itemD.getChildren().length, equals(0));

      expect(itemA.getRoot(), equals(itemA));
      expect(itemB.getRoot(), equals(itemA));

      expect(itemC.getRoot(), equals(itemC));
      expect(itemD.getRoot(), equals(itemC));

      expect(itemA.isRoot(), isTrue);
      expect(itemB.isRoot(), isFalse);
      expect(itemC.isRoot(), isTrue);
      expect(itemD.isRoot(), isFalse);

      itemA.addChild(itemC);

      expect(itemA.isRoot(), isTrue);
      expect(itemB.isRoot(), isFalse);
      expect(itemC.isRoot(), isFalse);
      expect(itemD.isRoot(), isFalse);

      expect(itemA.getRank(), equals(3));
      expect(itemB.getRank(), equals(0));
      expect(itemC.getRank(), equals(1));
    });

    test(
        'should do basic manipulation with disjoint set item with custom key extractor',
        () {
      keyExtractor(MapEntry<String, int> value) {
        return value.key;
      }

      final itemA =
          DisjointSetItem(const MapEntry('A', 1), keyCallback: keyExtractor);
      final itemB =
          DisjointSetItem(const MapEntry('B', 2), keyCallback: keyExtractor);
      final itemC =
          DisjointSetItem(const MapEntry('C', 3), keyCallback: keyExtractor);
      final itemD =
          DisjointSetItem(const MapEntry('D', 4), keyCallback: keyExtractor);

      expect(itemA.getRank(), equals(0));
      expect(itemA.getChildren(), isEmpty);
      expect(itemA.getKey(), equals('A'));
      expect(itemA.getRoot(), equals(itemA));
      expect(itemA.isRoot(), isTrue);
      expect(itemB.isRoot(), isTrue);

      itemA.addChild(itemB);
      itemD.setParent(itemC);

      expect(itemA.getRank(), equals(1));
      expect(itemC.getRank(), equals(1));

      expect(itemB.getRank(), equals(0));
      expect(itemD.getRank(), equals(0));

      expect(itemA.getChildren().length, equals(1));
      expect(itemC.getChildren().length, equals(1));

      expect(itemA.getChildren()[0], equals(itemB));
      expect(itemC.getChildren()[0], equals(itemD));

      expect(itemB.getChildren().length, equals(0));
      expect(itemD.getChildren().length, equals(0));

      expect(itemA.getRoot(), equals(itemA));
      expect(itemB.getRoot(), equals(itemA));

      expect(itemC.getRoot(), equals(itemC));
      expect(itemD.getRoot(), equals(itemC));

      expect(itemA.isRoot(), isTrue);
      expect(itemB.isRoot(), isFalse);
      expect(itemC.isRoot(), isTrue);
      expect(itemD.isRoot(), isFalse);

      itemA.addChild(itemC);

      expect(itemA.isRoot(), isTrue);
      expect(itemB.isRoot(), isFalse);
      expect(itemC.isRoot(), isFalse);
      expect(itemD.isRoot(), isFalse);

      expect(itemA.getRank(), equals(3));
      expect(itemB.getRank(), equals(0));
      expect(itemC.getRank(), equals(1));
    });
  });
}
