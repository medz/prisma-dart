import '../../core/null_types.dart';
import '../../core/prisma_json.dart';
import '../../core/prisma_null.dart';
import '../operation.dart';
import '../where_builder.dart';

extension JsonFilter<R> on WhereBuilder<R, PrismaJson, Null> {
  Operation<R, PrismaJson, NullTypes> get equals =>
      Operation.create('equals', factory);
  Operation<R, String, Null> get stringContains =>
      Operation.create('string_contains', factory);
  Operation<R, String, Null> get stringStartsWith =>
      Operation.create('string_starts_with', factory);
  Operation<R, String, Null> get stringEndsWith =>
      Operation.create('string_ends_with', factory);
  Operation<R, Object, PrismaNull> get arrayContains =>
      Operation.create('array_contains', factory);
  Operation<R, Object, PrismaNull> get arrayStartsWith =>
      Operation.create('array_starts_with', factory);
  Operation<R, Object, PrismaNull> get arrayEndsWith =>
      Operation.create('array_ends_with', factory);
  Operation<R, Object, Null> get lt => Operation.create('lt', factory);
  Operation<R, Object, Null> get lte => Operation.create('lte', factory);
  Operation<R, Object, Null> get gt => Operation.create('gt', factory);
  Operation<R, Object, Null> get gte => Operation.create('gte', factory);

  WhereBuilder<R, PrismaJson, NullTypes> get not =>
      WhereBuilder.create('not', factory);

  R path(Iterable<String> path) => factory({'path': path});
}

extension JsonEqualsOperation<R, N> on Operation<R, PrismaJson, NullTypes> {
  R get dbNull => factory(const DbNull());
  R get jsonNull => factory(const JsonNull());
  R get anyNull => factory(const AnyNull());
}

extension JsonNullWhereBuilder<R> on WhereBuilder<R, PrismaJson, NullTypes> {
  R get dbNull => factory(const DbNull());
  R get jsonNull => factory(const JsonNull());
  R get anyNull => factory(const AnyNull());
}
