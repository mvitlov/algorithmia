import 'package:algorithmia/algorithms/math/is_power_of_two/is_power_of_two_bitwise.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isPowerOfTwoBitwise', () {
    test('should check if the number is made by multiplying twos', () {
      expect(isPowerOfTwoBitwise(-1), isFalse);
      expect(isPowerOfTwoBitwise(0), isFalse);
      expect(isPowerOfTwoBitwise(1), isTrue);
      expect(isPowerOfTwoBitwise(2), isTrue);
      expect(isPowerOfTwoBitwise(3), isFalse);
      expect(isPowerOfTwoBitwise(4), isTrue);
      expect(isPowerOfTwoBitwise(5), isFalse);
      expect(isPowerOfTwoBitwise(6), isFalse);
      expect(isPowerOfTwoBitwise(7), isFalse);
      expect(isPowerOfTwoBitwise(8), isTrue);
      expect(isPowerOfTwoBitwise(10), isFalse);
      expect(isPowerOfTwoBitwise(12), isFalse);
      expect(isPowerOfTwoBitwise(16), isTrue);
      expect(isPowerOfTwoBitwise(31), isFalse);
      expect(isPowerOfTwoBitwise(64), isTrue);
      expect(isPowerOfTwoBitwise(1024), isTrue);
      expect(isPowerOfTwoBitwise(1023), isFalse);
    });
  });
}
