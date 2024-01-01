import 'input.dart';

/// [Input] factory, creates a where from [keys] and [value].
typedef InputFactory<R extends Input> = R Function(
    Iterable<String> keys, dynamic value);

/// [Input] builder
class InputBuilder<
    ReturnType extends Input,

    /// Value Type
    Value extends Object,

    /// Model field reference type
    Ref,

    /// Allow match filter.
    Filter,

    /// Nullability of the value
    ///
    /// - [bool] is nullable
    /// - [Null] is not nullable
    Nulls> {
  final Iterable<String> keys;
  final InputFactory<ReturnType> factory;

  const InputBuilder(this.keys, this.factory);
}
