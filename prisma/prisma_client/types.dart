// ignore_for_file: non_constant_identifier_names

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

class UserWhereInput {
  const UserWhereInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
    this.posts,
  });

  final _i1.PrismaUnion<UserWhereInput, Iterable<UserWhereInput>>? AND;

  final Iterable<UserWhereInput>? OR;

  final _i1.PrismaUnion<UserWhereInput, Iterable<UserWhereInput>>? NOT;

  final _i1.PrismaUnion<IntFilter, int>? id;

  final _i1.PrismaUnion<StringFilter, String>? name;

  final _i1.PrismaUnion<EnumRoleFilter, Role>? role;

  final _i1.PrismaUnion<DecimalFilter, _i1.Decimal>? price;

  final _i1.PrismaUnion<BigIntFilter, BigInt>? size;

  final _i1.PrismaUnion<BytesFilter, _i2.Uint8List>? bytes;

  final JsonNullableFilter? json;

  final _i1
      .PrismaUnion<IntNullableFilter, _i1.PrismaUnion<int, _i1.PrismaNull>>?
      age;

  final _i1.PrismaUnion<FloatFilter, double>? demo;

  final _i1.PrismaUnion<DateTimeFilter, DateTime>? createdAt;

  final PostListRelationFilter? posts;
}

class UserOrderByWithRelationInput {
  const UserOrderByWithRelationInput({
    this.id,
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
    this.posts,
  });

  final SortOrder? id;

  final SortOrder? name;

  final SortOrder? role;

  final SortOrder? price;

  final SortOrder? size;

  final SortOrder? bytes;

  final _i1.PrismaUnion<SortOrder, SortOrderInput>? json;

  final _i1.PrismaUnion<SortOrder, SortOrderInput>? age;

  final SortOrder? demo;

  final SortOrder? createdAt;

  final PostOrderByRelationAggregateInput? posts;
}

class UserWhereUniqueInput {
  const UserWhereUniqueInput({
    this.id,
    this.AND,
    this.OR,
    this.NOT,
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
    this.posts,
  });

  final int? id;

  final _i1.PrismaUnion<UserWhereInput, Iterable<UserWhereInput>>? AND;

  final Iterable<UserWhereInput>? OR;

  final _i1.PrismaUnion<UserWhereInput, Iterable<UserWhereInput>>? NOT;

  final _i1.PrismaUnion<StringFilter, String>? name;

  final _i1.PrismaUnion<EnumRoleFilter, Role>? role;

  final _i1.PrismaUnion<DecimalFilter, _i1.Decimal>? price;

  final _i1.PrismaUnion<BigIntFilter, BigInt>? size;

  final _i1.PrismaUnion<BytesFilter, _i2.Uint8List>? bytes;

  final JsonNullableFilter? json;

  final _i1
      .PrismaUnion<IntNullableFilter, _i1.PrismaUnion<int, _i1.PrismaNull>>?
      age;

  final _i1.PrismaUnion<FloatFilter, double>? demo;

  final _i1.PrismaUnion<DateTimeFilter, DateTime>? createdAt;

  final PostListRelationFilter? posts;
}

class UserOrderByWithAggregationInput {
  const UserOrderByWithAggregationInput({
    this.id,
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
    this.count,
    this.avg,
    this.max,
    this.min,
    this.sum,
  });

  final SortOrder? id;

  final SortOrder? name;

  final SortOrder? role;

  final SortOrder? price;

  final SortOrder? size;

  final SortOrder? bytes;

  final _i1.PrismaUnion<SortOrder, SortOrderInput>? json;

  final _i1.PrismaUnion<SortOrder, SortOrderInput>? age;

  final SortOrder? demo;

  final SortOrder? createdAt;

  final UserCountOrderByAggregateInput? count;

  final UserAvgOrderByAggregateInput? avg;

  final UserMaxOrderByAggregateInput? max;

  final UserMinOrderByAggregateInput? min;

  final UserSumOrderByAggregateInput? sum;
}

class UserScalarWhereWithAggregatesInput {
  const UserScalarWhereWithAggregatesInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
  });

  final _i1.PrismaUnion<UserScalarWhereWithAggregatesInput,
      Iterable<UserScalarWhereWithAggregatesInput>>? AND;

  final Iterable<UserScalarWhereWithAggregatesInput>? OR;

  final _i1.PrismaUnion<UserScalarWhereWithAggregatesInput,
      Iterable<UserScalarWhereWithAggregatesInput>>? NOT;

  final _i1.PrismaUnion<IntWithAggregatesFilter, int>? id;

  final _i1.PrismaUnion<StringWithAggregatesFilter, String>? name;

  final _i1.PrismaUnion<EnumRoleWithAggregatesFilter, Role>? role;

  final _i1.PrismaUnion<DecimalWithAggregatesFilter, _i1.Decimal>? price;

  final _i1.PrismaUnion<BigIntWithAggregatesFilter, BigInt>? size;

  final _i1.PrismaUnion<BytesWithAggregatesFilter, _i2.Uint8List>? bytes;

  final JsonNullableWithAggregatesFilter? json;

  final _i1.PrismaUnion<IntNullableWithAggregatesFilter,
      _i1.PrismaUnion<int, _i1.PrismaNull>>? age;

  final _i1.PrismaUnion<FloatWithAggregatesFilter, double>? demo;

  final _i1.PrismaUnion<DateTimeWithAggregatesFilter, DateTime>? createdAt;
}

class PostWhereInput {
  const PostWhereInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.title,
    this.userId,
    this.author,
  });

  final _i1.PrismaUnion<PostWhereInput, Iterable<PostWhereInput>>? AND;

  final Iterable<PostWhereInput>? OR;

  final _i1.PrismaUnion<PostWhereInput, Iterable<PostWhereInput>>? NOT;

  final _i1.PrismaUnion<StringFilter, String>? id;

  final _i1.PrismaUnion<StringFilter, String>? title;

  final _i1.PrismaUnion<IntFilter, int>? userId;

  final _i1.PrismaUnion<UserRelationFilter, UserWhereInput>? author;
}

class PostOrderByWithRelationInput {
  const PostOrderByWithRelationInput({
    this.id,
    this.title,
    this.userId,
    this.author,
  });

  final SortOrder? id;

  final SortOrder? title;

  final SortOrder? userId;

  final UserOrderByWithRelationInput? author;
}

class PostWhereUniqueInput {
  const PostWhereUniqueInput({
    this.id,
    this.AND,
    this.OR,
    this.NOT,
    this.title,
    this.userId,
    this.author,
  });

  final String? id;

  final _i1.PrismaUnion<PostWhereInput, Iterable<PostWhereInput>>? AND;

  final Iterable<PostWhereInput>? OR;

  final _i1.PrismaUnion<PostWhereInput, Iterable<PostWhereInput>>? NOT;

  final _i1.PrismaUnion<StringFilter, String>? title;

  final _i1.PrismaUnion<IntFilter, int>? userId;

  final _i1.PrismaUnion<UserRelationFilter, UserWhereInput>? author;
}

class PostOrderByWithAggregationInput {
  const PostOrderByWithAggregationInput({
    this.id,
    this.title,
    this.userId,
    this.count,
    this.avg,
    this.max,
    this.min,
    this.sum,
  });

