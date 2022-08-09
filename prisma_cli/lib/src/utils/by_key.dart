Iterable<MapEntry<String, T>> keyBy<T>(
    List<T> collection, String Function(T) getKey) {
  return collection.map((e) => MapEntry(getKey(e), e));
}
