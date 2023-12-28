import '../input.dart';
import '../input_builder.dart';

/// Where input builder, used to create a where.
///
/// - [Where]: Where type
/// - [Value]: Value type, not allow nullable object type.
/// - [Ref]: Model field reference type
///   - [Null] not allow model field reference
///   - [Ref] extends [Reference] allows model field reference.
/// - [Nullable]: Nullability of the value
///   - [bool] is nullable
///   - [Null] is required
/// - [Filter]
///   - [bool] allow with [Value] matched filter
///   - [Null] disabled filter
class WhereBuilder<

    /// Where Type
    Where extends Input,

    /// Value Type
    Value extends Object,

    /// Model field reference type
    Ref,

    /// Allow match filter.
    Filter,

    /// Nullability of the value
    ///
    /// - Anything object is nullable
    /// - Null is nullable
    Nullable> extends InputBuilder<Value, Where, Nullable> {
  const WhereBuilder(super.keys, super.factory);
}