  final SortOrder? id;

  final SortOrder? title;

  final SortOrder? userId;

  final PostCountOrderByAggregateInput? count;

  final PostAvgOrderByAggregateInput? avg;

  final PostMaxOrderByAggregateInput? max;

  final PostMinOrderByAggregateInput? min;

  final PostSumOrderByAggregateInput? sum;
}

class PostScalarWhereWithAggregatesInput {
  const PostScalarWhereWithAggregatesInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.title,
    this.userId,
  });

  final _i1.PrismaUnion<PostScalarWhereWithAggregatesInput,
      Iterable<PostScalarWhereWithAggregatesInput>>? AND;

  final Iterable<PostScalarWhereWithAggregatesInput>? OR;

  final _i1.PrismaUnion<PostScalarWhereWithAggregatesInput,
      Iterable<PostScalarWhereWithAggregatesInput>>? NOT;

  final _i1.PrismaUnion<StringWithAggregatesFilter, String>? id;

  final _i1.PrismaUnion<StringWithAggregatesFilter, String>? title;

  final _i1.PrismaUnion<IntWithAggregatesFilter, int>? userId;
}

class UserCreateInput {
  const UserCreateInput({
    required this.name,
    this.role,
    required this.price,
    required this.size,
    required this.bytes,
    this.json,
    this.age,
    required this.demo,
    this.createdAt,
    this.posts,
  });

  final String name;

  final Role? role;

  final _i1.Decimal price;

  final BigInt size;

  final _i2.Uint8List bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson>? json;

  final _i1.PrismaUnion<int, _i1.PrismaNull>? age;

  final double demo;

  final DateTime? createdAt;

  final PostCreateNestedManyWithoutAuthorInput? posts;
}

class UserUncheckedCreateInput {
  const UserUncheckedCreateInput({
    this.id,
    required this.name,
    this.role,
    required this.price,
    required this.size,
    required this.bytes,
    this.json,
    this.age,
    required this.demo,
    this.createdAt,
    this.posts,
  });

  final int? id;

  final String name;

  final Role? role;

  final _i1.Decimal price;

  final BigInt size;

  final _i2.Uint8List bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson>? json;

  final _i1.PrismaUnion<int, _i1.PrismaNull>? age;

  final double demo;

  final DateTime? createdAt;

  final PostUncheckedCreateNestedManyWithoutAuthorInput? posts;
}

