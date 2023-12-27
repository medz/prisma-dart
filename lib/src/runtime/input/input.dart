abstract class Input {
  /// Current input records storage for keys-value pairs.
  final Iterable<(Iterable<String> keys, dynamic value)> $records;

  /// Creates an input with single keys-value pair.
  Input(Iterable<String> keys, dynamic value) : $records = [(keys, value)];
}
