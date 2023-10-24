import '../operation.dart';
import '../where_builder.dart';

extension BoolFilter<R, N> on WhereBuilder<R, bool, N> {
  Operation<R, bool, N> get equals => Operation.create('equals', factory);
  WhereBuilder<R, bool, N> get not => WhereBuilder.create('not', factory);
}