class UserUpdateInput {
  const UserUpdateInput({
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
    this.posts,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput>? role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput>? price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput>? size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput>? bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson>? json;

  final _i1.PrismaUnion<
      int,
      _i1
      .PrismaUnion<NullableIntFieldUpdateOperationsInput, _i1.PrismaNull>>? age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput>? demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput>?
      createdAt;

  final PostUpdateManyWithoutAuthorNestedInput? posts;
}

class UserUncheckedUpdateInput {
  const UserUncheckedUpdateInput({
    this.id,
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
    this.posts,
  });

  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput>? role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput>? price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput>? size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput>? bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson>? json;

  final _i1.PrismaUnion<
      int,
      _i1
      .PrismaUnion<NullableIntFieldUpdateOperationsInput, _i1.PrismaNull>>? age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput>? demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput>?
      createdAt;

  final PostUncheckedUpdateManyWithoutAuthorNestedInput? posts;
}

class UserCreateManyInput {
  const UserCreateManyInput({
    this.id,
    required this.name,
    this.role,
    required this.price,
    required this.size,
    required this.bytes,
    this.json,
    this.age,
    required this.demo,
    this.createdAt,
  });

  final int? id;

  final String name;

  final Role? role;

  final _i1.Decimal price;

  final BigInt size;

  final _i2.Uint8List bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson>? json;

  final _i1.PrismaUnion<int, _i1.PrismaNull>? age;

  final double demo;

  final DateTime? createdAt;
}

class UserUpdateManyMutationInput {
  const UserUpdateManyMutationInput({
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput>? role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput>? price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput>? size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput>? bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson>? json;

  final _i1.PrismaUnion<
      int,
      _i1
      .PrismaUnion<NullableIntFieldUpdateOperationsInput, _i1.PrismaNull>>? age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput>? demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput>?
      createdAt;
}

class UserUncheckedUpdateManyInput {
  const UserUncheckedUpdateManyInput({
    this.id,
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
  });

  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput>? role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput>? price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput>? size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput>? bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson>? json;

  final _i1.PrismaUnion<
      int,
      _i1
      .PrismaUnion<NullableIntFieldUpdateOperationsInput, _i1.PrismaNull>>? age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput>? demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput>?
      createdAt;
}

class PostCreateInput {
  const PostCreateInput({
    this.id,
    required this.title,
    required this.author,
  });

  final String? id;

  final String title;

  final UserCreateNestedOneWithoutPostsInput author;
}

class PostUncheckedCreateInput {
  const PostUncheckedCreateInput({
    this.id,
    required this.title,
    required this.userId,
  });

  final String? id;

  final String title;

  final int userId;
}

class PostUpdateInput {
  const PostUpdateInput({
    this.id,
    this.title,
    this.author,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;

  final UserUpdateOneRequiredWithoutPostsNestedInput? author;
}

class PostUncheckedUpdateInput {
  const PostUncheckedUpdateInput({
    this.id,
    this.title,
    this.userId,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;

  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput>? userId;
}

class PostCreateManyInput {
  const PostCreateManyInput({
    this.id,
    required this.title,
    required this.userId,
  });

  final String? id;

  final String title;

  final int userId;
}

class PostUpdateManyMutationInput {
  const PostUpdateManyMutationInput({
    this.id,
    this.title,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;
}

class PostUncheckedUpdateManyInput {
  const PostUncheckedUpdateManyInput({
    this.id,
    this.title,
    this.userId,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;

  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput>? userId;
}

class IntFilter {
  const IntFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? equals;

  final _i1.PrismaUnion<Iterable<int>, _i1.FieldRef<Iterable<int>>>? $in;

  final _i1.PrismaUnion<Iterable<int>, _i1.FieldRef<Iterable<int>>>? notIn;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lte;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gte;

  final _i1.PrismaUnion<int, NestedIntFilter>? not;
}

class StringFilter {
  const StringFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.mode,
    this.not,
  });

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? equals;

  final _i1.PrismaUnion<Iterable<String>, _i1.FieldRef<Iterable<String>>>? $in;

  final _i1.PrismaUnion<Iterable<String>, _i1.FieldRef<Iterable<String>>>?
      notIn;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? lt;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? lte;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? gt;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? gte;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? contains;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? startsWith;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? endsWith;

  final QueryMode? mode;

  final _i1.PrismaUnion<String, NestedStringFilter>? not;
}

class EnumRoleFilter {
  const EnumRoleFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.not,
  });

  final _i1.PrismaUnion<Role, _i1.FieldRef<Role>>? equals;

  final _i1.PrismaUnion<Iterable<Role>, _i1.FieldRef<Iterable<Role>>>? $in;

  final _i1.PrismaUnion<Iterable<Role>, _i1.FieldRef<Iterable<Role>>>? notIn;

  final _i1.PrismaUnion<Role, NestedEnumRoleFilter>? not;
}

class DecimalFilter {
  const DecimalFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? equals;

  final _i1
      .PrismaUnion<Iterable<_i1.Decimal>, _i1.FieldRef<Iterable<_i1.Decimal>>>?
      $in;

  final _i1
      .PrismaUnion<Iterable<_i1.Decimal>, _i1.FieldRef<Iterable<_i1.Decimal>>>?
      notIn;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? lt;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? lte;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? gt;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? gte;

  final _i1.PrismaUnion<_i1.Decimal, NestedDecimalFilter>? not;
}

class BigIntFilter {
  const BigIntFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? equals;

  final _i1.PrismaUnion<Iterable<BigInt>, _i1.FieldRef<Iterable<BigInt>>>? $in;

  final _i1.PrismaUnion<Iterable<BigInt>, _i1.FieldRef<Iterable<BigInt>>>?
      notIn;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? lt;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? lte;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? gt;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? gte;

  final _i1.PrismaUnion<BigInt, NestedBigIntFilter>? not;
}

class BytesFilter {
  const BytesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.not,
  });

  final _i1.PrismaUnion<_i2.Uint8List, _i1.FieldRef<_i2.Uint8List>>? equals;

  final _i1.PrismaUnion<Iterable<_i2.Uint8List>,
      _i1.FieldRef<Iterable<_i2.Uint8List>>>? $in;

  final _i1.PrismaUnion<Iterable<_i2.Uint8List>,
      _i1.FieldRef<Iterable<_i2.Uint8List>>>? notIn;

  final _i1.PrismaUnion<_i2.Uint8List, NestedBytesFilter>? not;
}

class JsonNullableFilter {
  const JsonNullableFilter({
    this.equals,
    this.path,
    this.stringContains,
    this.stringStartsWith,
    this.stringEndsWith,
    this.arrayContains,
    this.arrayStartsWith,
    this.arrayEndsWith,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, JsonNullValueFilter>>?
      equals;

  final Iterable<String>? path;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? stringContains;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? stringStartsWith;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? stringEndsWith;

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, _i1.PrismaNull>>?
      arrayContains;

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, _i1.PrismaNull>>?
      arrayStartsWith;

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, _i1.PrismaNull>>?
      arrayEndsWith;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? lt;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? lte;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? gt;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? gte;

  final _i1.PrismaUnion<_i1.PrismaJson,
      _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, JsonNullValueFilter>>? not;
}

class IntNullableFilter {
  const IntNullableFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1
      .PrismaUnion<int, _i1.PrismaUnion<_i1.FieldRef<int>, _i1.PrismaNull>>?
      equals;

  final _i1.PrismaUnion<Iterable<int>,
      _i1.PrismaUnion<_i1.FieldRef<Iterable<int>>, _i1.PrismaNull>>? $in;

  final _i1.PrismaUnion<Iterable<int>,
      _i1.PrismaUnion<_i1.FieldRef<Iterable<int>>, _i1.PrismaNull>>? notIn;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lte;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gte;

  final _i1.PrismaUnion<int,
      _i1.PrismaUnion<NestedIntNullableFilter, _i1.PrismaNull>>? not;
}

class FloatFilter {
  const FloatFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? equals;

  final _i1.PrismaUnion<Iterable<double>, _i1.FieldRef<Iterable<double>>>? $in;

  final _i1.PrismaUnion<Iterable<double>, _i1.FieldRef<Iterable<double>>>?
      notIn;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? lt;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? lte;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? gt;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? gte;

  final _i1.PrismaUnion<double, NestedFloatFilter>? not;
}

class DateTimeFilter {
  const DateTimeFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? equals;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.FieldRef<Iterable<DateTime>>>?
      $in;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.FieldRef<Iterable<DateTime>>>?
      notIn;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? lt;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? lte;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? gt;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? gte;

  final _i1.PrismaUnion<DateTime, NestedDateTimeFilter>? not;
}

class PostListRelationFilter {
  const PostListRelationFilter({
    this.every,
    this.some,
    this.none,
  });

  final PostWhereInput? every;

  final PostWhereInput? some;

  final PostWhereInput? none;
}

class SortOrderInput {
  const SortOrderInput({
    required this.sort,
    this.nulls,
  });

  final SortOrder sort;

  final NullsOrder? nulls;
}

class PostOrderByRelationAggregateInput {
  const PostOrderByRelationAggregateInput({this.count});

  final SortOrder? count;
}

class UserCountOrderByAggregateInput {
  const UserCountOrderByAggregateInput({
    this.id,
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
  });

  final SortOrder? id;

  final SortOrder? name;

  final SortOrder? role;

  final SortOrder? price;

  final SortOrder? size;

  final SortOrder? bytes;

  final SortOrder? json;

  final SortOrder? age;

  final SortOrder? demo;

  final SortOrder? createdAt;
}

class UserAvgOrderByAggregateInput {
  const UserAvgOrderByAggregateInput({
    this.id,
    this.price,
    this.size,
    this.age,
    this.demo,
  });

  final SortOrder? id;

  final SortOrder? price;

  final SortOrder? size;

  final SortOrder? age;

  final SortOrder? demo;
}

class UserMaxOrderByAggregateInput {
  const UserMaxOrderByAggregateInput({
    this.id,
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.age,
    this.demo,
    this.createdAt,
  });

  final SortOrder? id;

  final SortOrder? name;

  final SortOrder? role;

  final SortOrder? price;

  final SortOrder? size;

  final SortOrder? bytes;

  final SortOrder? age;

  final SortOrder? demo;

  final SortOrder? createdAt;
}

class UserMinOrderByAggregateInput {
  const UserMinOrderByAggregateInput({
    this.id,
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.age,
    this.demo,
    this.createdAt,
  });

  final SortOrder? id;

  final SortOrder? name;

  final SortOrder? role;

  final SortOrder? price;

  final SortOrder? size;

  final SortOrder? bytes;

  final SortOrder? age;

  final SortOrder? demo;

  final SortOrder? createdAt;
}

class UserSumOrderByAggregateInput {
  const UserSumOrderByAggregateInput({
    this.id,
    this.price,
    this.size,
    this.age,
    this.demo,
  });

  final SortOrder? id;

  final SortOrder? price;

  final SortOrder? size;

  final SortOrder? age;

  final SortOrder? demo;
}

class IntWithAggregatesFilter {
  const IntWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.avg,
    this.sum,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? equals;

  final _i1.PrismaUnion<Iterable<int>, _i1.FieldRef<Iterable<int>>>? $in;

  final _i1.PrismaUnion<Iterable<int>, _i1.FieldRef<Iterable<int>>>? notIn;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lte;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gte;

  final _i1.PrismaUnion<int, NestedIntWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedFloatFilter? avg;

  final NestedIntFilter? sum;

  final NestedIntFilter? min;

  final NestedIntFilter? max;
}

class StringWithAggregatesFilter {
  const StringWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.mode,
    this.not,
    this.count,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? equals;

  final _i1.PrismaUnion<Iterable<String>, _i1.FieldRef<Iterable<String>>>? $in;

  final _i1.PrismaUnion<Iterable<String>, _i1.FieldRef<Iterable<String>>>?
      notIn;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? lt;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? lte;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? gt;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? gte;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? contains;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? startsWith;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? endsWith;

  final QueryMode? mode;

  final _i1.PrismaUnion<String, NestedStringWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedStringFilter? min;

  final NestedStringFilter? max;
}

class EnumRoleWithAggregatesFilter {
  const EnumRoleWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.not,
    this.count,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<Role, _i1.FieldRef<Role>>? equals;

  final _i1.PrismaUnion<Iterable<Role>, _i1.FieldRef<Iterable<Role>>>? $in;

  final _i1.PrismaUnion<Iterable<Role>, _i1.FieldRef<Iterable<Role>>>? notIn;

  final _i1.PrismaUnion<Role, NestedEnumRoleWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedEnumRoleFilter? min;

  final NestedEnumRoleFilter? max;
}

class DecimalWithAggregatesFilter {
  const DecimalWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.avg,
    this.sum,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? equals;

  final _i1
      .PrismaUnion<Iterable<_i1.Decimal>, _i1.FieldRef<Iterable<_i1.Decimal>>>?
      $in;

  final _i1
      .PrismaUnion<Iterable<_i1.Decimal>, _i1.FieldRef<Iterable<_i1.Decimal>>>?
      notIn;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? lt;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? lte;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? gt;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? gte;

  final _i1.PrismaUnion<_i1.Decimal, NestedDecimalWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedDecimalFilter? avg;

  final NestedDecimalFilter? sum;

  final NestedDecimalFilter? min;

  final NestedDecimalFilter? max;
}

class BigIntWithAggregatesFilter {
  const BigIntWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.avg,
    this.sum,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? equals;

  final _i1.PrismaUnion<Iterable<BigInt>, _i1.FieldRef<Iterable<BigInt>>>? $in;

  final _i1.PrismaUnion<Iterable<BigInt>, _i1.FieldRef<Iterable<BigInt>>>?
      notIn;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? lt;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? lte;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? gt;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? gte;

  final _i1.PrismaUnion<BigInt, NestedBigIntWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedFloatFilter? avg;

  final NestedBigIntFilter? sum;

  final NestedBigIntFilter? min;

  final NestedBigIntFilter? max;
}

class BytesWithAggregatesFilter {
  const BytesWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.not,
    this.count,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<_i2.Uint8List, _i1.FieldRef<_i2.Uint8List>>? equals;

  final _i1.PrismaUnion<Iterable<_i2.Uint8List>,
      _i1.FieldRef<Iterable<_i2.Uint8List>>>? $in;

  final _i1.PrismaUnion<Iterable<_i2.Uint8List>,
      _i1.FieldRef<Iterable<_i2.Uint8List>>>? notIn;

  final _i1.PrismaUnion<_i2.Uint8List, NestedBytesWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedBytesFilter? min;

  final NestedBytesFilter? max;
}

class JsonNullableWithAggregatesFilter {
  const JsonNullableWithAggregatesFilter({
    this.equals,
    this.path,
    this.stringContains,
    this.stringStartsWith,
    this.stringEndsWith,
    this.arrayContains,
    this.arrayStartsWith,
    this.arrayEndsWith,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, JsonNullValueFilter>>?
      equals;

  final Iterable<String>? path;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? stringContains;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? stringStartsWith;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? stringEndsWith;

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, _i1.PrismaNull>>?
      arrayContains;

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, _i1.PrismaNull>>?
      arrayStartsWith;

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, _i1.PrismaNull>>?
      arrayEndsWith;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? lt;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? lte;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? gt;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? gte;

  final _i1.PrismaUnion<_i1.PrismaJson,
      _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, JsonNullValueFilter>>? not;

  final NestedIntNullableFilter? count;

  final NestedJsonNullableFilter? min;

  final NestedJsonNullableFilter? max;
}

class IntNullableWithAggregatesFilter {
  const IntNullableWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.avg,
    this.sum,
    this.min,
    this.max,
  });

  final _i1
      .PrismaUnion<int, _i1.PrismaUnion<_i1.FieldRef<int>, _i1.PrismaNull>>?
      equals;

  final _i1.PrismaUnion<Iterable<int>,
      _i1.PrismaUnion<_i1.FieldRef<Iterable<int>>, _i1.PrismaNull>>? $in;

  final _i1.PrismaUnion<Iterable<int>,
      _i1.PrismaUnion<_i1.FieldRef<Iterable<int>>, _i1.PrismaNull>>? notIn;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lte;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gte;

  final _i1.PrismaUnion<
      int,
      _i1
      .PrismaUnion<NestedIntNullableWithAggregatesFilter, _i1.PrismaNull>>? not;

  final NestedIntNullableFilter? count;

  final NestedFloatNullableFilter? avg;

  final NestedIntNullableFilter? sum;

  final NestedIntNullableFilter? min;

  final NestedIntNullableFilter? max;
}

class FloatWithAggregatesFilter {
  const FloatWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.avg,
    this.sum,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? equals;

  final _i1.PrismaUnion<Iterable<double>, _i1.FieldRef<Iterable<double>>>? $in;

  final _i1.PrismaUnion<Iterable<double>, _i1.FieldRef<Iterable<double>>>?
      notIn;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? lt;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? lte;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? gt;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? gte;

  final _i1.PrismaUnion<double, NestedFloatWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedFloatFilter? avg;

  final NestedFloatFilter? sum;

  final NestedFloatFilter? min;

  final NestedFloatFilter? max;
}

class DateTimeWithAggregatesFilter {
  const DateTimeWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? equals;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.FieldRef<Iterable<DateTime>>>?
      $in;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.FieldRef<Iterable<DateTime>>>?
      notIn;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? lt;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? lte;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? gt;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? gte;

  final _i1.PrismaUnion<DateTime, NestedDateTimeWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedDateTimeFilter? min;

  final NestedDateTimeFilter? max;
}

class UserRelationFilter {
  const UserRelationFilter({
    this.$is,
    this.isNot,
  });

  final UserWhereInput? $is;

  final UserWhereInput? isNot;
}

class PostCountOrderByAggregateInput {
  const PostCountOrderByAggregateInput({
    this.id,
    this.title,
    this.userId,
  });

  final SortOrder? id;

  final SortOrder? title;

  final SortOrder? userId;
}

class PostAvgOrderByAggregateInput {
  const PostAvgOrderByAggregateInput({this.userId});

  final SortOrder? userId;
}

class PostMaxOrderByAggregateInput {
  const PostMaxOrderByAggregateInput({
    this.id,
    this.title,
    this.userId,
  });

  final SortOrder? id;

  final SortOrder? title;

  final SortOrder? userId;
}

class PostMinOrderByAggregateInput {
  const PostMinOrderByAggregateInput({
    this.id,
    this.title,
    this.userId,
  });

  final SortOrder? id;

  final SortOrder? title;

  final SortOrder? userId;
}

class PostSumOrderByAggregateInput {
  const PostSumOrderByAggregateInput({this.userId});

  final SortOrder? userId;
}

class PostCreateNestedManyWithoutAuthorInput {
  const PostCreateNestedManyWithoutAuthorInput({
    this.create,
    this.connectOrCreate,
    this.createMany,
    this.connect,
  });

  final _i1.PrismaUnion<
      PostCreateWithoutAuthorInput,
      _i1.PrismaUnion<
          Iterable<PostCreateWithoutAuthorInput>,
          _i1.PrismaUnion<PostUncheckedCreateWithoutAuthorInput,
              Iterable<PostUncheckedCreateWithoutAuthorInput>>>>? create;

  final _i1.PrismaUnion<PostCreateOrConnectWithoutAuthorInput,
      Iterable<PostCreateOrConnectWithoutAuthorInput>>? connectOrCreate;

  final PostCreateManyAuthorInputEnvelope? createMany;

  final _i1.PrismaUnion<PostWhereUniqueInput, Iterable<PostWhereUniqueInput>>?
      connect;
}

class PostUncheckedCreateNestedManyWithoutAuthorInput {
  const PostUncheckedCreateNestedManyWithoutAuthorInput({
    this.create,
    this.connectOrCreate,
    this.createMany,
    this.connect,
  });

  final _i1.PrismaUnion<
      PostCreateWithoutAuthorInput,
      _i1.PrismaUnion<
          Iterable<PostCreateWithoutAuthorInput>,
          _i1.PrismaUnion<PostUncheckedCreateWithoutAuthorInput,
              Iterable<PostUncheckedCreateWithoutAuthorInput>>>>? create;

  final _i1.PrismaUnion<PostCreateOrConnectWithoutAuthorInput,
      Iterable<PostCreateOrConnectWithoutAuthorInput>>? connectOrCreate;

  final PostCreateManyAuthorInputEnvelope? createMany;

  final _i1.PrismaUnion<PostWhereUniqueInput, Iterable<PostWhereUniqueInput>>?
      connect;
}

class StringFieldUpdateOperationsInput {
  const StringFieldUpdateOperationsInput({this.set});

  final String? set;
}

class EnumRoleFieldUpdateOperationsInput {
  const EnumRoleFieldUpdateOperationsInput({this.set});

  final Role? set;
}

class DecimalFieldUpdateOperationsInput {
  const DecimalFieldUpdateOperationsInput({
    this.set,
    this.increment,
    this.decrement,
    this.multiply,
    this.divide,
  });

  final _i1.Decimal? set;

  final _i1.Decimal? increment;

  final _i1.Decimal? decrement;

  final _i1.Decimal? multiply;

  final _i1.Decimal? divide;
}

class BigIntFieldUpdateOperationsInput {
  const BigIntFieldUpdateOperationsInput({
    this.set,
    this.increment,
    this.decrement,
    this.multiply,
    this.divide,
  });

  final BigInt? set;

  final BigInt? increment;

  final BigInt? decrement;

  final BigInt? multiply;

  final BigInt? divide;
}

class BytesFieldUpdateOperationsInput {
  const BytesFieldUpdateOperationsInput({this.set});

  final _i2.Uint8List? set;
}

class NullableIntFieldUpdateOperationsInput {
  const NullableIntFieldUpdateOperationsInput({
    this.set,
    this.increment,
    this.decrement,
    this.multiply,
    this.divide,
  });

  final _i1.PrismaUnion<int, _i1.PrismaNull>? set;

  final int? increment;

  final int? decrement;

  final int? multiply;

  final int? divide;
}

class FloatFieldUpdateOperationsInput {
  const FloatFieldUpdateOperationsInput({
    this.set,
    this.increment,
    this.decrement,
    this.multiply,
    this.divide,
  });

  final double? set;

  final double? increment;

  final double? decrement;

  final double? multiply;

  final double? divide;
}

class DateTimeFieldUpdateOperationsInput {
  const DateTimeFieldUpdateOperationsInput({this.set});

  final DateTime? set;
}

class PostUpdateManyWithoutAuthorNestedInput {
  const PostUpdateManyWithoutAuthorNestedInput({
    this.create,
    this.connectOrCreate,
    this.upsert,
    this.createMany,
    this.set,
    this.disconnect,
    this.delete,
    this.connect,
    this.update,
    this.updateMany,
    this.deleteMany,
  });

  final _i1.PrismaUnion<
      PostCreateWithoutAuthorInput,
      _i1.PrismaUnion<
          Iterable<PostCreateWithoutAuthorInput>,
          _i1.PrismaUnion<PostUncheckedCreateWithoutAuthorInput,
              Iterable<PostUncheckedCreateWithoutAuthorInput>>>>? create;

  final _i1.PrismaUnion<PostCreateOrConnectWithoutAuthorInput,
      Iterable<PostCreateOrConnectWithoutAuthorInput>>? connectOrCreate;

  final _i1.PrismaUnion<PostUpsertWithWhereUniqueWithoutAuthorInput,
      Iterable<PostUpsertWithWhereUniqueWithoutAuthorInput>>? upsert;

  final PostCreateManyAuthorInputEnvelope? createMany;

  final _i1.PrismaUnion<PostWhereUniqueInput, Iterable<PostWhereUniqueInput>>?
      set;

  final _i1.PrismaUnion<PostWhereUniqueInput, Iterable<PostWhereUniqueInput>>?
      disconnect;

  final _i1.PrismaUnion<PostWhereUniqueInput, Iterable<PostWhereUniqueInput>>?
      delete;

  final _i1.PrismaUnion<PostWhereUniqueInput, Iterable<PostWhereUniqueInput>>?
      connect;

  final _i1.PrismaUnion<PostUpdateWithWhereUniqueWithoutAuthorInput,
      Iterable<PostUpdateWithWhereUniqueWithoutAuthorInput>>? update;

  final _i1.PrismaUnion<PostUpdateManyWithWhereWithoutAuthorInput,
      Iterable<PostUpdateManyWithWhereWithoutAuthorInput>>? updateMany;

  final _i1.PrismaUnion<PostScalarWhereInput, Iterable<PostScalarWhereInput>>?
      deleteMany;
}

class IntFieldUpdateOperationsInput {
  const IntFieldUpdateOperationsInput({
    this.set,
    this.increment,
    this.decrement,
    this.multiply,
    this.divide,
  });

  final int? set;

  final int? increment;

  final int? decrement;

  final int? multiply;

  final int? divide;
}

class PostUncheckedUpdateManyWithoutAuthorNestedInput {
  const PostUncheckedUpdateManyWithoutAuthorNestedInput({
    this.create,
    this.connectOrCreate,
    this.upsert,
    this.createMany,
    this.set,
    this.disconnect,
    this.delete,
    this.connect,
    this.update,
    this.updateMany,
    this.deleteMany,
  });

  final _i1.PrismaUnion<
      PostCreateWithoutAuthorInput,
      _i1.PrismaUnion<
          Iterable<PostCreateWithoutAuthorInput>,
          _i1.PrismaUnion<PostUncheckedCreateWithoutAuthorInput,
              Iterable<PostUncheckedCreateWithoutAuthorInput>>>>? create;

  final _i1.PrismaUnion<PostCreateOrConnectWithoutAuthorInput,
      Iterable<PostCreateOrConnectWithoutAuthorInput>>? connectOrCreate;

  final _i1.PrismaUnion<PostUpsertWithWhereUniqueWithoutAuthorInput,
      Iterable<PostUpsertWithWhereUniqueWithoutAuthorInput>>? upsert;

  final PostCreateManyAuthorInputEnvelope? createMany;

  final _i1.PrismaUnion<PostWhereUniqueInput, Iterable<PostWhereUniqueInput>>?
      set;

  final _i1.PrismaUnion<PostWhereUniqueInput, Iterable<PostWhereUniqueInput>>?
      disconnect;

  final _i1.PrismaUnion<PostWhereUniqueInput, Iterable<PostWhereUniqueInput>>?
      delete;

  final _i1.PrismaUnion<PostWhereUniqueInput, Iterable<PostWhereUniqueInput>>?
      connect;

  final _i1.PrismaUnion<PostUpdateWithWhereUniqueWithoutAuthorInput,
      Iterable<PostUpdateWithWhereUniqueWithoutAuthorInput>>? update;

  final _i1.PrismaUnion<PostUpdateManyWithWhereWithoutAuthorInput,
      Iterable<PostUpdateManyWithWhereWithoutAuthorInput>>? updateMany;

  final _i1.PrismaUnion<PostScalarWhereInput, Iterable<PostScalarWhereInput>>?
      deleteMany;
}

class UserCreateNestedOneWithoutPostsInput {
  const UserCreateNestedOneWithoutPostsInput({
    this.create,
    this.connectOrCreate,
    this.connect,
  });

  final _i1.PrismaUnion<UserCreateWithoutPostsInput,
      UserUncheckedCreateWithoutPostsInput>? create;

  final UserCreateOrConnectWithoutPostsInput? connectOrCreate;

  final UserWhereUniqueInput? connect;
}

class UserUpdateOneRequiredWithoutPostsNestedInput {
  const UserUpdateOneRequiredWithoutPostsNestedInput({
    this.create,
    this.connectOrCreate,
    this.upsert,
    this.connect,
    this.update,
  });

  final _i1.PrismaUnion<UserCreateWithoutPostsInput,
      UserUncheckedCreateWithoutPostsInput>? create;

  final UserCreateOrConnectWithoutPostsInput? connectOrCreate;

  final UserUpsertWithoutPostsInput? upsert;

  final UserWhereUniqueInput? connect;

  final _i1.PrismaUnion<
      UserUpdateToOneWithWhereWithoutPostsInput,
      _i1.PrismaUnion<UserUpdateWithoutPostsInput,
          UserUncheckedUpdateWithoutPostsInput>>? update;
}

class NestedIntFilter {
  const NestedIntFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? equals;

  final _i1.PrismaUnion<Iterable<int>, _i1.FieldRef<Iterable<int>>>? $in;

  final _i1.PrismaUnion<Iterable<int>, _i1.FieldRef<Iterable<int>>>? notIn;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lte;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gte;

  final _i1.PrismaUnion<int, NestedIntFilter>? not;
}

class NestedStringFilter {
  const NestedStringFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.not,
  });

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? equals;

  final _i1.PrismaUnion<Iterable<String>, _i1.FieldRef<Iterable<String>>>? $in;

  final _i1.PrismaUnion<Iterable<String>, _i1.FieldRef<Iterable<String>>>?
      notIn;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? lt;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? lte;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? gt;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? gte;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? contains;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? startsWith;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? endsWith;

  final _i1.PrismaUnion<String, NestedStringFilter>? not;
}

class NestedEnumRoleFilter {
  const NestedEnumRoleFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.not,
  });

  final _i1.PrismaUnion<Role, _i1.FieldRef<Role>>? equals;

  final _i1.PrismaUnion<Iterable<Role>, _i1.FieldRef<Iterable<Role>>>? $in;

  final _i1.PrismaUnion<Iterable<Role>, _i1.FieldRef<Iterable<Role>>>? notIn;

  final _i1.PrismaUnion<Role, NestedEnumRoleFilter>? not;
}

class NestedDecimalFilter {
  const NestedDecimalFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? equals;

  final _i1
      .PrismaUnion<Iterable<_i1.Decimal>, _i1.FieldRef<Iterable<_i1.Decimal>>>?
      $in;

  final _i1
      .PrismaUnion<Iterable<_i1.Decimal>, _i1.FieldRef<Iterable<_i1.Decimal>>>?
      notIn;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? lt;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? lte;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? gt;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? gte;

  final _i1.PrismaUnion<_i1.Decimal, NestedDecimalFilter>? not;
}

class NestedBigIntFilter {
  const NestedBigIntFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? equals;

  final _i1.PrismaUnion<Iterable<BigInt>, _i1.FieldRef<Iterable<BigInt>>>? $in;

  final _i1.PrismaUnion<Iterable<BigInt>, _i1.FieldRef<Iterable<BigInt>>>?
      notIn;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? lt;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? lte;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? gt;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? gte;

  final _i1.PrismaUnion<BigInt, NestedBigIntFilter>? not;
}

class NestedBytesFilter {
  const NestedBytesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.not,
  });

  final _i1.PrismaUnion<_i2.Uint8List, _i1.FieldRef<_i2.Uint8List>>? equals;

  final _i1.PrismaUnion<Iterable<_i2.Uint8List>,
      _i1.FieldRef<Iterable<_i2.Uint8List>>>? $in;

  final _i1.PrismaUnion<Iterable<_i2.Uint8List>,
      _i1.FieldRef<Iterable<_i2.Uint8List>>>? notIn;

  final _i1.PrismaUnion<_i2.Uint8List, NestedBytesFilter>? not;
}

class NestedIntNullableFilter {
  const NestedIntNullableFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1
      .PrismaUnion<int, _i1.PrismaUnion<_i1.FieldRef<int>, _i1.PrismaNull>>?
      equals;

  final _i1.PrismaUnion<Iterable<int>,
      _i1.PrismaUnion<_i1.FieldRef<Iterable<int>>, _i1.PrismaNull>>? $in;

  final _i1.PrismaUnion<Iterable<int>,
      _i1.PrismaUnion<_i1.FieldRef<Iterable<int>>, _i1.PrismaNull>>? notIn;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lte;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gte;

  final _i1.PrismaUnion<int,
      _i1.PrismaUnion<NestedIntNullableFilter, _i1.PrismaNull>>? not;
}

class NestedFloatFilter {
  const NestedFloatFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? equals;

  final _i1.PrismaUnion<Iterable<double>, _i1.FieldRef<Iterable<double>>>? $in;

  final _i1.PrismaUnion<Iterable<double>, _i1.FieldRef<Iterable<double>>>?
      notIn;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? lt;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? lte;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? gt;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? gte;

  final _i1.PrismaUnion<double, NestedFloatFilter>? not;
}

class NestedDateTimeFilter {
  const NestedDateTimeFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? equals;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.FieldRef<Iterable<DateTime>>>?
      $in;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.FieldRef<Iterable<DateTime>>>?
      notIn;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? lt;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? lte;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? gt;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? gte;

  final _i1.PrismaUnion<DateTime, NestedDateTimeFilter>? not;
}

class NestedIntWithAggregatesFilter {
  const NestedIntWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.avg,
    this.sum,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? equals;

  final _i1.PrismaUnion<Iterable<int>, _i1.FieldRef<Iterable<int>>>? $in;

  final _i1.PrismaUnion<Iterable<int>, _i1.FieldRef<Iterable<int>>>? notIn;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lte;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gte;

  final _i1.PrismaUnion<int, NestedIntWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedFloatFilter? avg;

  final NestedIntFilter? sum;

  final NestedIntFilter? min;

  final NestedIntFilter? max;
}

class NestedStringWithAggregatesFilter {
  const NestedStringWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.not,
    this.count,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? equals;

  final _i1.PrismaUnion<Iterable<String>, _i1.FieldRef<Iterable<String>>>? $in;

  final _i1.PrismaUnion<Iterable<String>, _i1.FieldRef<Iterable<String>>>?
      notIn;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? lt;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? lte;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? gt;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? gte;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? contains;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? startsWith;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? endsWith;

  final _i1.PrismaUnion<String, NestedStringWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedStringFilter? min;

  final NestedStringFilter? max;
}

class NestedEnumRoleWithAggregatesFilter {
  const NestedEnumRoleWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.not,
    this.count,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<Role, _i1.FieldRef<Role>>? equals;

  final _i1.PrismaUnion<Iterable<Role>, _i1.FieldRef<Iterable<Role>>>? $in;

  final _i1.PrismaUnion<Iterable<Role>, _i1.FieldRef<Iterable<Role>>>? notIn;

  final _i1.PrismaUnion<Role, NestedEnumRoleWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedEnumRoleFilter? min;

  final NestedEnumRoleFilter? max;
}

class NestedDecimalWithAggregatesFilter {
  const NestedDecimalWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.avg,
    this.sum,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? equals;

  final _i1
      .PrismaUnion<Iterable<_i1.Decimal>, _i1.FieldRef<Iterable<_i1.Decimal>>>?
      $in;

  final _i1
      .PrismaUnion<Iterable<_i1.Decimal>, _i1.FieldRef<Iterable<_i1.Decimal>>>?
      notIn;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? lt;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? lte;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? gt;

  final _i1.PrismaUnion<_i1.Decimal, _i1.FieldRef<_i1.Decimal>>? gte;

  final _i1.PrismaUnion<_i1.Decimal, NestedDecimalWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedDecimalFilter? avg;

  final NestedDecimalFilter? sum;

  final NestedDecimalFilter? min;

  final NestedDecimalFilter? max;
}

class NestedBigIntWithAggregatesFilter {
  const NestedBigIntWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.avg,
    this.sum,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? equals;

  final _i1.PrismaUnion<Iterable<BigInt>, _i1.FieldRef<Iterable<BigInt>>>? $in;

  final _i1.PrismaUnion<Iterable<BigInt>, _i1.FieldRef<Iterable<BigInt>>>?
      notIn;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? lt;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? lte;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? gt;

  final _i1.PrismaUnion<BigInt, _i1.FieldRef<BigInt>>? gte;

  final _i1.PrismaUnion<BigInt, NestedBigIntWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedFloatFilter? avg;

  final NestedBigIntFilter? sum;

  final NestedBigIntFilter? min;

  final NestedBigIntFilter? max;
}

class NestedBytesWithAggregatesFilter {
  const NestedBytesWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.not,
    this.count,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<_i2.Uint8List, _i1.FieldRef<_i2.Uint8List>>? equals;

  final _i1.PrismaUnion<Iterable<_i2.Uint8List>,
      _i1.FieldRef<Iterable<_i2.Uint8List>>>? $in;

  final _i1.PrismaUnion<Iterable<_i2.Uint8List>,
      _i1.FieldRef<Iterable<_i2.Uint8List>>>? notIn;

  final _i1.PrismaUnion<_i2.Uint8List, NestedBytesWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedBytesFilter? min;

  final NestedBytesFilter? max;
}

class NestedJsonNullableFilter {
  const NestedJsonNullableFilter({
    this.equals,
    this.path,
    this.stringContains,
    this.stringStartsWith,
    this.stringEndsWith,
    this.arrayContains,
    this.arrayStartsWith,
    this.arrayEndsWith,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, JsonNullValueFilter>>?
      equals;

  final Iterable<String>? path;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? stringContains;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? stringStartsWith;

  final _i1.PrismaUnion<String, _i1.FieldRef<String>>? stringEndsWith;

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, _i1.PrismaNull>>?
      arrayContains;

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, _i1.PrismaNull>>?
      arrayStartsWith;

  final _i1.PrismaUnion<_i1.PrismaJson,
          _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, _i1.PrismaNull>>?
      arrayEndsWith;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? lt;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? lte;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? gt;

  final _i1.PrismaUnion<_i1.PrismaJson, _i1.FieldRef<_i1.PrismaJson>>? gte;

  final _i1.PrismaUnion<_i1.PrismaJson,
      _i1.PrismaUnion<_i1.FieldRef<_i1.PrismaJson>, JsonNullValueFilter>>? not;
}

class NestedIntNullableWithAggregatesFilter {
  const NestedIntNullableWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.avg,
    this.sum,
    this.min,
    this.max,
  });

  final _i1
      .PrismaUnion<int, _i1.PrismaUnion<_i1.FieldRef<int>, _i1.PrismaNull>>?
      equals;

  final _i1.PrismaUnion<Iterable<int>,
      _i1.PrismaUnion<_i1.FieldRef<Iterable<int>>, _i1.PrismaNull>>? $in;

  final _i1.PrismaUnion<Iterable<int>,
      _i1.PrismaUnion<_i1.FieldRef<Iterable<int>>, _i1.PrismaNull>>? notIn;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? lte;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gt;

  final _i1.PrismaUnion<int, _i1.FieldRef<int>>? gte;

  final _i1.PrismaUnion<
      int,
      _i1
      .PrismaUnion<NestedIntNullableWithAggregatesFilter, _i1.PrismaNull>>? not;

  final NestedIntNullableFilter? count;

  final NestedFloatNullableFilter? avg;

  final NestedIntNullableFilter? sum;

  final NestedIntNullableFilter? min;

  final NestedIntNullableFilter? max;
}

class NestedFloatNullableFilter {
  const NestedFloatNullableFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<double,
      _i1.PrismaUnion<_i1.FieldRef<double>, _i1.PrismaNull>>? equals;

  final _i1.PrismaUnion<Iterable<double>,
      _i1.PrismaUnion<_i1.FieldRef<Iterable<double>>, _i1.PrismaNull>>? $in;

  final _i1.PrismaUnion<Iterable<double>,
      _i1.PrismaUnion<_i1.FieldRef<Iterable<double>>, _i1.PrismaNull>>? notIn;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? lt;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? lte;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? gt;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? gte;

  final _i1.PrismaUnion<double,
      _i1.PrismaUnion<NestedFloatNullableFilter, _i1.PrismaNull>>? not;
}

class NestedFloatWithAggregatesFilter {
  const NestedFloatWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.avg,
    this.sum,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? equals;

  final _i1.PrismaUnion<Iterable<double>, _i1.FieldRef<Iterable<double>>>? $in;

  final _i1.PrismaUnion<Iterable<double>, _i1.FieldRef<Iterable<double>>>?
      notIn;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? lt;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? lte;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? gt;

  final _i1.PrismaUnion<double, _i1.FieldRef<double>>? gte;

  final _i1.PrismaUnion<double, NestedFloatWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedFloatFilter? avg;

  final NestedFloatFilter? sum;

  final NestedFloatFilter? min;

  final NestedFloatFilter? max;
}

class NestedDateTimeWithAggregatesFilter {
  const NestedDateTimeWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.count,
    this.min,
    this.max,
  });

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? equals;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.FieldRef<Iterable<DateTime>>>?
      $in;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.FieldRef<Iterable<DateTime>>>?
      notIn;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? lt;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? lte;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? gt;

