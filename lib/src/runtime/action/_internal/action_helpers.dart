import '../../input/input.dart';
import '../action.dart';
import '../action+from.dart';

extension ActionHelpers<U, T, O> on Action<U, T, O> {
  Action<U, T, O> fromWith(String name, Input input) {
    final arguments = input.$records.fold(this.arguments, (current, element) {
      final (keys, value) = element;
      final current = _MockInput()
        ..$records = [
          ([name, ...keys], value)
        ];

      return Input.deserialize(current, Map.from(this.arguments));
    });

    return from(arguments);
  }
}

class _MockInput implements Input {
  @override
  late final Iterable<(Iterable<String>, Object)> $records;
}
