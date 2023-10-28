// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:orm/orm.dart' as _i1;
import 'role.dart' as _i2;
import 'dart:typed_data' as _i3;

enum UserScalar<T> implements _i1.FieldRef<T> {
  id<int>('User', 'id'),
  name<String>('User', 'name'),
  role<_i2.Role>('User', 'role'),
  price<_i1.Decimal>('User', 'price'),
  size<BigInt>('User', 'size'),
  bytes<_i3.ByteBuffer>('User', 'bytes'),
  json<_i1.PrismaJson>('User', 'json'),
  age<int>('User', 'age'),
  demo<double>('User', 'demo'),
  createdAt<DateTime>('User', 'createdAt');

  const UserScalar(
    this.$model,
    this.$name,
  );

  @override
  final String $name;

  @override
  final String $model;

  @override
  Type get $type => T;
  @override
  bool Function(dynamic) get $is => _i1.FieldRef.createIs(this);
}