  final _i1.PrismaUnion<DateTime, _i1.FieldRef<DateTime>>? gte;

  final _i1.PrismaUnion<DateTime, NestedDateTimeWithAggregatesFilter>? not;

  final NestedIntFilter? count;

  final NestedDateTimeFilter? min;

  final NestedDateTimeFilter? max;
}

class PostCreateWithoutAuthorInput {
  const PostCreateWithoutAuthorInput({
    this.id,
    required this.title,
  });

  final String? id;

  final String title;
}

class PostUncheckedCreateWithoutAuthorInput {
  const PostUncheckedCreateWithoutAuthorInput({
    this.id,
    required this.title,
  });

  final String? id;

  final String title;
}

class PostCreateOrConnectWithoutAuthorInput {
  const PostCreateOrConnectWithoutAuthorInput({
    required this.where,
    required this.create,
  });

  final PostWhereUniqueInput where;

  final _i1.PrismaUnion<PostCreateWithoutAuthorInput,
      PostUncheckedCreateWithoutAuthorInput> create;
}

class PostCreateManyAuthorInputEnvelope {
  const PostCreateManyAuthorInputEnvelope({
    required this.data,
    this.skipDuplicates,
  });

  final _i1.PrismaUnion<PostCreateManyAuthorInput,
      Iterable<PostCreateManyAuthorInput>> data;

