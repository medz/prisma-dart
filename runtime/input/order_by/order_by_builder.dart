import '../input.dart';
import '../input_builder.dart';
import 'sort_order.dart';

class OrderByBuilder<R extends Input> extends InputBuilder<Null, R, Null> {
  OrderByBuilder(super.keys, super.factory);

  /// Ascending order
  R get asc => factory(keys, SortOrder.asc);

  /// Descending order
  R get desc => factory(keys, SortOrder.desc);
}
