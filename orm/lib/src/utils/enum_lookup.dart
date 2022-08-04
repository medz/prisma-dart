T? enumLookup<T extends Enum>({
  required Iterable<T> values,
  required dynamic json,
  T? defaultValue,
}) {
  for (final value in values) {
    if (value.name == json) {
      return value;
    }
  }

  return defaultValue;
}

enum Demo {
  a,
  b,
  c,
}