  final bool? skipDuplicates;
}

class PostUpsertWithWhereUniqueWithoutAuthorInput {
  const PostUpsertWithWhereUniqueWithoutAuthorInput({
    required this.where,
    required this.update,
    required this.create,
  });

  final PostWhereUniqueInput where;

  final _i1.PrismaUnion<PostUpdateWithoutAuthorInput,
      PostUncheckedUpdateWithoutAuthorInput> update;

  final _i1.PrismaUnion<PostCreateWithoutAuthorInput,
      PostUncheckedCreateWithoutAuthorInput> create;
}

class PostUpdateWithWhereUniqueWithoutAuthorInput {
  const PostUpdateWithWhereUniqueWithoutAuthorInput({
    required this.where,
    required this.data,
  });

  final PostWhereUniqueInput where;

  final _i1.PrismaUnion<PostUpdateWithoutAuthorInput,
      PostUncheckedUpdateWithoutAuthorInput> data;
}

class PostUpdateManyWithWhereWithoutAuthorInput {
  const PostUpdateManyWithWhereWithoutAuthorInput({
    required this.where,
    required this.data,
  });

  final PostScalarWhereInput where;

  final _i1.PrismaUnion<PostUpdateManyMutationInput,
      PostUncheckedUpdateManyWithoutAuthorInput> data;
}

