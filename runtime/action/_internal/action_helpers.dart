import '../../input/input.dart';
import '../action.dart';
import '../action+from.dart';

extension ActionHelpers<$1, $2, $3, $4, Cursor, Pagination, Distinct>
    on Action<$1, $2, $3, $4, Cursor, Pagination, Distinct> {
  Action<$1, $2, $3, $4, Cursor, Pagination, Distinct> fromWith(
      String name, Input input) {
    final arguments = this
        .arguments
        .mergeWithCreate([name, ...input.$_keys_], input.$_value_);

    return from(arguments);
  }

  Map<String, dynamic> deserializeInput(Input input) =>
      <String, dynamic>{}.mergeWithCreate(input.$_keys_, input.$_value_);
}

extension<V> on Map<String, V> {
  /// Returns deep merged map.
  Map<String, V> mergeWithCreate(Iterable<String> keys, V value) {
    if (keys.isEmpty) return this;
    if (keys.length == 1) {
      return {...this, keys.last: value};
    }

    final arguments = Map<String, V>.from(this);
    Map current = arguments;

    for (final (index, key) in keys.indexed) {
      if (index == keys.length - 1) {
        current[key] = value;
        break;
      }

      current = current[key] = switch (current[key]) {
        Map value => value,
        _ => {},
      };
    }

    return arguments;
  }
}
