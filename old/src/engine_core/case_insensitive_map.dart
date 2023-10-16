import 'dart:collection' as collection;

abstract class CaseInsensitiveMap<K, V> extends collection.MapBase<K, V> {
  /// Creates a new instance of [CaseInsensitiveMap].
  CaseInsensitiveMap(Map<K, V> store)
      : _store = store.map((key, value) => MapEntry(_serializeKey(key), value));

  /// Stores the key-value pairs.
  final Map<K, V> _store;

  @override
  V? operator [](Object? key) => _store[_serializeKey<Object?>(key)];

  @override
  void operator []=(K key, V value) => _store[_serializeKey(key)] = value;

  @override
  void clear() => _store.clear();

  @override
  Iterable<K> get keys => _store.keys.map((e) => _serializeKey(e));

  @override
  V? remove(Object? key) => _store.remove(_serializeKey(key));

  /// Serializes the key.
  static T _serializeKey<T>(T key) {
    return (key is String ? key.toLowerCase() : key) as T;
  }
}
