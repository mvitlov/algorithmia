// It is the same as min heap except that when comparing two elements
// we take into account its priority instead of the element's value.
import 'package:algorithmia/data_structures/heap/min_heap.dart';
import 'package:algorithmia/utils/comparator.dart';

class PriorityQueue<T> extends MinHeap<T> {
  late final Map<T, int> priorities;
  PriorityQueue() : super() {
    // Call MinHip constructor first.
    // super();

    // Setup priorities map.
    this.priorities = new Map();

    // Use custom comparator for heap elements that will take element priority
    // instead of element value into account.
    this.compare = new Comparator<T>(this.comparePriority);
  }

  /**
   * Add item to the priority queue.
   * @param {*} item - item we're going to add to the queue.
   * @param {number} [priority] - items priority.
   * @return {PriorityQueue}
   */
  PriorityQueue<T> enqueue(T item, [priority = 0]) {
    this.priorities[item] = priority;
    super.add(item, allowDuplicate: false);
    return this;
  }

  /**
   * Remove item from priority queue.
   * @param {*} item - item we're going to remove.
   * @param {Comparator} [customFindingComparator] - custom function for finding the item to remove
   * @return {PriorityQueue}
   */
  PriorityQueue<T> remove(T item, [Comparator<T>? customFindingComparator]) {
    super.remove(item, customFindingComparator);
    this.priorities.remove(item);
    return this;
  }

  @override
  T? poll() {
    var item = super.poll();

    if (item != null) {
      this.priorities.remove(item);
    }
    return item;
  }

  /**
   * Change priority of the item in a queue.
   * @param {*} item - item we're going to re-prioritize.
   * @param {number} priority - new item's priority.
   * @return {PriorityQueue}
   */
  PriorityQueue<T> changePriority(item, priority) {
    this.remove(item, new Comparator(this.compareValue));
    this.enqueue(item, priority);
    return this;
  }

  /**
   * Find item by ite value.
   * @param {*} item
   * @return {Number[]}
   */
  List<int> findByValue(T item) {
    return this.find(item, new Comparator(this.compareValue));
  }

  /**
   * Check if item already exists in a queue.
   * @param {*} item
   * @return {boolean}
   */
  hasValue(item) {
    return this.findByValue(item).length > 0;
  }

  /**
   * Compares priorities of two items.
   * @param {*} a
   * @param {*} b
   * @return {number}
   */
  int comparePriority(T a, T b) {
    if (this.priorities[a] == this.priorities[b]) {
      return 0;
    }
    return this.priorities[a]! < this.priorities[b]! ? -1 : 1;
  }

  /**
   * Compares values of two items.
   * @param {*} a
   * @param {*} b
   * @return {number}
   */
  int compareValue(T a, T b) {
    if (a == b) {
      return 0;
    }
    return Comparator<T>().defaultCompareFunction(a, b);
  }
}
