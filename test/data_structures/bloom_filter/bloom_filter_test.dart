import 'package:algorithmia/data_structures/bloom_filter/bloom_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BloomFilter', () {
    var bloomFilter = BloomFilter();
    const people = [
      'Bruce Wayne',
      'Clark Kent',
      'Barry Allen',
    ];

    setUp(() {
      bloomFilter = BloomFilter();
    });

    test('should hash deterministically with all 3 hash functions', () {
      const str1 = 'apple';

      expect(bloomFilter.hash1(str1), equals(bloomFilter.hash1(str1)));
      expect(bloomFilter.hash2(str1), equals(bloomFilter.hash2(str1)));
      expect(bloomFilter.hash3(str1), equals(bloomFilter.hash3(str1)));

      expect(bloomFilter.hash1(str1), equals(14));
      expect(bloomFilter.hash2(str1), equals(47));
      expect(bloomFilter.hash3(str1), equals(10));

      const str2 = 'orange';

      expect(bloomFilter.hash1(str2), equals(bloomFilter.hash1(str2)));
      expect(bloomFilter.hash2(str2), equals(bloomFilter.hash2(str2)));
      expect(bloomFilter.hash3(str2), equals(bloomFilter.hash3(str2)));

      expect(bloomFilter.hash1(str1), equals(14));
      expect(bloomFilter.hash2(str1), equals(47));
      expect(bloomFilter.hash3(str1), equals(10));
    });

    test('should create an array with 3 hash values', () {
      expect(bloomFilter.getHashValues('abc').length, equals(3));
      expect(bloomFilter.getHashValues('abc'), equals([66, 63, 54]));
    });

    test(
        'should insert strings correctly and return true when checking for inserted values',
        () {
      for (var person in people) {
        bloomFilter.insert(person);
      }

      expect(bloomFilter.mayContain('Bruce Wayne'), isTrue);
      expect(bloomFilter.mayContain('Clark Kent'), isTrue);
      expect(bloomFilter.mayContain('Barry Allen'), isTrue);

      expect(bloomFilter.mayContain('Tony Stark'), isFalse);
    });
  });
}
