extension WithoutNullsMap<K, V> on Map<K, V> {
  /// Without null values.
  Map<K, V> get withoutNulls => Map.fromEntries(
        entries.where((e) => e.value != null),
      );
}

extension WithoutNullsIterable<T> on Iterable<T> {
  /// Without null values.
  Iterable<T> get withoutNulls => where((element) => element != null);

  /// As Map
  Map<int, T> asMap() {
    return Map.fromIterables(Iterable<int>.generate(length), this);
  }

  /// Where first or null
  T? firstWhereOrNull(bool Function(T element) test) {
    try {
      return firstWhere(test);
    } on StateError {
      return null;
    }
  }
}