class PostScalarWhereInput {
  const PostScalarWhereInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.title,
    this.userId,
  });

  final _i1.PrismaUnion<PostScalarWhereInput, Iterable<PostScalarWhereInput>>?
      AND;

  final Iterable<PostScalarWhereInput>? OR;

  final _i1.PrismaUnion<PostScalarWhereInput, Iterable<PostScalarWhereInput>>?
      NOT;

  final _i1.PrismaUnion<StringFilter, String>? id;

  final _i1.PrismaUnion<StringFilter, String>? title;

  final _i1.PrismaUnion<IntFilter, int>? userId;
}

class UserCreateWithoutPostsInput {
  const UserCreateWithoutPostsInput({
    required this.name,
    this.role,
    required this.price,
    required this.size,
    required this.bytes,
    this.json,
    this.age,
    required this.demo,
    this.createdAt,
  });

  final String name;

  final Role? role;

  final _i1.Decimal price;

  final BigInt size;

  final _i2.Uint8List bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson>? json;

  final _i1.PrismaUnion<int, _i1.PrismaNull>? age;

  final double demo;

  final DateTime? createdAt;
}

class UserUncheckedCreateWithoutPostsInput {
  const UserUncheckedCreateWithoutPostsInput({
    this.id,
    required this.name,
    this.role,
    required this.price,
    required this.size,
    required this.bytes,
    this.json,
    this.age,
    required this.demo,
    this.createdAt,
  });

