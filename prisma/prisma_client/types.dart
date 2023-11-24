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

class UserWhereInput implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (AND != null) r'AND': _i1.JsonConvertible.serialize(AND),
        if (OR != null) r'OR': _i1.JsonConvertible.serialize(OR),
        if (NOT != null) r'NOT': _i1.JsonConvertible.serialize(NOT),
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
        if (posts != null) r'posts': _i1.JsonConvertible.serialize(posts),
      };
}

class UserOrderByWithRelationInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
        if (posts != null) r'posts': _i1.JsonConvertible.serialize(posts),
      };
}

class UserWhereUniqueInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (AND != null) r'AND': _i1.JsonConvertible.serialize(AND),
        if (OR != null) r'OR': _i1.JsonConvertible.serialize(OR),
        if (NOT != null) r'NOT': _i1.JsonConvertible.serialize(NOT),
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
        if (posts != null) r'posts': _i1.JsonConvertible.serialize(posts),
      };
}

class UserOrderByWithAggregationInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
      };
}

class UserScalarWhereWithAggregatesInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (AND != null) r'AND': _i1.JsonConvertible.serialize(AND),
        if (OR != null) r'OR': _i1.JsonConvertible.serialize(OR),
        if (NOT != null) r'NOT': _i1.JsonConvertible.serialize(NOT),
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
      };
}

class PostWhereInput implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (AND != null) r'AND': _i1.JsonConvertible.serialize(AND),
        if (OR != null) r'OR': _i1.JsonConvertible.serialize(OR),
        if (NOT != null) r'NOT': _i1.JsonConvertible.serialize(NOT),
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId),
        if (author != null) r'author': _i1.JsonConvertible.serialize(author),
      };
}

class PostOrderByWithRelationInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId),
        if (author != null) r'author': _i1.JsonConvertible.serialize(author),
      };
}

class PostWhereUniqueInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (AND != null) r'AND': _i1.JsonConvertible.serialize(AND),
        if (OR != null) r'OR': _i1.JsonConvertible.serialize(OR),
        if (NOT != null) r'NOT': _i1.JsonConvertible.serialize(NOT),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId),
        if (author != null) r'author': _i1.JsonConvertible.serialize(author),
      };
}

class PostOrderByWithAggregationInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
      };
}

class PostScalarWhereWithAggregatesInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (AND != null) r'AND': _i1.JsonConvertible.serialize(AND),
        if (OR != null) r'OR': _i1.JsonConvertible.serialize(OR),
        if (NOT != null) r'NOT': _i1.JsonConvertible.serialize(NOT),
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId),
      };
}

class UserCreateInput implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        'price': _i1.JsonConvertible.serialize(price),
        'size': _i1.JsonConvertible.serialize(size),
        'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
        if (posts != null) r'posts': _i1.JsonConvertible.serialize(posts),
      };
}

class UserUncheckedCreateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        'price': _i1.JsonConvertible.serialize(price),
        'size': _i1.JsonConvertible.serialize(size),
        'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
        if (posts != null) r'posts': _i1.JsonConvertible.serialize(posts),
      };
}

class UserUpdateInput implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
        if (posts != null) r'posts': _i1.JsonConvertible.serialize(posts),
      };
}

class UserUncheckedUpdateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
        if (posts != null) r'posts': _i1.JsonConvertible.serialize(posts),
      };
}

class UserCreateManyInput implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        'price': _i1.JsonConvertible.serialize(price),
        'size': _i1.JsonConvertible.serialize(size),
        'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
      };
}

class UserUpdateManyMutationInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
      };
}

class UserUncheckedUpdateManyInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
      };
}

class PostCreateInput implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostCreateInput({
    this.id,
    required this.title,
    required this.author,
  });

  final String? id;

  final String title;

  final UserCreateNestedOneWithoutPostsInput author;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        'title': _i1.JsonConvertible.serialize(title),
        'author': _i1.JsonConvertible.serialize(author),
      };
}

class PostUncheckedCreateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostUncheckedCreateInput({
    this.id,
    required this.title,
    required this.userId,
  });

  final String? id;

  final String title;

  final int userId;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        'title': _i1.JsonConvertible.serialize(title),
        'userId': _i1.JsonConvertible.serialize(userId),
      };
}

class PostUpdateInput implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostUpdateInput({
    this.id,
    this.title,
    this.author,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;

  final UserUpdateOneRequiredWithoutPostsNestedInput? author;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (author != null) r'author': _i1.JsonConvertible.serialize(author),
      };
}

class PostUncheckedUpdateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostUncheckedUpdateInput({
    this.id,
    this.title,
    this.userId,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;

  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput>? userId;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId),
      };
}

class PostCreateManyInput implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostCreateManyInput({
    this.id,
    required this.title,
    required this.userId,
  });

  final String? id;

  final String title;

  final int userId;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        'title': _i1.JsonConvertible.serialize(title),
        'userId': _i1.JsonConvertible.serialize(userId),
      };
}

class PostUpdateManyMutationInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostUpdateManyMutationInput({
    this.id,
    this.title,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
      };
}

class PostUncheckedUpdateManyInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostUncheckedUpdateManyInput({
    this.id,
    this.title,
    this.userId,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;

  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput>? userId;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId),
      };
}

class IntFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class StringFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (contains != null)
          r'contains': _i1.JsonConvertible.serialize(contains),
        if (startsWith != null)
          r'startsWith': _i1.JsonConvertible.serialize(startsWith),
        if (endsWith != null)
          r'endsWith': _i1.JsonConvertible.serialize(endsWith),
        if (mode != null) r'mode': _i1.JsonConvertible.serialize(mode),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class EnumRoleFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class DecimalFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class BigIntFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class BytesFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class JsonNullableFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if (path != null) r'path': _i1.JsonConvertible.serialize(path),
        if (stringContains != null)
          r'string_contains': _i1.JsonConvertible.serialize(stringContains),
        if (stringStartsWith != null)
          r'string_starts_with':
              _i1.JsonConvertible.serialize(stringStartsWith),
        if (stringEndsWith != null)
          r'string_ends_with': _i1.JsonConvertible.serialize(stringEndsWith),
        if (arrayContains != null)
          r'array_contains': _i1.JsonConvertible.serialize(arrayContains),
        if (arrayStartsWith != null)
          r'array_starts_with': _i1.JsonConvertible.serialize(arrayStartsWith),
        if (arrayEndsWith != null)
          r'array_ends_with': _i1.JsonConvertible.serialize(arrayEndsWith),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class IntNullableFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class FloatFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class DateTimeFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class PostListRelationFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostListRelationFilter({
    this.every,
    this.some,
    this.none,
  });

  final PostWhereInput? every;

  final PostWhereInput? some;

  final PostWhereInput? none;

  @override
  Map<String, dynamic> toJson() => {
        if (every != null) r'every': _i1.JsonConvertible.serialize(every),
        if (some != null) r'some': _i1.JsonConvertible.serialize(some),
        if (none != null) r'none': _i1.JsonConvertible.serialize(none),
      };
}

class SortOrderInput implements _i1.JsonConvertible<Map<String, dynamic>> {
  const SortOrderInput({
    required this.sort,
    this.nulls,
  });

  final SortOrder sort;

  final NullsOrder? nulls;

  @override
  Map<String, dynamic> toJson() => {
        'sort': _i1.JsonConvertible.serialize(sort),
        if (nulls != null) r'nulls': _i1.JsonConvertible.serialize(nulls),
      };
}

class PostOrderByRelationAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostOrderByRelationAggregateInput({this.count});

  final SortOrder? count;

  @override
  Map<String, dynamic> toJson() =>
      {if (count != null) r'_count': _i1.JsonConvertible.serialize(count)};
}

class UserCountOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
      };
}

class UserAvgOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
      };
}

class UserMaxOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
      };
}

class UserMinOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
      };
}

class UserSumOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
      };
}

class IntWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class StringWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (contains != null)
          r'contains': _i1.JsonConvertible.serialize(contains),
        if (startsWith != null)
          r'startsWith': _i1.JsonConvertible.serialize(startsWith),
        if (endsWith != null)
          r'endsWith': _i1.JsonConvertible.serialize(endsWith),
        if (mode != null) r'mode': _i1.JsonConvertible.serialize(mode),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class EnumRoleWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class DecimalWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class BigIntWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class BytesWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class JsonNullableWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if (path != null) r'path': _i1.JsonConvertible.serialize(path),
        if (stringContains != null)
          r'string_contains': _i1.JsonConvertible.serialize(stringContains),
        if (stringStartsWith != null)
          r'string_starts_with':
              _i1.JsonConvertible.serialize(stringStartsWith),
        if (stringEndsWith != null)
          r'string_ends_with': _i1.JsonConvertible.serialize(stringEndsWith),
        if (arrayContains != null)
          r'array_contains': _i1.JsonConvertible.serialize(arrayContains),
        if (arrayStartsWith != null)
          r'array_starts_with': _i1.JsonConvertible.serialize(arrayStartsWith),
        if (arrayEndsWith != null)
          r'array_ends_with': _i1.JsonConvertible.serialize(arrayEndsWith),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class IntNullableWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class FloatWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class DateTimeWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class UserRelationFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
  const UserRelationFilter({
    this.$is,
    this.isNot,
  });

  final UserWhereInput? $is;

  final UserWhereInput? isNot;

  @override
  Map<String, dynamic> toJson() => {
        if ($is != null) r'is': _i1.JsonConvertible.serialize($is),
        if (isNot != null) r'isNot': _i1.JsonConvertible.serialize(isNot),
      };
}

class PostCountOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostCountOrderByAggregateInput({
    this.id,
    this.title,
    this.userId,
  });

  final SortOrder? id;

  final SortOrder? title;

  final SortOrder? userId;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId),
      };
}

class PostAvgOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostAvgOrderByAggregateInput({this.userId});

  final SortOrder? userId;

  @override
  Map<String, dynamic> toJson() =>
      {if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId)};
}

class PostMaxOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostMaxOrderByAggregateInput({
    this.id,
    this.title,
    this.userId,
  });

  final SortOrder? id;

  final SortOrder? title;

  final SortOrder? userId;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId),
      };
}

class PostMinOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostMinOrderByAggregateInput({
    this.id,
    this.title,
    this.userId,
  });

  final SortOrder? id;

  final SortOrder? title;

  final SortOrder? userId;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId),
      };
}

class PostSumOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostSumOrderByAggregateInput({this.userId});

  final SortOrder? userId;

  @override
  Map<String, dynamic> toJson() =>
      {if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId)};
}

class PostCreateNestedManyWithoutAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (create != null) r'create': _i1.JsonConvertible.serialize(create),
        if (connectOrCreate != null)
          r'connectOrCreate': _i1.JsonConvertible.serialize(connectOrCreate),
        if (createMany != null)
          r'createMany': _i1.JsonConvertible.serialize(createMany),
        if (connect != null) r'connect': _i1.JsonConvertible.serialize(connect),
      };
}

class PostUncheckedCreateNestedManyWithoutAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (create != null) r'create': _i1.JsonConvertible.serialize(create),
        if (connectOrCreate != null)
          r'connectOrCreate': _i1.JsonConvertible.serialize(connectOrCreate),
        if (createMany != null)
          r'createMany': _i1.JsonConvertible.serialize(createMany),
        if (connect != null) r'connect': _i1.JsonConvertible.serialize(connect),
      };
}

class StringFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const StringFieldUpdateOperationsInput({this.set});

  final String? set;

  @override
  Map<String, dynamic> toJson() =>
      {if (set != null) r'set': _i1.JsonConvertible.serialize(set)};
}

class EnumRoleFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const EnumRoleFieldUpdateOperationsInput({this.set});

  final Role? set;

  @override
  Map<String, dynamic> toJson() =>
      {if (set != null) r'set': _i1.JsonConvertible.serialize(set)};
}

class DecimalFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (set != null) r'set': _i1.JsonConvertible.serialize(set),
        if (increment != null)
          r'increment': _i1.JsonConvertible.serialize(increment),
        if (decrement != null)
          r'decrement': _i1.JsonConvertible.serialize(decrement),
        if (multiply != null)
          r'multiply': _i1.JsonConvertible.serialize(multiply),
        if (divide != null) r'divide': _i1.JsonConvertible.serialize(divide),
      };
}

class BigIntFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (set != null) r'set': _i1.JsonConvertible.serialize(set),
        if (increment != null)
          r'increment': _i1.JsonConvertible.serialize(increment),
        if (decrement != null)
          r'decrement': _i1.JsonConvertible.serialize(decrement),
        if (multiply != null)
          r'multiply': _i1.JsonConvertible.serialize(multiply),
        if (divide != null) r'divide': _i1.JsonConvertible.serialize(divide),
      };
}

class BytesFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const BytesFieldUpdateOperationsInput({this.set});

  final _i2.Uint8List? set;

  @override
  Map<String, dynamic> toJson() =>
      {if (set != null) r'set': _i1.JsonConvertible.serialize(set)};
}

class NullableIntFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (set != null) r'set': _i1.JsonConvertible.serialize(set),
        if (increment != null)
          r'increment': _i1.JsonConvertible.serialize(increment),
        if (decrement != null)
          r'decrement': _i1.JsonConvertible.serialize(decrement),
        if (multiply != null)
          r'multiply': _i1.JsonConvertible.serialize(multiply),
        if (divide != null) r'divide': _i1.JsonConvertible.serialize(divide),
      };
}

class FloatFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (set != null) r'set': _i1.JsonConvertible.serialize(set),
        if (increment != null)
          r'increment': _i1.JsonConvertible.serialize(increment),
        if (decrement != null)
          r'decrement': _i1.JsonConvertible.serialize(decrement),
        if (multiply != null)
          r'multiply': _i1.JsonConvertible.serialize(multiply),
        if (divide != null) r'divide': _i1.JsonConvertible.serialize(divide),
      };
}

class DateTimeFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const DateTimeFieldUpdateOperationsInput({this.set});

  final DateTime? set;

  @override
  Map<String, dynamic> toJson() =>
      {if (set != null) r'set': _i1.JsonConvertible.serialize(set)};
}

class PostUpdateManyWithoutAuthorNestedInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (create != null) r'create': _i1.JsonConvertible.serialize(create),
        if (connectOrCreate != null)
          r'connectOrCreate': _i1.JsonConvertible.serialize(connectOrCreate),
        if (upsert != null) r'upsert': _i1.JsonConvertible.serialize(upsert),
        if (createMany != null)
          r'createMany': _i1.JsonConvertible.serialize(createMany),
        if (set != null) r'set': _i1.JsonConvertible.serialize(set),
        if (disconnect != null)
          r'disconnect': _i1.JsonConvertible.serialize(disconnect),
        if (delete != null) r'delete': _i1.JsonConvertible.serialize(delete),
        if (connect != null) r'connect': _i1.JsonConvertible.serialize(connect),
        if (update != null) r'update': _i1.JsonConvertible.serialize(update),
        if (updateMany != null)
          r'updateMany': _i1.JsonConvertible.serialize(updateMany),
        if (deleteMany != null)
          r'deleteMany': _i1.JsonConvertible.serialize(deleteMany),
      };
}

class IntFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (set != null) r'set': _i1.JsonConvertible.serialize(set),
        if (increment != null)
          r'increment': _i1.JsonConvertible.serialize(increment),
        if (decrement != null)
          r'decrement': _i1.JsonConvertible.serialize(decrement),
        if (multiply != null)
          r'multiply': _i1.JsonConvertible.serialize(multiply),
        if (divide != null) r'divide': _i1.JsonConvertible.serialize(divide),
      };
}

