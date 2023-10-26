extension DeepMergeMap<K, V> on Map<K, V> {
  Map<K, V> deepMerge(Map<K, V> other) {
    final result = Map<K, V>.from(this);
    for (final MapEntry(key: key, value: value) in other.entries) {
      if (value is Map && result[key] is Map) {
        result[key] = (result[key] as Map).deepMerge(value) as V;
        continue;
      }

      result[key] = value;
    }

    return result;
  }
}
