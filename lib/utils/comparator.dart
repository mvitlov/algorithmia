typedef CompareFunction<T> = int Function(T a, T b);

class Comparator<T> {
  late CompareFunction<T> compare;

  Comparator([CompareFunction<T>? compareFunction]) {
    compare = compareFunction ?? defaultCompareFunction;
  }

  /// Limited default comparison function that can handle following types:
  ///
  /// - `MapEntry` - comparison based on `key` (can be `String` or `num` type)
  /// - `String`
  /// - `num` (`int` or `double`)
  int defaultCompareFunction(T a, T b) {
    if (a == b) {
      return 0;
    }

    if (a is MapEntry && b is MapEntry) {
      if (a.key is String && b.key is String) {
        return _compareString(a.key, b.key);
      } else if (a.key is num && b.key is num) {
        return _compareNum(a.key, b.key);
      }
    } else if (a is num && b is num) {
      return _compareNum(a, b);
    } else if (a is String && b is String) {
      return _compareString(a, b);
    }

    throw Exception('Cannot compare ${a.runtimeType} with ${b.runtimeType}. Please provide custom compare function.');
  }

  int _compareNum(num a, num b) => a < b ? -1 : 1;

  int _compareString(String a, String b) => a.compareTo(b);

  bool equal(T a, T b) => compare(a, b) == 0;

  bool lessThan(T a, T b) => compare(a, b) < 0;

  bool greaterThan(T a, T b) => compare(a, b) > 0;

  bool lessThanOrEqual(T a, T b) => lessThan(a, b) || equal(a, b);

  bool greaterThanOrEqual(T a, T b) => greaterThan(a, b) || equal(a, b);

  void reverse() {
    final compareOriginal = compare;
    compare = (T a, T b) => compareOriginal(b, a);
  }
}