class PostUncheckedUpdateManyWithoutAuthorNestedInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (create != null) r'create': _i1.JsonConvertible.serialize(create),
        if (connectOrCreate != null)
          r'connectOrCreate': _i1.JsonConvertible.serialize(connectOrCreate),
        if (upsert != null) r'upsert': _i1.JsonConvertible.serialize(upsert),
        if (createMany != null)
          r'createMany': _i1.JsonConvertible.serialize(createMany),
        if (set != null) r'set': _i1.JsonConvertible.serialize(set),
        if (disconnect != null)
          r'disconnect': _i1.JsonConvertible.serialize(disconnect),
        if (delete != null) r'delete': _i1.JsonConvertible.serialize(delete),
        if (connect != null) r'connect': _i1.JsonConvertible.serialize(connect),
        if (update != null) r'update': _i1.JsonConvertible.serialize(update),
        if (updateMany != null)
          r'updateMany': _i1.JsonConvertible.serialize(updateMany),
        if (deleteMany != null)
          r'deleteMany': _i1.JsonConvertible.serialize(deleteMany),
      };
}

class UserCreateNestedOneWithoutPostsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const UserCreateNestedOneWithoutPostsInput({
    this.create,
    this.connectOrCreate,
    this.connect,
  });

  final _i1.PrismaUnion<UserCreateWithoutPostsInput,
      UserUncheckedCreateWithoutPostsInput>? create;

  final UserCreateOrConnectWithoutPostsInput? connectOrCreate;

  final UserWhereUniqueInput? connect;

  @override
  Map<String, dynamic> toJson() => {
        if (create != null) r'create': _i1.JsonConvertible.serialize(create),
        if (connectOrCreate != null)
          r'connectOrCreate': _i1.JsonConvertible.serialize(connectOrCreate),
        if (connect != null) r'connect': _i1.JsonConvertible.serialize(connect),
      };
}

class UserUpdateOneRequiredWithoutPostsNestedInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (create != null) r'create': _i1.JsonConvertible.serialize(create),
        if (connectOrCreate != null)
          r'connectOrCreate': _i1.JsonConvertible.serialize(connectOrCreate),
        if (upsert != null) r'upsert': _i1.JsonConvertible.serialize(upsert),
        if (connect != null) r'connect': _i1.JsonConvertible.serialize(connect),
        if (update != null) r'update': _i1.JsonConvertible.serialize(update),
      };
}

class NestedIntFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class NestedStringFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (contains != null)
          r'contains': _i1.JsonConvertible.serialize(contains),
        if (startsWith != null)
          r'startsWith': _i1.JsonConvertible.serialize(startsWith),
        if (endsWith != null)
          r'endsWith': _i1.JsonConvertible.serialize(endsWith),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class NestedEnumRoleFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class NestedDecimalFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class NestedBigIntFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class NestedBytesFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class NestedIntNullableFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class NestedFloatFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class NestedDateTimeFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class NestedIntWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class NestedStringWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (contains != null)
          r'contains': _i1.JsonConvertible.serialize(contains),
        if (startsWith != null)
          r'startsWith': _i1.JsonConvertible.serialize(startsWith),
        if (endsWith != null)
          r'endsWith': _i1.JsonConvertible.serialize(endsWith),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class NestedEnumRoleWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class NestedDecimalWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class NestedBigIntWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class NestedBytesWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class NestedJsonNullableFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if (path != null) r'path': _i1.JsonConvertible.serialize(path),
        if (stringContains != null)
          r'string_contains': _i1.JsonConvertible.serialize(stringContains),
        if (stringStartsWith != null)
          r'string_starts_with':
              _i1.JsonConvertible.serialize(stringStartsWith),
        if (stringEndsWith != null)
          r'string_ends_with': _i1.JsonConvertible.serialize(stringEndsWith),
        if (arrayContains != null)
          r'array_contains': _i1.JsonConvertible.serialize(arrayContains),
        if (arrayStartsWith != null)
          r'array_starts_with': _i1.JsonConvertible.serialize(arrayStartsWith),
        if (arrayEndsWith != null)
          r'array_ends_with': _i1.JsonConvertible.serialize(arrayEndsWith),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class NestedIntNullableWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class NestedFloatNullableFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
      };
}

class NestedFloatWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (avg != null) r'_avg': _i1.JsonConvertible.serialize(avg),
        if (sum != null) r'_sum': _i1.JsonConvertible.serialize(sum),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class NestedDateTimeWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (equals != null) r'equals': _i1.JsonConvertible.serialize(equals),
        if ($in != null) r'in': _i1.JsonConvertible.serialize($in),
        if (notIn != null) r'notIn': _i1.JsonConvertible.serialize(notIn),
        if (lt != null) r'lt': _i1.JsonConvertible.serialize(lt),
        if (lte != null) r'lte': _i1.JsonConvertible.serialize(lte),
        if (gt != null) r'gt': _i1.JsonConvertible.serialize(gt),
        if (gte != null) r'gte': _i1.JsonConvertible.serialize(gte),
        if (not != null) r'not': _i1.JsonConvertible.serialize(not),
        if (count != null) r'_count': _i1.JsonConvertible.serialize(count),
        if (min != null) r'_min': _i1.JsonConvertible.serialize(min),
        if (max != null) r'_max': _i1.JsonConvertible.serialize(max),
      };
}

class PostCreateWithoutAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostCreateWithoutAuthorInput({
    this.id,
    required this.title,
  });

  final String? id;

  final String title;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        'title': _i1.JsonConvertible.serialize(title),
      };
}

class PostUncheckedCreateWithoutAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostUncheckedCreateWithoutAuthorInput({
    this.id,
    required this.title,
  });

  final String? id;

  final String title;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        'title': _i1.JsonConvertible.serialize(title),
      };
}

class PostCreateOrConnectWithoutAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostCreateOrConnectWithoutAuthorInput({
    required this.where,
    required this.create,
  });

  final PostWhereUniqueInput where;

  final _i1.PrismaUnion<PostCreateWithoutAuthorInput,
      PostUncheckedCreateWithoutAuthorInput> create;

  @override
  Map<String, dynamic> toJson() => {
        'where': _i1.JsonConvertible.serialize(where),
        'create': _i1.JsonConvertible.serialize(create),
      };
}

class PostCreateManyAuthorInputEnvelope
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostCreateManyAuthorInputEnvelope({
    required this.data,
    this.skipDuplicates,
  });

  final _i1.PrismaUnion<PostCreateManyAuthorInput,
      Iterable<PostCreateManyAuthorInput>> data;

  final bool? skipDuplicates;

  @override
  Map<String, dynamic> toJson() => {
        'data': _i1.JsonConvertible.serialize(data),
        if (skipDuplicates != null)
          r'skipDuplicates': _i1.JsonConvertible.serialize(skipDuplicates),
      };
}

class PostUpsertWithWhereUniqueWithoutAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        'where': _i1.JsonConvertible.serialize(where),
        'update': _i1.JsonConvertible.serialize(update),
        'create': _i1.JsonConvertible.serialize(create),
      };
}

class PostUpdateWithWhereUniqueWithoutAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostUpdateWithWhereUniqueWithoutAuthorInput({
    required this.where,
    required this.data,
  });

  final PostWhereUniqueInput where;

  final _i1.PrismaUnion<PostUpdateWithoutAuthorInput,
      PostUncheckedUpdateWithoutAuthorInput> data;

  @override
  Map<String, dynamic> toJson() => {
        'where': _i1.JsonConvertible.serialize(where),
        'data': _i1.JsonConvertible.serialize(data),
      };
}

class PostUpdateManyWithWhereWithoutAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostUpdateManyWithWhereWithoutAuthorInput({
    required this.where,
    required this.data,
  });

  final PostScalarWhereInput where;

  final _i1.PrismaUnion<PostUpdateManyMutationInput,
      PostUncheckedUpdateManyWithoutAuthorInput> data;

  @override
  Map<String, dynamic> toJson() => {
        'where': _i1.JsonConvertible.serialize(where),
        'data': _i1.JsonConvertible.serialize(data),
      };
}

class PostScalarWhereInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (AND != null) r'AND': _i1.JsonConvertible.serialize(AND),
        if (OR != null) r'OR': _i1.JsonConvertible.serialize(OR),
        if (NOT != null) r'NOT': _i1.JsonConvertible.serialize(NOT),
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
        if (userId != null) r'userId': _i1.JsonConvertible.serialize(userId),
      };
}

class UserCreateWithoutPostsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        'price': _i1.JsonConvertible.serialize(price),
        'size': _i1.JsonConvertible.serialize(size),
        'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
      };
}

class UserUncheckedCreateWithoutPostsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        'price': _i1.JsonConvertible.serialize(price),
        'size': _i1.JsonConvertible.serialize(size),
        'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
      };
}

class UserCreateOrConnectWithoutPostsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const UserCreateOrConnectWithoutPostsInput({
    required this.where,
    required this.create,
  });

  final UserWhereUniqueInput where;

  final _i1.PrismaUnion<UserCreateWithoutPostsInput,
      UserUncheckedCreateWithoutPostsInput> create;

  @override
  Map<String, dynamic> toJson() => {
        'where': _i1.JsonConvertible.serialize(where),
        'create': _i1.JsonConvertible.serialize(create),
      };
}

class UserUpsertWithoutPostsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        'update': _i1.JsonConvertible.serialize(update),
        'create': _i1.JsonConvertible.serialize(create),
        if (where != null) r'where': _i1.JsonConvertible.serialize(where),
      };
}

class UserUpdateToOneWithWhereWithoutPostsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const UserUpdateToOneWithWhereWithoutPostsInput({
    this.where,
    required this.data,
  });

  final UserWhereInput? where;

  final _i1.PrismaUnion<UserUpdateWithoutPostsInput,
      UserUncheckedUpdateWithoutPostsInput> data;

  @override
  Map<String, dynamic> toJson() => {
        if (where != null) r'where': _i1.JsonConvertible.serialize(where),
        'data': _i1.JsonConvertible.serialize(data),
      };
}

class UserUpdateWithoutPostsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
      };
}

class UserUncheckedUpdateWithoutPostsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
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

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (name != null) r'name': _i1.JsonConvertible.serialize(name),
        if (role != null) r'role': _i1.JsonConvertible.serialize(role),
        if (price != null) r'price': _i1.JsonConvertible.serialize(price),
        if (size != null) r'size': _i1.JsonConvertible.serialize(size),
        if (bytes != null) r'bytes': _i1.JsonConvertible.serialize(bytes),
        if (json != null) r'json': _i1.JsonConvertible.serialize(json),
        if (age != null) r'age': _i1.JsonConvertible.serialize(age),
        if (demo != null) r'demo': _i1.JsonConvertible.serialize(demo),
        if (createdAt != null)
          r'createdAt': _i1.JsonConvertible.serialize(createdAt),
      };
}

class PostCreateManyAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostCreateManyAuthorInput({
    this.id,
    required this.title,
  });

  final String? id;

  final String title;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        'title': _i1.JsonConvertible.serialize(title),
      };
}

class PostUpdateWithoutAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostUpdateWithoutAuthorInput({
    this.id,
    this.title,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
      };
}

class PostUncheckedUpdateWithoutAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostUncheckedUpdateWithoutAuthorInput({
    this.id,
    this.title,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
      };
}

class PostUncheckedUpdateManyWithoutAuthorInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const PostUncheckedUpdateManyWithoutAuthorInput({
    this.id,
    this.title,
  });

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput>? title;

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) r'id': _i1.JsonConvertible.serialize(id),
        if (title != null) r'title': _i1.JsonConvertible.serialize(title),
      };
}
