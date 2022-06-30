class FenwickTree {
  final int _arraySize;
  late final List<int> _treeArray;

  FenwickTree(this._arraySize) {
    // Fill tree array with zeros.
    _treeArray = List.generate(_arraySize + 1, (_) => 0);
  }

  FenwickTree increase(int position, int value) {
    if (position < 1 || position > _arraySize) {
      throw Exception('Position is out of allowed range');
    }

    for (var i = position; i <= _arraySize; i += (i & -i)) {
      _treeArray[i] += value;
    }

    return this;
  }

  int query(int position) {
    if (position < 1 || position > _arraySize) {
      throw Exception('Position is out of allowed range');
    }

    var sum = 0;

    for (var i = position; i > 0; i -= (i & -i)) {
      sum += _treeArray[i];
    }

    return sum;
  }

  int queryRange(int leftIndex, int rightIndex) {
    if (leftIndex > rightIndex) {
      throw Exception('Left index can not be greater than right one');
    }

    if (leftIndex == 1) {
      return query(rightIndex);
    }

    return query(rightIndex) - query(leftIndex - 1);
  }

  int get length => _treeArray.length;

  int valueAt(int index) => _treeArray[index];

  List<int> get values => [..._treeArray];
}
