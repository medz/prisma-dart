library prisma.client.types; // ignore_for_file: no_leading_underscores_for_library_prefixes

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

enum UserScalar implements _i1.PrismaEnum {
  id('id'),
  name('name'),
  role('role'),
  price('price'),
  size('size'),
  bytes('bytes'),
  json('json'),
  age('age'),
  demo('demo'),
  createdAt('createdAt');

  const UserScalar(this._prismaEnumName);

  final String _prismaEnumName;

  @override
  String toPrismaEnumName() => _prismaEnumName;
}

enum PostScalar implements _i1.PrismaEnum {
  id('id'),
  title('title'),
  userId('userId');

  const PostScalar(this._prismaEnumName);

  final String _prismaEnumName;

  @override
  String toPrismaEnumName() => _prismaEnumName;
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