  final int? id;

  final String name;

  final Role? role;

  final _i1.Decimal price;

  final BigInt size;

  final _i2.Uint8List bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson>? json;

  final _i1.PrismaUnion<int, _i1.PrismaNull>? age;

  final double demo;

  final DateTime? createdAt;
}

class UserCreateOrConnectWithoutPostsInput {
  const UserCreateOrConnectWithoutPostsInput({
    required this.where,
    required this.create,
  });

  final UserWhereUniqueInput where;

  final _i1.PrismaUnion<UserCreateWithoutPostsInput,
      UserUncheckedCreateWithoutPostsInput> create;
}

class UserUpsertWithoutPostsInput {
  const UserUpsertWithoutPostsInput({
    required this.update,
    required this.create,
    this.where,
  });

  final _i1.PrismaUnion<UserUpdateWithoutPostsInput,
      UserUncheckedUpdateWithoutPostsInput> update;

  final _i1.PrismaUnion<UserCreateWithoutPostsInput,
      UserUncheckedCreateWithoutPostsInput> create;

  final UserWhereInput? where;
}

class UserUpdateToOneWithWhereWithoutPostsInput {
  const UserUpdateToOneWithWhereWithoutPostsInput({
    this.where,
    required this.data,
  });

  final UserWhereInput? where;

