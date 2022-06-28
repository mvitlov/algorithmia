import 'heap.dart';

class MinHeap<T> extends Heap<T> {
  /// Checks if pair of heap elements is in correct order.
  /// For MinHeap the first element must be always smaller or equal.
  /// For MaxHeap the first element must be always bigger or equal.
  @override
  bool pairIsInCorrectOrder(T firstElement, T secondElement) {
    return compare.lessThanOrEqual(firstElement, secondElement);
  }
}
