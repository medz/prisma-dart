import '../operation.dart';
import '../where_builder.dart';

extension EnumFilter<R, T extends Enum, N> on WhereBuilder<R, T, N> {
  Operation<R, T, N> get equals => Operation.create('equals', factory);
  Operation<R, Iterable<T>, N> get $in => Operation.create('in', factory);
  Operation<R, Iterable<T>, N> get notIn => Operation.create('notIn', factory);
  WhereBuilder<R, T, N> get not => WhereBuilder.create('not', factory);
}
