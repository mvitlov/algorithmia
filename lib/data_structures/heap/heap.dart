import 'package:algorithmia/utils/comparator.dart';

class Heap<T> {
  late final List<T> heapContainer;
  late Comparator<T> compare;
  Heap([CompareFunction<T>? compareFunction]) {
    heapContainer = <T>[];
    compare = Comparator(compareFunction);
  }

  int getLeftChildIndex(int parentIndex) {
    return (2 * parentIndex) + 1;
  }

  int getRightChildIndex(int parentIndex) {
    return (2 * parentIndex) + 2;
  }

  int getParentIndex(int childIndex) {
    return ((childIndex - 1) / 2).floor();
  }

  bool hasParent(int childIndex) {
    return getParentIndex(childIndex) >= 0;
  }

  bool hasLeftChild(int parentIndex) {
    return getLeftChildIndex(parentIndex) < heapContainer.length;
  }

  bool hasRightChild(int parentIndex) {
    return getRightChildIndex(parentIndex) < heapContainer.length;
  }

  T? leftChild(int parentIndex) {
    return heapContainer[getLeftChildIndex(parentIndex)];
  }

  T? rightChild(int parentIndex) {
    return heapContainer[getRightChildIndex(parentIndex)];
  }

  T? parent(int childIndex) {
    try {
      return heapContainer[getParentIndex(childIndex)];
    } catch (e) {
      return null;
    }
  }

  void swap(int indexOne, int indexTwo) {
    final tmp = heapContainer[indexTwo];
    heapContainer[indexTwo] = heapContainer[indexOne];
    heapContainer[indexOne] = tmp;
  }

  T? peek() {
    if (heapContainer.isEmpty) {
      return null;
    }

    return heapContainer.first;
  }

  T? poll() {
    if (heapContainer.isEmpty) {
      return null;
    }

    if (heapContainer.length == 1) {
      return heapContainer.removeLast();
    }

    final item = heapContainer.first;

    // Move the last element from the end to the head.
    heapContainer[0] = heapContainer.removeLast();
    heapifyDown();

    return item;
  }

  Heap<T> add(T item, {allowDuplicate = true}) {
    if (heapContainer.contains(item)) {
      if (allowDuplicate) {
        heapContainer.add(item);
      }
    } else {
      heapContainer.add(item);
    }

    heapifyUp();
    return this;
  }

  Heap<T> remove(T item, [Comparator<T>? comparator]) {
    comparator ??= compare;
    // Find number of items to remove.
    final numberOfItemsToRemove = find(item, comparator).length;

    for (var iteration = 0; iteration < numberOfItemsToRemove; iteration += 1) {
      // We need to find item index to remove each time after removal since
      // indices are being changed after each heapify process.
      final indexToRemove = find(item, comparator).removeLast();

      // If we need to remove last child in the heap then just remove it.
      // There is no need to heapify the heap afterwards.
      if (indexToRemove == (heapContainer.length - 1)) {
        heapContainer.removeLast();
      } else {
        // Move last element in heap to the vacant (removed) position.
        heapContainer[indexToRemove] = heapContainer.removeLast();

        // Get parent.
        final parentItem = parent(indexToRemove);

        // If there is no parent or parent is in correct order with the node
        // we're going to delete then heapify down. Otherwise heapify up.
        if (hasLeftChild(indexToRemove) &&
            (parentItem == null || pairIsInCorrectOrder(parentItem, heapContainer[indexToRemove]))) {
          heapifyDown(indexToRemove);
        } else {
          heapifyUp(indexToRemove);
        }
      }
    }

    return this;
  }

  List<int> find(T item, [Comparator<T>? comparator]) {
    comparator ??= compare;
    final foundItemIndices = <int>[];

    for (var itemIndex = 0; itemIndex < heapContainer.length; itemIndex += 1) {
      try {
        if (comparator.equal(item, heapContainer[itemIndex])) {
          foundItemIndices.add(itemIndex);
        }
      } catch (e) {
        // eat error
      }
    }

    return foundItemIndices;
  }

  bool isEmpty() {
    return heapContainer.isEmpty;
  }

  void heapifyUp([int? customStartIndex]) {
    // Take the last element (last in array or the bottom left in a tree)
    // in the heap container and lift it up until it is in the correct
    // order with respect to its parent element.
    var currentIndex = customStartIndex ?? heapContainer.length - 1;

    while (hasParent(currentIndex) && !pairIsInCorrectOrder(parent(currentIndex) as T, heapContainer[currentIndex])) {
      swap(currentIndex, getParentIndex(currentIndex));
      currentIndex = getParentIndex(currentIndex);
    }
  }

  void heapifyDown([int customStartIndex = 0]) {
    // Compare the parent element to its children and swap parent with the appropriate
    // child (smallest child for MinHeap, largest child for MaxHeap).
    // Do the same for next children after swap.
    var currentIndex = customStartIndex;
    int nextIndex;

    while (hasLeftChild(currentIndex)) {
      if (hasRightChild(currentIndex) &&
          pairIsInCorrectOrder(rightChild(currentIndex) as T, leftChild(currentIndex) as T)) {
        nextIndex = getRightChildIndex(currentIndex);
      } else {
        nextIndex = getLeftChildIndex(currentIndex);
      }

      if (pairIsInCorrectOrder(
        heapContainer[currentIndex],
        heapContainer[nextIndex],
      )) {
        break;
      }

      swap(currentIndex, nextIndex);
      currentIndex = nextIndex;
    }
  }

  /// Checks if pair of heap elements is in correct order.
  /// For [MinHeap] the first element must be always smaller or equal.
  /// For [MaxHeap] the first element must be always bigger or equal.
  bool pairIsInCorrectOrder(T firstElement, T secondElement) {
    throw Exception('You have to implement heap pair comparision method for $firstElement and $secondElement values.');
  }

  @override
  String toString() {
    return heapContainer.join(',');
  }
}
