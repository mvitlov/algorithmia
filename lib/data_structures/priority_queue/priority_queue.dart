import 'package:algorithmia/data_structures/heap/min_heap.dart';
import 'package:algorithmia/utils/comparator.dart';

class PriorityQueue<T> extends MinHeap<T> {
  late final Map<T, int> priorities;
  PriorityQueue() : super() {
    // Setup priorities map.
    priorities = <T, int>{};

    // Use custom comparator for heap elements that will take element priority
    // instead of element value into account.
    compare = Comparator<T>(comparePriority);
  }

  PriorityQueue<T> enqueue(T item, [priority = 0]) {
    priorities[item] = priority;
    super.add(item, allowDuplicate: false);
    return this;
  }

  PriorityQueue<T> dequeue(T item, [Comparator<T>? comparator]) {
    super.remove(item, comparator);
    priorities.remove(item);
    return this;
  }

  @override
  T? poll() {
    var item = super.poll();

    if (item != null) {
      priorities.remove(item);
    }
    return item;
  }

  PriorityQueue<T> changePriority(T item, int priority) {
    remove(item, Comparator(compareValue));
    enqueue(item, priority);
    return this;
  }

  List<int> findByValue(T item) {
    return find(item, Comparator(compareValue));
  }

  bool hasValue(T item) {
    return findByValue(item).isNotEmpty;
  }

  int comparePriority(T a, T b) {
    if (priorities[a] == priorities[b]) {
      return 0;
    }
    return priorities[a]! < priorities[b]! ? -1 : 1;
  }

  int compareValue(T a, T b) {
    return Comparator<T>().defaultCompareFunction(a, b);
  }
}
