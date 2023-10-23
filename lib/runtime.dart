import 'src/core/field_ref.dart';
import 'src/core/json_convertible.dart';
import 'src/core/prisma_null.dart';

//------------------ Type description ------------------
// R = Return type
// T = Value type
// N =
//     PrismaNull - generate `$null` field
//     Null - generate nothing
//------------------------------------------------------

abstract class CallWithFactory<R, T, N> {
  final R Function(dynamic) factory;
  const CallWithFactory(this.factory);

  R call(T value) => factory(value);
}

extension PrismaNullBuilder<R, T> on CallWithFactory<R, T, PrismaNull> {
  R get $null => factory(const PrismaNull());
}

class WhereBuilder<R, T, N> extends CallWithFactory<R, T, N> {
  const WhereBuilder(super.factory);
}

class FilterOperation<R, T, N> extends CallWithFactory<R, T, N> {
  const FilterOperation(super.factory);

  R ref(FieldRef<T> ref) => factory(ref);

  static FilterOperation<R, T, N> create<R, T, N>(
    String name,
    R Function(dynamic) factory,
  ) =>
      FilterOperation((value) => factory({name: value}));
}

extension StringFilter<R, N> on WhereBuilder<R, String, N> {
  FilterOperation<R, String, N> get equals =>
      FilterOperation.create('equals', factory);

  FilterOperation<R, Iterable<String>, N> get $in =>
      FilterOperation.create('in', factory);

  FilterOperation<R, Iterable<String>, N> get notIn =>
      FilterOperation.create('notIn', factory);

  FilterOperation<R, String, N> get lt => FilterOperation.create('lt', factory);

  FilterOperation<R, String, N> get lte =>
      FilterOperation.create('lte', factory);

  FilterOperation<R, String, N> get gt => FilterOperation.create('gt', factory);

  FilterOperation<R, String, N> get gte =>
      FilterOperation.create('gte', factory);

  FilterOperation<R, String, N> get contains =>
      FilterOperation.create('contains', factory);

  FilterOperation<R, String, N> get startsWith =>
      FilterOperation.create('startsWith', factory);

  FilterOperation<R, String, N> get endsWith =>
      FilterOperation.create('endsWith', factory);

  WhereBuilder<R, String, N> get not =>
      WhereBuilder((value) => factory({'not': value}));
}

class UserWhereInput implements JsonConvertible<Map<String, dynamic>> {
  final String name;
  final dynamic value;

  const UserWhereInput(this.name, this.value);

  @override
  Map<String, dynamic> toJson() => {name: value};

  static WhereBuilder<UserWhereInput, String, PrismaNull> get id =>
      WhereBuilder((value) => UserWhereInput('id', value));
}

enum UserScalar<T> implements FieldRef<T> {
  id<String>('User', '_id'),
  tags<Iterable<String>>('User', 'tags'),

  //------------------------------------------------
  ;
  //------------------------------------------------

  @override
  final String $name;

  @override
  final String $model;

  @override
  Type get $type => T;

  @override
  get $is => FieldRef.createIs<T>(this);

  const UserScalar(this.$model, this.$name);
}

void main() {
  print(UserWhereInput.id('1').toJson());
  print(UserWhereInput.id.$null.toJson());
  print(UserWhereInput.id.equals('1').toJson());
  print(UserWhereInput.id.equals.$null.toJson());
  print(UserWhereInput.id.equals.ref(UserScalar.id).toJson());
  print(UserWhereInput.id.$in(['1', '2']).toJson());
  print(UserWhereInput.id.$in.$null.toJson());
  print(UserWhereInput.id.$in.ref(UserScalar.tags).toJson());
  print(UserWhereInput.id.not.gt('1').toJson());
}
