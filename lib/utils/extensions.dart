extension StringHelper on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}

extension IterableHelper<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int i, E e) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}
