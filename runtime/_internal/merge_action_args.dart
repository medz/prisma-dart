import '../action.dart';
import '../json_convertible.dart';

class ValueReplement<T> implements JsonConvertible<T> {
  final T value;

  const ValueReplement(this.value);

  @override
  T toJson() => value;
}

extension MergeActionArgs<T, P> on Action<T, P> {
  Action<T, P> merge(Map<String, dynamic> updates) {
    return Action(
      model,
      action,
      args: args.merge(updates),
      deserialize: deserialize,
    );
  }
}

extension<K, V> on Map<K, V> {
  Map<K, V> merge(Map<K, V> updates) {
    final result = Map<K, V>.from(this);
    for (final entry in updates.entries) {
      final source = result[entry.key];
      result[entry.key] = switch (entry.value) {
        ValueReplement(value: final value) => value,
        Map value => source is Map ? source.merge(value) : value,
        Iterable value => source is Iterable ? source.merge(value) : value,
        _ => entry.value,
      };
    }

    return result;
  }
}

extension<T> on Iterable<T> {
  Iterable<T> merge(Iterable<T> updates) {
    return [...this, ...updates];
  }
}
