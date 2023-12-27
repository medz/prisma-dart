import 'input.dart';
import 'input_builder.dart';

/// Order by clause
enum SortOrder { asc, desc }

/// Nulls ordering
enum NullsOrder { first, last }

/// Order by builder
///
/// [R] - result type
/// [Nulls] - nulls ordering, If [Null] disables nulls ordering, otherwise
/// [NullsOrder] is used.
class OrderByBuilder<R extends Input, Nulls>
    extends InputBuilder<SortOrder, R, Nulls> {
  OrderByBuilder(super.keys, super.factory);

  /// Ascending order
  R get asc => factory(keys, SortOrder.asc);

  /// Descending order
  R get desc => factory(keys, SortOrder.desc);
}

extension OrderByBuilder$Call<R extends Input>
    on OrderByBuilder<R, NullsOrder> {
  /// Call with [NullsOrder]
  R call({required SortOrder sort, NullsOrder? nulls}) {
    return factory(keys, {
      'sort': sort,
      if (nulls != null) 'nulls': nulls,
    });
  }
}
