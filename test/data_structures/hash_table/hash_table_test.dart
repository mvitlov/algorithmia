import 'package:flutter_test/flutter_test.dart';
import 'package:algorithmia/data_structures/hash_table/hash_table.dart';

void main() {
  group('HashTable', () {
    test('should create hash table of certain size', () {
      final defaultHashTable = HashTable();
      expect(defaultHashTable.buckets.length, equals(32));

      final biggerHashTable = HashTable(64);
      expect(biggerHashTable.buckets.length, equals(64));
    });

    test('should generate proper hash for specified keys', () {
      final hashTable = HashTable();

      expect(hashTable.hash('a'), equals(1));
      expect(hashTable.hash('b'), equals(2));
      expect(hashTable.hash('abc'), equals(6));
    });

    test('should set, read and delete data with collisions', () {
      final hashTable = HashTable<String>(3);

      expect(hashTable.hash('a'), equals(1));
      expect(hashTable.hash('b'), equals(2));
      expect(hashTable.hash('c'), equals(0));
      expect(hashTable.hash('d'), equals(1));

      hashTable.set('a', 'sky-old');
      hashTable.set('a', 'sky');
      hashTable.set('b', 'sea');
      hashTable.set('c', 'earth');
      hashTable.set('d', 'ocean');

      expect(hashTable.has('x'), isFalse);
      expect(hashTable.has('b'), isTrue);
      expect(hashTable.has('c'), isTrue);

      String stringifier(MapEntry<String, String> value) => '${value.key}:${value.value}';

      expect(hashTable.buckets[0].toString(stringifier), equals('(c:earth)'));
      expect(hashTable.buckets[1].toString(stringifier), equals('(a:sky, d:ocean)'));
      expect(hashTable.buckets[2].toString(stringifier), equals('(b:sea)'));

      expect(hashTable.get('a'), equals('sky'));
      expect(hashTable.get('d'), equals('ocean'));
      expect(hashTable.get('x'), isNull);

      hashTable.delete('a');

      expect(hashTable.delete('not-existing'), isNull);

      expect(hashTable.get('a'), isNull);
      expect(hashTable.get('d'), equals('ocean'));

      hashTable.set('d', 'ocean-new');
      expect(hashTable.get('d'), equals('ocean-new'));
    });

    test('should be possible to add objects to hash table', () {
      final hashTable = HashTable();

      hashTable.set('objectKey', {'prop1': 'a', 'prop2': 'b'});

      final object = hashTable.get('objectKey');
      expect(object, isNotNull);
      expect(object['prop1'], equals('a'));
      expect(object['prop2'], equals('b'));
    });

    test('should track actual keys', () {
      final hashTable = HashTable<String>(3);

      hashTable.set('a', 'sky-old');
      hashTable.set('a', 'sky');
      hashTable.set('b', 'sea');
      hashTable.set('c', 'earth');
      hashTable.set('d', 'ocean');

      expect(hashTable.getKeys(), equals(['a', 'b', 'c', 'd']));
      expect(hashTable.has('a'), isTrue);
      expect(hashTable.has('x'), isFalse);

      hashTable.delete('a');

      expect(hashTable.has('a'), isFalse);
      expect(hashTable.has('b'), isTrue);
      expect(hashTable.has('x'), isFalse);
    });

    test('should get all the values', () {
      final hashTable = HashTable(3);

      hashTable.set('a', 'alpha');
      hashTable.set('b', 'beta');
      hashTable.set('c', 'gamma');

      expect(hashTable.getValues(), equals(['gamma', 'alpha', 'beta']));
    });

    test('should get all the values from empty hash table', () {
      final hashTable = HashTable();
      expect(hashTable.getValues(), equals([]));
    });

    test('should get all the values in case of hash collision', () {
      final hashTable = HashTable(3);

      // Keys `ab` and `ba` in current implementation should result in one hash (one bucket).
      // We need to make sure that several items from one bucket will be serialized.
      hashTable.set('ab', 'one');
      hashTable.set('ba', 'two');

      hashTable.set('ac', 'three');

      expect(hashTable.getValues(), equals(['one', 'two', 'three']));
    });
  });
}
