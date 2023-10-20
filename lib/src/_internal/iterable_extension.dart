extension FirstWhereOrNull<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) text) {
    try {
      return firstWhere(text);
    } on StateError {
      return null;
    }
  }
}
