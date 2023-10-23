import 'package:orm/orm.dart';

enum UserScalar<T> implements FieldRef<T> {
  id<String>('User', '_id'),
  age<int>('User', 'age'),
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

class UserWhereInput extends WhereInput {
  const UserWhereInput(super.where);

  static WhereInputBuilder<UserWhereInput, String, FieldRef<String>, Never>
      get id => WhereInputBuilder();

  static WhereInputBuilder<UserWhereInput, int, Never, Never> get age =>
      WhereInputBuilder();

  static WhereInputBuilder<UserWhereInput, String, Never,
      FieldRef<Iterable<String>>> get tags => WhereInputBuilder();
}

abstract class WhereInput implements JsonConvertible<Map<String, dynamic>> {
  final Map<String, dynamic> _where;

  const WhereInput(Map<String, dynamic> where) : _where = where;

  @override
  Map<String, dynamic> toJson() => _where;
}

class WhereInputBuilder<R, T, F1, F2> {
  R call(T value) {
    throw UnimplementedError();
  }
}

extension StringFillter<R, F1, F2> on WhereInputBuilder<R, String, F1, F2> {
  FillterOperation<R, String, F1> get equals =>
      FillterOperation<R, String, F1>();

  FillterOperation<R, Iterable<String>, F2> get $in =>
      FillterOperation<R, Iterable<String>, F2>();
}

class FillterOperation<R, T, F> {
  R call(T value) {
    throw UnimplementedError();
  }
}

extension FieldRefFillterOperationExtension<R, T>
    on FillterOperation<R, T, FieldRef<T>> {
  R ref(FieldRef<T> ref) {
    throw UnimplementedError();
  }
}

void main() {
  UserWhereInput.id('1');
  UserWhereInput.age(2);

  UserWhereInput.id.equals.hashCode;

  final a = UserWhereInput.id.equals.ref(UserScalar.id);
  final b = UserWhereInput.id.equals('1');

  final c = UserWhereInput.tags.$in(['1', '2']);
  final d = UserWhereInput.tags.$in.ref(UserScalar.tags);
}
