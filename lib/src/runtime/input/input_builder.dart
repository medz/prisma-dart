import 'input.dart';

/// [Input] factory, creates a where from [keys] and [value].
typedef InputFactory<R extends Input> = R Function(
    Iterable<String> keys, Object value);

/// [Input] builder
///
/// - [T] is the type of the value.
/// - [R] is the type of the [Input] created by the [factory].
/// - [N] is nullable flag, if [bool] then the [T] is nullable, [Null]
///   otherwise. **Note:** Only allowed values are [bool] and [Null].
class InputBuilder<T extends Object?, R extends Input, N> {
  final Iterable<String> keys;
  final InputFactory<R> factory;

  const InputBuilder(this.keys, this.factory);
}
