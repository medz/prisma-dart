import '../../input/input.dart';
import '../action.dart';
import '../action+from.dart';

extension ActionHelpers<U, T, O> on Action<U, T, O> {
  Action<U, T, O> fromWith(String name, Input input) {
    final arguments = input.$records.fold(this.arguments, (current, element) {
      final (keys, value) = element;
      return current.mergeWithCreate([name, ...keys], value);
    });

    return from(arguments);
  }

  Map<String, dynamic> deserializeInput(Input input) => input.$records.fold({},
      (current, element) => current.mergeWithCreate(element.$1, element.$2));
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
