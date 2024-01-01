abstract interface class Input {
  /// Current input records storage for keys-value pairs.
  Iterable<(Iterable<String> keys, Object value)> get $records;

  static Map<String, dynamic> deserialize(Input input,
      [Map<String, dynamic>? source]) {
    return input.$records.fold(
      source ?? {},
      (current, element) => current.mergeWithCreate(element.$1, element.$2),
    );
  }

  static Map<String, dynamic> deserializeMultiple(Iterable<Input> inputs,
      [Map<String, dynamic>? source]) {
    return inputs.expand((element) => element.$records).fold(source ?? {},
        (current, element) => current.mergeWithCreate(element.$1, element.$2));
  }
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