  final _i1.PrismaUnion<UserUpdateWithoutPostsInput,
      UserUncheckedUpdateWithoutPostsInput> data;
}

class UserUpdateWithoutPostsInput {
  const UserUpdateWithoutPostsInput({
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput>? role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput>? price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput>? size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput>? bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson>? json;

  final _i1.PrismaUnion<
      int,
      _i1
      .PrismaUnion<NullableIntFieldUpdateOperationsInput, _i1.PrismaNull>>? age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput>? demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput>?
      createdAt;
}

class UserUncheckedUpdateWithoutPostsInput {
  const UserUncheckedUpdateWithoutPostsInput({
    this.id,
    this.name,
    this.role,
    this.price,
    this.size,
    this.bytes,
    this.json,
    this.age,
    this.demo,
    this.createdAt,
  });

  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput>? role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput>? price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput>? size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput>? bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson>? json;

  final _i1.PrismaUnion<
      int,
      _i1
      .PrismaUnion<NullableIntFieldUpdateOperationsInput, _i1.PrismaNull>>? age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput>? demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput>?
      createdAt;
}

class PostCreateManyAuthorInput {
  const PostCreateManyAuthorInput({
    this.id,
    required this.title,
  });

  final String? id;

  final String title;
}

class PostUpdateWithoutAuthorInput {
  const PostUpdateWithoutAuthorInput({
    this.id,
    this.title,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;
}

class PostUncheckedUpdateWithoutAuthorInput {
  const PostUncheckedUpdateWithoutAuthorInput({
    this.id,
    this.title,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;
}

class PostUncheckedUpdateManyWithoutAuthorInput {
  const PostUncheckedUpdateManyWithoutAuthorInput({
    this.id,
    this.title,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;
}
