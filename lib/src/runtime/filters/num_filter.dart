import 'package:decimal/decimal.dart';

import '../operation.dart';
import '../where_builder.dart';

extension NumFilter<R, T extends num, N> on WhereBuilder<R, T, N> {
  Operation<R, T, N> get equals => Operation.create('equals', factory);
  Operation<R, Iterable<T>, N> get $in => Operation.create('in', factory);
  Operation<R, Iterable<T>, N> get notIn => Operation.create('notIn', factory);
  Operation<R, T, N> get lt => Operation.create('lt', factory);
  Operation<R, T, N> get lte => Operation.create('lte', factory);
  Operation<R, T, N> get gt => Operation.create('gt', factory);
  Operation<R, T, N> get gte => Operation.create('gte', factory);
  WhereBuilder<R, T, N> get not => WhereBuilder.create('not', factory);
}

extension BigIntFilter<R, N> on WhereBuilder<R, BigInt, N> {
  Operation<R, BigInt, N> get equals => Operation.create('equals', factory);
  Operation<R, Iterable<BigInt>, N> get $in => Operation.create('in', factory);
  Operation<R, Iterable<BigInt>, N> get notIn =>
      Operation.create('notIn', factory);
  Operation<R, BigInt, N> get lt => Operation.create('lt', factory);
  Operation<R, BigInt, N> get lte => Operation.create('lte', factory);
  Operation<R, BigInt, N> get gt => Operation.create('gt', factory);
  Operation<R, BigInt, N> get gte => Operation.create('gte', factory);
  WhereBuilder<R, BigInt, N> get not => WhereBuilder.create('not', factory);
}

extension DecimalFilter<R, N> on WhereBuilder<R, Decimal, N> {
  Operation<R, Decimal, N> get equals => Operation.create('equals', factory);
  Operation<R, Iterable<Decimal>, N> get $in => Operation.create('in', factory);
  Operation<R, Iterable<Decimal>, N> get notIn =>
      Operation.create('notIn', factory);
  Operation<R, Decimal, N> get lt => Operation.create('lt', factory);
  Operation<R, Decimal, N> get lte => Operation.create('lte', factory);
  Operation<R, Decimal, N> get gt => Operation.create('gt', factory);
  Operation<R, Decimal, N> get gte => Operation.create('gte', factory);
  WhereBuilder<R, Decimal, N> get not => WhereBuilder.create('not', factory);
}
