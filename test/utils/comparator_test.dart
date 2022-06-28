import 'package:algorithmia/utils/comparator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Comparator', () {
    test('should compare with default comparator function', () {
      final comparator = Comparator();

      expect(comparator.equal(0, 0), isTrue);
      expect(comparator.equal(0, 1), isFalse);
      expect(comparator.equal('a', 'a'), isTrue);
      expect(comparator.lessThan(1, 2), isTrue);
      expect(comparator.lessThan(-1, 2), isTrue);
      expect(comparator.lessThan('a', 'b'), isTrue);
      expect(comparator.lessThan('a', 'ab'), isTrue);
      expect(comparator.lessThan(10, 2), isFalse);
      expect(comparator.lessThanOrEqual(10, 2), isFalse);
      expect(comparator.lessThanOrEqual(1, 1), isTrue);
      expect(comparator.lessThanOrEqual(0, 0), isTrue);
      expect(comparator.greaterThan(0, 0), isFalse);
      expect(comparator.greaterThan(10, 0), isTrue);
      expect(comparator.greaterThanOrEqual(10, 0), isTrue);
      expect(comparator.greaterThanOrEqual(10, 10), isTrue);
      expect(comparator.greaterThanOrEqual(0, 10), isFalse);
    });

    test('should compare with custom comparator function', () {
      final comparator = Comparator((String a, String b) {
        if (a.length == b.length) return 0;
        return a.length < b.length ? -1 : 1;
      });

      expect(comparator.equal('a', 'b'), isTrue);
      expect(comparator.equal('a', ''), isFalse);
      expect(comparator.lessThan('b', 'aa'), isTrue);
      expect(comparator.greaterThanOrEqual('a', 'aa'), isFalse);
      expect(comparator.greaterThanOrEqual('aa', 'a'), isTrue);
      expect(comparator.greaterThanOrEqual('a', 'a'), isTrue);

      comparator.reverse();

      expect(comparator.equal('a', 'b'), isTrue);
      expect(comparator.equal('a', ''), isFalse);
      expect(comparator.lessThan('b', 'aa'), isFalse);
      expect(comparator.greaterThanOrEqual('a', 'aa'), isTrue);
      expect(comparator.greaterThanOrEqual('aa', 'a'), isFalse);
      expect(comparator.greaterThanOrEqual('a', 'a'), isTrue);
    });
  });
}
