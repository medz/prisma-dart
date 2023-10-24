import 'package:decimal/decimal.dart';

import '../where_builder.dart';

class AggregatesFilter<R, T, N> extends WhereBuilder<R, T, N> {
  const AggregatesFilter(super.factory);

  WhereBuilder<R, int, N> get $count =>
      WhereBuilder((value) => factory({'_count': value}));
  WhereBuilder<R, T, N> get $min =>
      WhereBuilder((value) => factory({'_min': value}));
  WhereBuilder<R, T, N> get $max =>
      WhereBuilder((value) => factory({'_max': value}));
}

/// Aggregates filter for [num] types.
extension NumAggregatesFilter<R, T extends num, N>
    on AggregatesFilter<R, T, N> {
  WhereBuilder<R, double, N> get $avg =>
      WhereBuilder((value) => factory({'_avg': value}));
  WhereBuilder<R, int, N> get $sum =>
      WhereBuilder((value) => factory({'_sum': value}));
}

/// Aggregates filter for [BigInt] types.
extension BigIntAggregatesFilter<R, N> on AggregatesFilter<R, BigInt, N> {
  WhereBuilder<R, double, N> get $avg =>
      WhereBuilder((value) => factory({'_avg': value}));
  WhereBuilder<R, BigInt, N> get $sum =>
      WhereBuilder((value) => factory({'_sum': value}));
}

/// Aggregates filtter for [Decimal] types.
extension DecimalAggregatesFilter<R, N> on AggregatesFilter<R, Decimal, N> {
  WhereBuilder<R, Decimal, N> get $avg =>
      WhereBuilder((value) => factory({'_avg': value}));
  WhereBuilder<R, Decimal, N> get $sum =>
      WhereBuilder((value) => factory({'_sum': value}));
}
