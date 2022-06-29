import 'package:algorithmia/algorithms/math/is_power_of_two/is_power_of_two.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isPowerOfTwo', () {
    test('should check if the number is made by multiplying twos', () {
      expect(isPowerOfTwo(-1), isFalse);
      expect(isPowerOfTwo(0), isFalse);
      expect(isPowerOfTwo(1), isTrue);
      expect(isPowerOfTwo(2), isTrue);
      expect(isPowerOfTwo(3), isFalse);
      expect(isPowerOfTwo(4), isTrue);
      expect(isPowerOfTwo(5), isFalse);
      expect(isPowerOfTwo(6), isFalse);
      expect(isPowerOfTwo(7), isFalse);
      expect(isPowerOfTwo(8), isTrue);
      expect(isPowerOfTwo(10), isFalse);
      expect(isPowerOfTwo(12), isFalse);
      expect(isPowerOfTwo(16), isTrue);
      expect(isPowerOfTwo(31), isFalse);
      expect(isPowerOfTwo(64), isTrue);
      expect(isPowerOfTwo(1024), isTrue);
      expect(isPowerOfTwo(1023), isFalse);
    });
  });
}
