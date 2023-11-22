library prisma.client.types; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:typed_data' as _i2;

import 'package:orm/orm.dart' as _i1;

enum Role implements _i1.PrismaEnum {
  user('user'),
  owner('owner');

  const Role(this._prismaEnumName);

  final String _prismaEnumName;

  @override
  String toPrismaEnumName() => _prismaEnumName;
}

enum TransactionIsolationLevel implements _i1.PrismaEnum, _i1.IsolationLevel {
  readUncommitted('ReadUncommitted'),
  readCommitted('ReadCommitted'),
  repeatableRead('RepeatableRead'),
  serializable('Serializable');

  const TransactionIsolationLevel(this._prismaEnumName);

  final String _prismaEnumName;

  @override
  String toPrismaEnumName() => _prismaEnumName;
  @override
  String get value => _prismaEnumName;
}

enum UserScalar<T> implements _i1.PrismaEnum, _i1.FieldRef<T> {
  id<int>('id', 'User'),
  name<String>('name', 'User'),
  role<Role>('role', 'User'),
  price<_i1.Decimal>('price', 'User'),
  size<BigInt>('size', 'User'),
  bytes<_i2.Uint8List>('bytes', 'User'),
  json<_i1.PrismaJson>('json', 'User'),
  age<int>('age', 'User'),
  demo<double>('demo', 'User'),
  createdAt<DateTime>('createdAt', 'User');

  const UserScalar(
    this._prismaEnumName,
    this.modelName,
  );

  final String _prismaEnumName;

  @override
  final String modelName;

  @override
  String toPrismaEnumName() => _prismaEnumName;
  @override
  String get field => _prismaEnumName;
}

enum PostScalar<T> implements _i1.PrismaEnum, _i1.FieldRef<T> {
  id<String>('id', 'Post'),
  title<String>('title', 'Post'),
  userId<int>('userId', 'Post');

  const PostScalar(
    this._prismaEnumName,
    this.modelName,
  );

  final String _prismaEnumName;

  @override
  final String modelName;

  @override
  String toPrismaEnumName() => _prismaEnumName;
  @override
  String get field => _prismaEnumName;
}

enum SortOrder implements _i1.PrismaEnum {
  asc('asc'),
  desc('desc');

  const SortOrder(this._prismaEnumName);

  final String _prismaEnumName;

  @override
  String toPrismaEnumName() => _prismaEnumName;
}

enum NullableJsonNullValueInput implements _i1.PrismaEnum {
  dbNull('DbNull'),
  jsonNull('JsonNull');

  const NullableJsonNullValueInput(this._prismaEnumName);

  final String _prismaEnumName;

  @override
  String toPrismaEnumName() => _prismaEnumName;
}

enum QueryMode implements _i1.PrismaEnum {
  $default('default'),
  insensitive('insensitive');

  const QueryMode(this._prismaEnumName);

  final String _prismaEnumName;

  @override
  String toPrismaEnumName() => _prismaEnumName;
}

enum JsonNullValueFilter implements _i1.PrismaEnum {
  dbNull('DbNull'),
  jsonNull('JsonNull'),
  anyNull('AnyNull');

  const JsonNullValueFilter(this._prismaEnumName);

  final String _prismaEnumName;

  @override
  String toPrismaEnumName() => _prismaEnumName;
}

enum NullsOrder implements _i1.PrismaEnum {
  first('first'),
  last('last');

  const NullsOrder(this._prismaEnumName);

  final String _prismaEnumName;

  @override
  String toPrismaEnumName() => _prismaEnumName;
}
