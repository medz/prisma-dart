import '../operation.dart';
import '../where_builder.dart';

extension DateTimeFilter<R, N> on WhereBuilder<R, DateTime, N> {
  Operation<R, String, N> get equals => Operation.create('equals', factory);
  Operation<R, Iterable<String>, N> get $in => Operation.create('in', factory);
  Operation<R, Iterable<String>, N> get notIn =>
      Operation.create('not_in', factory);
  Operation<R, DateTime, N> get lt => Operation.create('lt', factory);
  Operation<R, DateTime, N> get lte => Operation.create('lte', factory);
  Operation<R, DateTime, N> get gt => Operation.create('gt', factory);
  Operation<R, DateTime, N> get gte => Operation.create('gte', factory);
  WhereBuilder<R, DateTime, N> get not => WhereBuilder.create('not', factory);
}
