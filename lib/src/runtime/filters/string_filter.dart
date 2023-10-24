import '../operation.dart';
import '../query_mode.dart';
import '../where_builder.dart';

/// Extension filter helpers for [String] type on [WhereBuilder].
extension StringFilter<R, N> on WhereBuilder<R, String, N> {
  Operation<R, String, N> get equals => Operation.create('equals', factory);
  Operation<R, Iterable<String>, N> get $in => Operation.create('in', factory);
  Operation<R, Iterable<String>, N> get notIn =>
      Operation.create('notIn', factory);
  Operation<R, String, N> get lt => Operation.create('lt', factory);
  Operation<R, String, N> get lte => Operation.create('lte', factory);
  Operation<R, String, N> get gt => Operation.create('gt', factory);
  Operation<R, String, N> get gte => Operation.create('gte', factory);
  Operation<R, String, N> get contains => Operation.create('contains', factory);
  Operation<R, String, N> get startsWith =>
      Operation.create('startsWith', factory);
  Operation<R, String, N> get endsWith => Operation.create('endsWith', factory);
  WhereBuilder<R, String, N> get not => WhereBuilder.create('not', factory);

  R mode(QueryMode mode) => factory({'mode': mode.value});
}
