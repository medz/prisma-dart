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
  final _i1.PrismaUnion<UserWhereInput, UserWhereInput> AND;

  final UserWhereInput OR;

  final _i1.PrismaUnion<UserWhereInput, UserWhereInput> NOT;

  final _i1.PrismaUnion<IntFilter, int> id;

  final _i1.PrismaUnion<StringFilter, String> name;

  final _i1.PrismaUnion<EnumRoleFilter, Role> role;

  final _i1.PrismaUnion<DecimalFilter, _i1.Decimal> price;

  final _i1.PrismaUnion<BigIntFilter, BigInt> size;

  final _i1.PrismaUnion<BytesFilter, _i2.Uint8List> bytes;

  final JsonNullableFilter json;

  final _i1.PrismaUnion<IntNullableFilter, _i1.PrismaUnion<int, Null>> age;

  final _i1.PrismaUnion<FloatFilter, double> demo;

  final _i1.PrismaUnion<DateTimeFilter, DateTime> createdAt;

  final PostListRelationFilter posts;
}

class UserOrderByWithRelationInput {
  final SortOrder id;

  final SortOrder name;

  final SortOrder role;

  final SortOrder price;

  final SortOrder size;

  final SortOrder bytes;

  final _i1.PrismaUnion<SortOrder, SortOrderInput> json;

  final _i1.PrismaUnion<SortOrder, SortOrderInput> age;

  final SortOrder demo;

  final SortOrder createdAt;

  final PostOrderByRelationAggregateInput posts;
}

class UserWhereUniqueInput {
  final int id;

  final _i1.PrismaUnion<UserWhereInput, UserWhereInput> AND;

  final UserWhereInput OR;

  final _i1.PrismaUnion<UserWhereInput, UserWhereInput> NOT;

  final _i1.PrismaUnion<StringFilter, String> name;

  final _i1.PrismaUnion<EnumRoleFilter, Role> role;

  final _i1.PrismaUnion<DecimalFilter, _i1.Decimal> price;

  final _i1.PrismaUnion<BigIntFilter, BigInt> size;

  final _i1.PrismaUnion<BytesFilter, _i2.Uint8List> bytes;

  final JsonNullableFilter json;

  final _i1.PrismaUnion<IntNullableFilter, _i1.PrismaUnion<int, Null>> age;

  final _i1.PrismaUnion<FloatFilter, double> demo;

  final _i1.PrismaUnion<DateTimeFilter, DateTime> createdAt;

  final PostListRelationFilter posts;
}

class UserOrderByWithAggregationInput {
  final SortOrder id;

  final SortOrder name;

  final SortOrder role;

  final SortOrder price;

  final SortOrder size;

  final SortOrder bytes;

  final _i1.PrismaUnion<SortOrder, SortOrderInput> json;

  final _i1.PrismaUnion<SortOrder, SortOrderInput> age;

  final SortOrder demo;

  final SortOrder createdAt;

  final UserCountOrderByAggregateInput count;

  final UserAvgOrderByAggregateInput avg;

  final UserMaxOrderByAggregateInput max;

  final UserMinOrderByAggregateInput min;

  final UserSumOrderByAggregateInput sum;
}

class UserScalarWhereWithAggregatesInput {
  final _i1.PrismaUnion<UserScalarWhereWithAggregatesInput,
      UserScalarWhereWithAggregatesInput> AND;

  final UserScalarWhereWithAggregatesInput OR;

  final _i1.PrismaUnion<UserScalarWhereWithAggregatesInput,
      UserScalarWhereWithAggregatesInput> NOT;

  final _i1.PrismaUnion<IntWithAggregatesFilter, int> id;

  final _i1.PrismaUnion<StringWithAggregatesFilter, String> name;

  final _i1.PrismaUnion<EnumRoleWithAggregatesFilter, Role> role;

  final _i1.PrismaUnion<DecimalWithAggregatesFilter, _i1.Decimal> price;

  final _i1.PrismaUnion<BigIntWithAggregatesFilter, BigInt> size;

  final _i1.PrismaUnion<BytesWithAggregatesFilter, _i2.Uint8List> bytes;

  final JsonNullableWithAggregatesFilter json;

  final _i1
      .PrismaUnion<IntNullableWithAggregatesFilter, _i1.PrismaUnion<int, Null>>
      age;

  final _i1.PrismaUnion<FloatWithAggregatesFilter, double> demo;

  final _i1.PrismaUnion<DateTimeWithAggregatesFilter, DateTime> createdAt;
}

class PostWhereInput {
  final _i1.PrismaUnion<PostWhereInput, PostWhereInput> AND;

  final PostWhereInput OR;

  final _i1.PrismaUnion<PostWhereInput, PostWhereInput> NOT;

  final _i1.PrismaUnion<StringFilter, String> id;

  final _i1.PrismaUnion<StringFilter, String> title;

  final _i1.PrismaUnion<IntFilter, int> userId;

  final _i1.PrismaUnion<UserRelationFilter, UserWhereInput> author;
}

class PostOrderByWithRelationInput {
  final SortOrder id;

  final SortOrder title;

  final SortOrder userId;

  final UserOrderByWithRelationInput author;
}

class PostWhereUniqueInput {
  final String id;

  final _i1.PrismaUnion<PostWhereInput, PostWhereInput> AND;

  final PostWhereInput OR;

  final _i1.PrismaUnion<PostWhereInput, PostWhereInput> NOT;

  final _i1.PrismaUnion<StringFilter, String> title;

  final _i1.PrismaUnion<IntFilter, int> userId;

  final _i1.PrismaUnion<UserRelationFilter, UserWhereInput> author;
}

class PostOrderByWithAggregationInput {
  final SortOrder id;

  final SortOrder title;

  final SortOrder userId;

  final PostCountOrderByAggregateInput count;

  final PostAvgOrderByAggregateInput avg;

  final PostMaxOrderByAggregateInput max;

  final PostMinOrderByAggregateInput min;

  final PostSumOrderByAggregateInput sum;
}

class PostScalarWhereWithAggregatesInput {
  final _i1.PrismaUnion<PostScalarWhereWithAggregatesInput,
      PostScalarWhereWithAggregatesInput> AND;

  final PostScalarWhereWithAggregatesInput OR;

  final _i1.PrismaUnion<PostScalarWhereWithAggregatesInput,
      PostScalarWhereWithAggregatesInput> NOT;

  final _i1.PrismaUnion<StringWithAggregatesFilter, String> id;

  final _i1.PrismaUnion<StringWithAggregatesFilter, String> title;

  final _i1.PrismaUnion<IntWithAggregatesFilter, int> userId;
}

class UserCreateInput {
  final String name;

  final Role role;

  final _i1.Decimal price;

  final BigInt size;

  final _i2.Uint8List bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson> json;

  final _i1.PrismaUnion<int, Null> age;

  final double demo;

  final DateTime createdAt;

  final PostCreateNestedManyWithoutAuthorInput posts;
}

class UserUncheckedCreateInput {
  final int id;

  final String name;

  final Role role;

  final _i1.Decimal price;

  final BigInt size;

  final _i2.Uint8List bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson> json;

  final _i1.PrismaUnion<int, Null> age;

  final double demo;

  final DateTime createdAt;

  final PostUncheckedCreateNestedManyWithoutAuthorInput posts;
}

class UserUpdateInput {
  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput> role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput> price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput> size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput> bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson> json;

  final _i1.PrismaUnion<int,
      _i1.PrismaUnion<NullableIntFieldUpdateOperationsInput, Null>> age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput> demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput> createdAt;

  final PostUpdateManyWithoutAuthorNestedInput posts;
}

class UserUncheckedUpdateInput {
  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput> id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput> role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput> price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput> size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput> bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson> json;

  final _i1.PrismaUnion<int,
      _i1.PrismaUnion<NullableIntFieldUpdateOperationsInput, Null>> age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput> demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput> createdAt;

  final PostUncheckedUpdateManyWithoutAuthorNestedInput posts;
}

class UserCreateManyInput {
  final int id;

  final String name;

  final Role role;

  final _i1.Decimal price;

  final BigInt size;

  final _i2.Uint8List bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson> json;

  final _i1.PrismaUnion<int, Null> age;

  final double demo;

  final DateTime createdAt;
}

class UserUpdateManyMutationInput {
  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput> role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput> price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput> size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput> bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson> json;

  final _i1.PrismaUnion<int,
      _i1.PrismaUnion<NullableIntFieldUpdateOperationsInput, Null>> age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput> demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput> createdAt;
}

class UserUncheckedUpdateManyInput {
  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput> id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput> role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput> price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput> size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput> bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson> json;

  final _i1.PrismaUnion<int,
      _i1.PrismaUnion<NullableIntFieldUpdateOperationsInput, Null>> age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput> demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput> createdAt;
}

class PostCreateInput {
  final String id;

  final String title;

  final UserCreateNestedOneWithoutPostsInput author;
}

class PostUncheckedCreateInput {
  final String id;

  final String title;

  final int userId;
}

class PostUpdateInput {
  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> title;

  final UserUpdateOneRequiredWithoutPostsNestedInput author;
}

class PostUncheckedUpdateInput {
  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> title;

  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput> userId;
}

class PostCreateManyInput {
  final String id;

  final String title;

  final int userId;
}

class PostUpdateManyMutationInput {
  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> title;
}

class PostUncheckedUpdateManyInput {
  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> title;

  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput> userId;
}

class IntFilter {
  final _i1.PrismaUnion<int, IntFieldRefInput> equals;

  final _i1.PrismaUnion<int, ListIntFieldRefInput> $in;

  final _i1.PrismaUnion<int, ListIntFieldRefInput> notIn;

  final _i1.PrismaUnion<int, IntFieldRefInput> lt;

  final _i1.PrismaUnion<int, IntFieldRefInput> lte;

  final _i1.PrismaUnion<int, IntFieldRefInput> gt;

  final _i1.PrismaUnion<int, IntFieldRefInput> gte;

  final _i1.PrismaUnion<int, NestedIntFilter> not;
}

class StringFilter {
  final _i1.PrismaUnion<String, StringFieldRefInput> equals;

  final _i1.PrismaUnion<String, ListStringFieldRefInput> $in;

  final _i1.PrismaUnion<String, ListStringFieldRefInput> notIn;

  final _i1.PrismaUnion<String, StringFieldRefInput> lt;

  final _i1.PrismaUnion<String, StringFieldRefInput> lte;

  final _i1.PrismaUnion<String, StringFieldRefInput> gt;

  final _i1.PrismaUnion<String, StringFieldRefInput> gte;

  final _i1.PrismaUnion<String, StringFieldRefInput> contains;

  final _i1.PrismaUnion<String, StringFieldRefInput> startsWith;

  final _i1.PrismaUnion<String, StringFieldRefInput> endsWith;

  final QueryMode mode;

  final _i1.PrismaUnion<String, NestedStringFilter> not;
}

class EnumRoleFilter {
  final _i1.PrismaUnion<Role, EnumRoleFieldRefInput> equals;

  final _i1.PrismaUnion<Role, ListEnumRoleFieldRefInput> $in;

  final _i1.PrismaUnion<Role, ListEnumRoleFieldRefInput> notIn;

  final _i1.PrismaUnion<Role, NestedEnumRoleFilter> not;
}

class DecimalFilter {
  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> equals;

  final _i1.PrismaUnion<_i1.Decimal, ListDecimalFieldRefInput> $in;

  final _i1.PrismaUnion<_i1.Decimal, ListDecimalFieldRefInput> notIn;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> lt;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> lte;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> gt;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> gte;

  final _i1.PrismaUnion<_i1.Decimal, NestedDecimalFilter> not;
}

class BigIntFilter {
  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> equals;

  final _i1.PrismaUnion<BigInt, ListBigIntFieldRefInput> $in;

  final _i1.PrismaUnion<BigInt, ListBigIntFieldRefInput> notIn;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> lt;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> lte;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> gt;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> gte;

  final _i1.PrismaUnion<BigInt, NestedBigIntFilter> not;
}

class BytesFilter {
  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldRefInput> equals;

  final _i1.PrismaUnion<_i2.Uint8List, ListBytesFieldRefInput> $in;

  final _i1.PrismaUnion<_i2.Uint8List, ListBytesFieldRefInput> notIn;

  final _i1.PrismaUnion<_i2.Uint8List, NestedBytesFilter> not;
}

class JsonNullableFilter {
  final _i1.PrismaUnion<_i1.PrismaJson,
      _i1.PrismaUnion<JsonFieldRefInput, JsonNullValueFilter>> equals;

  final String path;

  final _i1.PrismaUnion<String, StringFieldRefInput> stringContains;

  final _i1.PrismaUnion<String, StringFieldRefInput> stringStartsWith;

  final _i1.PrismaUnion<String, StringFieldRefInput> stringEndsWith;

  final _i1
      .PrismaUnion<_i1.PrismaJson, _i1.PrismaUnion<JsonFieldRefInput, Null>>
      arrayContains;

  final _i1
      .PrismaUnion<_i1.PrismaJson, _i1.PrismaUnion<JsonFieldRefInput, Null>>
      arrayStartsWith;

  final _i1
      .PrismaUnion<_i1.PrismaJson, _i1.PrismaUnion<JsonFieldRefInput, Null>>
      arrayEndsWith;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> lt;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> lte;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> gt;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> gte;

  final _i1.PrismaUnion<_i1.PrismaJson,
      _i1.PrismaUnion<JsonFieldRefInput, JsonNullValueFilter>> not;
}

class IntNullableFilter {
  final _i1.PrismaUnion<int, _i1.PrismaUnion<IntFieldRefInput, Null>> equals;

  final _i1.PrismaUnion<int, _i1.PrismaUnion<ListIntFieldRefInput, Null>> $in;

  final _i1.PrismaUnion<int, _i1.PrismaUnion<ListIntFieldRefInput, Null>> notIn;

  final _i1.PrismaUnion<int, IntFieldRefInput> lt;

  final _i1.PrismaUnion<int, IntFieldRefInput> lte;

  final _i1.PrismaUnion<int, IntFieldRefInput> gt;

  final _i1.PrismaUnion<int, IntFieldRefInput> gte;

  final _i1.PrismaUnion<int, _i1.PrismaUnion<NestedIntNullableFilter, Null>>
      not;
}

class FloatFilter {
  final _i1.PrismaUnion<double, FloatFieldRefInput> equals;

  final _i1.PrismaUnion<double, ListFloatFieldRefInput> $in;

  final _i1.PrismaUnion<double, ListFloatFieldRefInput> notIn;

  final _i1.PrismaUnion<double, FloatFieldRefInput> lt;

  final _i1.PrismaUnion<double, FloatFieldRefInput> lte;

  final _i1.PrismaUnion<double, FloatFieldRefInput> gt;

  final _i1.PrismaUnion<double, FloatFieldRefInput> gte;

  final _i1.PrismaUnion<double, NestedFloatFilter> not;
}

class DateTimeFilter {
  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> equals;

  final _i1.PrismaUnion<DateTime, ListDateTimeFieldRefInput> $in;

  final _i1.PrismaUnion<DateTime, ListDateTimeFieldRefInput> notIn;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> lt;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> lte;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> gt;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> gte;

  final _i1.PrismaUnion<DateTime, NestedDateTimeFilter> not;
}

class PostListRelationFilter {
  final PostWhereInput every;

  final PostWhereInput some;

  final PostWhereInput none;
}

class SortOrderInput {
  final SortOrder sort;

  final NullsOrder nulls;
}

class PostOrderByRelationAggregateInput {
  final SortOrder count;
}

class UserCountOrderByAggregateInput {
  final SortOrder id;

  final SortOrder name;

  final SortOrder role;

  final SortOrder price;

  final SortOrder size;

  final SortOrder bytes;

  final SortOrder json;

  final SortOrder age;

  final SortOrder demo;

  final SortOrder createdAt;
}

class UserAvgOrderByAggregateInput {
  final SortOrder id;

  final SortOrder price;

  final SortOrder size;

  final SortOrder age;

  final SortOrder demo;
}

class UserMaxOrderByAggregateInput {
  final SortOrder id;

  final SortOrder name;

  final SortOrder role;

  final SortOrder price;

  final SortOrder size;

  final SortOrder bytes;

  final SortOrder age;

  final SortOrder demo;

  final SortOrder createdAt;
}

class UserMinOrderByAggregateInput {
  final SortOrder id;

  final SortOrder name;

  final SortOrder role;

  final SortOrder price;

  final SortOrder size;

  final SortOrder bytes;

  final SortOrder age;

  final SortOrder demo;

  final SortOrder createdAt;
}

class UserSumOrderByAggregateInput {
  final SortOrder id;

  final SortOrder price;

  final SortOrder size;

  final SortOrder age;

  final SortOrder demo;
}

class IntWithAggregatesFilter {
  final _i1.PrismaUnion<int, IntFieldRefInput> equals;

  final _i1.PrismaUnion<int, ListIntFieldRefInput> $in;

  final _i1.PrismaUnion<int, ListIntFieldRefInput> notIn;

  final _i1.PrismaUnion<int, IntFieldRefInput> lt;

  final _i1.PrismaUnion<int, IntFieldRefInput> lte;

  final _i1.PrismaUnion<int, IntFieldRefInput> gt;

  final _i1.PrismaUnion<int, IntFieldRefInput> gte;

  final _i1.PrismaUnion<int, NestedIntWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedFloatFilter avg;

  final NestedIntFilter sum;

  final NestedIntFilter min;

  final NestedIntFilter max;
}

class StringWithAggregatesFilter {
  final _i1.PrismaUnion<String, StringFieldRefInput> equals;

  final _i1.PrismaUnion<String, ListStringFieldRefInput> $in;

  final _i1.PrismaUnion<String, ListStringFieldRefInput> notIn;

  final _i1.PrismaUnion<String, StringFieldRefInput> lt;

  final _i1.PrismaUnion<String, StringFieldRefInput> lte;

  final _i1.PrismaUnion<String, StringFieldRefInput> gt;

  final _i1.PrismaUnion<String, StringFieldRefInput> gte;

  final _i1.PrismaUnion<String, StringFieldRefInput> contains;

  final _i1.PrismaUnion<String, StringFieldRefInput> startsWith;

  final _i1.PrismaUnion<String, StringFieldRefInput> endsWith;

  final QueryMode mode;

  final _i1.PrismaUnion<String, NestedStringWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedStringFilter min;

  final NestedStringFilter max;
}

class EnumRoleWithAggregatesFilter {
  final _i1.PrismaUnion<Role, EnumRoleFieldRefInput> equals;

  final _i1.PrismaUnion<Role, ListEnumRoleFieldRefInput> $in;

  final _i1.PrismaUnion<Role, ListEnumRoleFieldRefInput> notIn;

  final _i1.PrismaUnion<Role, NestedEnumRoleWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedEnumRoleFilter min;

  final NestedEnumRoleFilter max;
}

class DecimalWithAggregatesFilter {
  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> equals;

  final _i1.PrismaUnion<_i1.Decimal, ListDecimalFieldRefInput> $in;

  final _i1.PrismaUnion<_i1.Decimal, ListDecimalFieldRefInput> notIn;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> lt;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> lte;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> gt;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> gte;

  final _i1.PrismaUnion<_i1.Decimal, NestedDecimalWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedDecimalFilter avg;

  final NestedDecimalFilter sum;

  final NestedDecimalFilter min;

  final NestedDecimalFilter max;
}

class BigIntWithAggregatesFilter {
  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> equals;

  final _i1.PrismaUnion<BigInt, ListBigIntFieldRefInput> $in;

  final _i1.PrismaUnion<BigInt, ListBigIntFieldRefInput> notIn;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> lt;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> lte;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> gt;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> gte;

  final _i1.PrismaUnion<BigInt, NestedBigIntWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedFloatFilter avg;

  final NestedBigIntFilter sum;

  final NestedBigIntFilter min;

  final NestedBigIntFilter max;
}

class BytesWithAggregatesFilter {
  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldRefInput> equals;

  final _i1.PrismaUnion<_i2.Uint8List, ListBytesFieldRefInput> $in;

  final _i1.PrismaUnion<_i2.Uint8List, ListBytesFieldRefInput> notIn;

  final _i1.PrismaUnion<_i2.Uint8List, NestedBytesWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedBytesFilter min;

  final NestedBytesFilter max;
}

class JsonNullableWithAggregatesFilter {
  final _i1.PrismaUnion<_i1.PrismaJson,
      _i1.PrismaUnion<JsonFieldRefInput, JsonNullValueFilter>> equals;

  final String path;

  final _i1.PrismaUnion<String, StringFieldRefInput> stringContains;

  final _i1.PrismaUnion<String, StringFieldRefInput> stringStartsWith;

  final _i1.PrismaUnion<String, StringFieldRefInput> stringEndsWith;

  final _i1
      .PrismaUnion<_i1.PrismaJson, _i1.PrismaUnion<JsonFieldRefInput, Null>>
      arrayContains;

  final _i1
      .PrismaUnion<_i1.PrismaJson, _i1.PrismaUnion<JsonFieldRefInput, Null>>
      arrayStartsWith;

  final _i1
      .PrismaUnion<_i1.PrismaJson, _i1.PrismaUnion<JsonFieldRefInput, Null>>
      arrayEndsWith;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> lt;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> lte;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> gt;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> gte;

  final _i1.PrismaUnion<_i1.PrismaJson,
      _i1.PrismaUnion<JsonFieldRefInput, JsonNullValueFilter>> not;

  final NestedIntNullableFilter count;

  final NestedJsonNullableFilter min;

  final NestedJsonNullableFilter max;
}

class IntNullableWithAggregatesFilter {
  final _i1.PrismaUnion<int, _i1.PrismaUnion<IntFieldRefInput, Null>> equals;

  final _i1.PrismaUnion<int, _i1.PrismaUnion<ListIntFieldRefInput, Null>> $in;

  final _i1.PrismaUnion<int, _i1.PrismaUnion<ListIntFieldRefInput, Null>> notIn;

  final _i1.PrismaUnion<int, IntFieldRefInput> lt;

  final _i1.PrismaUnion<int, IntFieldRefInput> lte;

  final _i1.PrismaUnion<int, IntFieldRefInput> gt;

  final _i1.PrismaUnion<int, IntFieldRefInput> gte;

  final _i1.PrismaUnion<int,
      _i1.PrismaUnion<NestedIntNullableWithAggregatesFilter, Null>> not;

  final NestedIntNullableFilter count;

  final NestedFloatNullableFilter avg;

  final NestedIntNullableFilter sum;

  final NestedIntNullableFilter min;

  final NestedIntNullableFilter max;
}

class FloatWithAggregatesFilter {
  final _i1.PrismaUnion<double, FloatFieldRefInput> equals;

  final _i1.PrismaUnion<double, ListFloatFieldRefInput> $in;

  final _i1.PrismaUnion<double, ListFloatFieldRefInput> notIn;

  final _i1.PrismaUnion<double, FloatFieldRefInput> lt;

  final _i1.PrismaUnion<double, FloatFieldRefInput> lte;

  final _i1.PrismaUnion<double, FloatFieldRefInput> gt;

  final _i1.PrismaUnion<double, FloatFieldRefInput> gte;

  final _i1.PrismaUnion<double, NestedFloatWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedFloatFilter avg;

  final NestedFloatFilter sum;

  final NestedFloatFilter min;

  final NestedFloatFilter max;
}

class DateTimeWithAggregatesFilter {
  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> equals;

  final _i1.PrismaUnion<DateTime, ListDateTimeFieldRefInput> $in;

  final _i1.PrismaUnion<DateTime, ListDateTimeFieldRefInput> notIn;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> lt;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> lte;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> gt;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> gte;

  final _i1.PrismaUnion<DateTime, NestedDateTimeWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedDateTimeFilter min;

  final NestedDateTimeFilter max;
}

class UserRelationFilter {
  final UserWhereInput $is;

  final UserWhereInput isNot;
}

class PostCountOrderByAggregateInput {
  final SortOrder id;

  final SortOrder title;

  final SortOrder userId;
}

class PostAvgOrderByAggregateInput {
  final SortOrder userId;
}

class PostMaxOrderByAggregateInput {
  final SortOrder id;

  final SortOrder title;

  final SortOrder userId;
}

class PostMinOrderByAggregateInput {
  final SortOrder id;

  final SortOrder title;

  final SortOrder userId;
}

class PostSumOrderByAggregateInput {
  final SortOrder userId;
}

class PostCreateNestedManyWithoutAuthorInput {
  final _i1.PrismaUnion<
      PostCreateWithoutAuthorInput,
      _i1.PrismaUnion<
          PostCreateWithoutAuthorInput,
          _i1.PrismaUnion<PostUncheckedCreateWithoutAuthorInput,
              PostUncheckedCreateWithoutAuthorInput>>> create;

  final _i1.PrismaUnion<PostCreateOrConnectWithoutAuthorInput,
      PostCreateOrConnectWithoutAuthorInput> connectOrCreate;

  final PostCreateManyAuthorInputEnvelope createMany;

  final _i1.PrismaUnion<PostWhereUniqueInput, PostWhereUniqueInput> connect;
}

class PostUncheckedCreateNestedManyWithoutAuthorInput {
  final _i1.PrismaUnion<
      PostCreateWithoutAuthorInput,
      _i1.PrismaUnion<
          PostCreateWithoutAuthorInput,
          _i1.PrismaUnion<PostUncheckedCreateWithoutAuthorInput,
              PostUncheckedCreateWithoutAuthorInput>>> create;

  final _i1.PrismaUnion<PostCreateOrConnectWithoutAuthorInput,
      PostCreateOrConnectWithoutAuthorInput> connectOrCreate;

  final PostCreateManyAuthorInputEnvelope createMany;

  final _i1.PrismaUnion<PostWhereUniqueInput, PostWhereUniqueInput> connect;
}

class StringFieldUpdateOperationsInput {
  final String set;
}

class EnumRoleFieldUpdateOperationsInput {
  final Role set;
}

class DecimalFieldUpdateOperationsInput {
  final _i1.Decimal set;

  final _i1.Decimal increment;

  final _i1.Decimal decrement;

  final _i1.Decimal multiply;

  final _i1.Decimal divide;
}

class BigIntFieldUpdateOperationsInput {
  final BigInt set;

  final BigInt increment;

  final BigInt decrement;

  final BigInt multiply;

  final BigInt divide;
}

class BytesFieldUpdateOperationsInput {
  final _i2.Uint8List set;
}

class NullableIntFieldUpdateOperationsInput {
  final _i1.PrismaUnion<int, Null> set;

  final int increment;

  final int decrement;

  final int multiply;

  final int divide;
}

class FloatFieldUpdateOperationsInput {
  final double set;

  final double increment;

  final double decrement;

  final double multiply;

  final double divide;
}

class DateTimeFieldUpdateOperationsInput {
  final DateTime set;
}

class PostUpdateManyWithoutAuthorNestedInput {
  final _i1.PrismaUnion<
      PostCreateWithoutAuthorInput,
      _i1.PrismaUnion<
          PostCreateWithoutAuthorInput,
          _i1.PrismaUnion<PostUncheckedCreateWithoutAuthorInput,
              PostUncheckedCreateWithoutAuthorInput>>> create;

  final _i1.PrismaUnion<PostCreateOrConnectWithoutAuthorInput,
      PostCreateOrConnectWithoutAuthorInput> connectOrCreate;

  final _i1.PrismaUnion<PostUpsertWithWhereUniqueWithoutAuthorInput,
      PostUpsertWithWhereUniqueWithoutAuthorInput> upsert;

  final PostCreateManyAuthorInputEnvelope createMany;

  final _i1.PrismaUnion<PostWhereUniqueInput, PostWhereUniqueInput> set;

  final _i1.PrismaUnion<PostWhereUniqueInput, PostWhereUniqueInput> disconnect;

  final _i1.PrismaUnion<PostWhereUniqueInput, PostWhereUniqueInput> delete;

  final _i1.PrismaUnion<PostWhereUniqueInput, PostWhereUniqueInput> connect;

  final _i1.PrismaUnion<PostUpdateWithWhereUniqueWithoutAuthorInput,
      PostUpdateWithWhereUniqueWithoutAuthorInput> update;

  final _i1.PrismaUnion<PostUpdateManyWithWhereWithoutAuthorInput,
      PostUpdateManyWithWhereWithoutAuthorInput> updateMany;

  final _i1.PrismaUnion<PostScalarWhereInput, PostScalarWhereInput> deleteMany;
}

class IntFieldUpdateOperationsInput {
  final int set;

  final int increment;

  final int decrement;

  final int multiply;

  final int divide;
}

class PostUncheckedUpdateManyWithoutAuthorNestedInput {
  final _i1.PrismaUnion<
      PostCreateWithoutAuthorInput,
      _i1.PrismaUnion<
          PostCreateWithoutAuthorInput,
          _i1.PrismaUnion<PostUncheckedCreateWithoutAuthorInput,
              PostUncheckedCreateWithoutAuthorInput>>> create;

  final _i1.PrismaUnion<PostCreateOrConnectWithoutAuthorInput,
      PostCreateOrConnectWithoutAuthorInput> connectOrCreate;

  final _i1.PrismaUnion<PostUpsertWithWhereUniqueWithoutAuthorInput,
      PostUpsertWithWhereUniqueWithoutAuthorInput> upsert;

  final PostCreateManyAuthorInputEnvelope createMany;

  final _i1.PrismaUnion<PostWhereUniqueInput, PostWhereUniqueInput> set;

  final _i1.PrismaUnion<PostWhereUniqueInput, PostWhereUniqueInput> disconnect;

  final _i1.PrismaUnion<PostWhereUniqueInput, PostWhereUniqueInput> delete;

  final _i1.PrismaUnion<PostWhereUniqueInput, PostWhereUniqueInput> connect;

  final _i1.PrismaUnion<PostUpdateWithWhereUniqueWithoutAuthorInput,
      PostUpdateWithWhereUniqueWithoutAuthorInput> update;

  final _i1.PrismaUnion<PostUpdateManyWithWhereWithoutAuthorInput,
      PostUpdateManyWithWhereWithoutAuthorInput> updateMany;

  final _i1.PrismaUnion<PostScalarWhereInput, PostScalarWhereInput> deleteMany;
}

class UserCreateNestedOneWithoutPostsInput {
  final _i1.PrismaUnion<UserCreateWithoutPostsInput,
      UserUncheckedCreateWithoutPostsInput> create;

  final UserCreateOrConnectWithoutPostsInput connectOrCreate;

  final UserWhereUniqueInput connect;
}

class UserUpdateOneRequiredWithoutPostsNestedInput {
  final _i1.PrismaUnion<UserCreateWithoutPostsInput,
      UserUncheckedCreateWithoutPostsInput> create;

  final UserCreateOrConnectWithoutPostsInput connectOrCreate;

  final UserUpsertWithoutPostsInput upsert;

  final UserWhereUniqueInput connect;

  final _i1.PrismaUnion<
      UserUpdateToOneWithWhereWithoutPostsInput,
      _i1.PrismaUnion<UserUpdateWithoutPostsInput,
          UserUncheckedUpdateWithoutPostsInput>> update;
}

class NestedIntFilter {
  final _i1.PrismaUnion<int, IntFieldRefInput> equals;

  final _i1.PrismaUnion<int, ListIntFieldRefInput> $in;

  final _i1.PrismaUnion<int, ListIntFieldRefInput> notIn;

  final _i1.PrismaUnion<int, IntFieldRefInput> lt;

  final _i1.PrismaUnion<int, IntFieldRefInput> lte;

  final _i1.PrismaUnion<int, IntFieldRefInput> gt;

  final _i1.PrismaUnion<int, IntFieldRefInput> gte;

  final _i1.PrismaUnion<int, NestedIntFilter> not;
}

class NestedStringFilter {
  final _i1.PrismaUnion<String, StringFieldRefInput> equals;

  final _i1.PrismaUnion<String, ListStringFieldRefInput> $in;

  final _i1.PrismaUnion<String, ListStringFieldRefInput> notIn;

  final _i1.PrismaUnion<String, StringFieldRefInput> lt;

  final _i1.PrismaUnion<String, StringFieldRefInput> lte;

  final _i1.PrismaUnion<String, StringFieldRefInput> gt;

  final _i1.PrismaUnion<String, StringFieldRefInput> gte;

  final _i1.PrismaUnion<String, StringFieldRefInput> contains;

  final _i1.PrismaUnion<String, StringFieldRefInput> startsWith;

  final _i1.PrismaUnion<String, StringFieldRefInput> endsWith;

  final _i1.PrismaUnion<String, NestedStringFilter> not;
}

class NestedEnumRoleFilter {
  final _i1.PrismaUnion<Role, EnumRoleFieldRefInput> equals;

  final _i1.PrismaUnion<Role, ListEnumRoleFieldRefInput> $in;

  final _i1.PrismaUnion<Role, ListEnumRoleFieldRefInput> notIn;

  final _i1.PrismaUnion<Role, NestedEnumRoleFilter> not;
}

class NestedDecimalFilter {
  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> equals;

  final _i1.PrismaUnion<_i1.Decimal, ListDecimalFieldRefInput> $in;

  final _i1.PrismaUnion<_i1.Decimal, ListDecimalFieldRefInput> notIn;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> lt;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> lte;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> gt;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> gte;

  final _i1.PrismaUnion<_i1.Decimal, NestedDecimalFilter> not;
}

class NestedBigIntFilter {
  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> equals;

  final _i1.PrismaUnion<BigInt, ListBigIntFieldRefInput> $in;

  final _i1.PrismaUnion<BigInt, ListBigIntFieldRefInput> notIn;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> lt;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> lte;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> gt;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> gte;

  final _i1.PrismaUnion<BigInt, NestedBigIntFilter> not;
}

class NestedBytesFilter {
  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldRefInput> equals;

  final _i1.PrismaUnion<_i2.Uint8List, ListBytesFieldRefInput> $in;

  final _i1.PrismaUnion<_i2.Uint8List, ListBytesFieldRefInput> notIn;

  final _i1.PrismaUnion<_i2.Uint8List, NestedBytesFilter> not;
}

class NestedIntNullableFilter {
  final _i1.PrismaUnion<int, _i1.PrismaUnion<IntFieldRefInput, Null>> equals;

  final _i1.PrismaUnion<int, _i1.PrismaUnion<ListIntFieldRefInput, Null>> $in;

  final _i1.PrismaUnion<int, _i1.PrismaUnion<ListIntFieldRefInput, Null>> notIn;

  final _i1.PrismaUnion<int, IntFieldRefInput> lt;

  final _i1.PrismaUnion<int, IntFieldRefInput> lte;

  final _i1.PrismaUnion<int, IntFieldRefInput> gt;

  final _i1.PrismaUnion<int, IntFieldRefInput> gte;

  final _i1.PrismaUnion<int, _i1.PrismaUnion<NestedIntNullableFilter, Null>>
      not;
}

class NestedFloatFilter {
  final _i1.PrismaUnion<double, FloatFieldRefInput> equals;

  final _i1.PrismaUnion<double, ListFloatFieldRefInput> $in;

  final _i1.PrismaUnion<double, ListFloatFieldRefInput> notIn;

  final _i1.PrismaUnion<double, FloatFieldRefInput> lt;

  final _i1.PrismaUnion<double, FloatFieldRefInput> lte;

  final _i1.PrismaUnion<double, FloatFieldRefInput> gt;

  final _i1.PrismaUnion<double, FloatFieldRefInput> gte;

  final _i1.PrismaUnion<double, NestedFloatFilter> not;
}

class NestedDateTimeFilter {
  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> equals;

  final _i1.PrismaUnion<DateTime, ListDateTimeFieldRefInput> $in;

  final _i1.PrismaUnion<DateTime, ListDateTimeFieldRefInput> notIn;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> lt;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> lte;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> gt;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> gte;

  final _i1.PrismaUnion<DateTime, NestedDateTimeFilter> not;
}

class NestedIntWithAggregatesFilter {
  final _i1.PrismaUnion<int, IntFieldRefInput> equals;

  final _i1.PrismaUnion<int, ListIntFieldRefInput> $in;

  final _i1.PrismaUnion<int, ListIntFieldRefInput> notIn;

  final _i1.PrismaUnion<int, IntFieldRefInput> lt;

  final _i1.PrismaUnion<int, IntFieldRefInput> lte;

  final _i1.PrismaUnion<int, IntFieldRefInput> gt;

  final _i1.PrismaUnion<int, IntFieldRefInput> gte;

  final _i1.PrismaUnion<int, NestedIntWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedFloatFilter avg;

  final NestedIntFilter sum;

  final NestedIntFilter min;

  final NestedIntFilter max;
}

class NestedStringWithAggregatesFilter {
  final _i1.PrismaUnion<String, StringFieldRefInput> equals;

  final _i1.PrismaUnion<String, ListStringFieldRefInput> $in;

  final _i1.PrismaUnion<String, ListStringFieldRefInput> notIn;

  final _i1.PrismaUnion<String, StringFieldRefInput> lt;

  final _i1.PrismaUnion<String, StringFieldRefInput> lte;

  final _i1.PrismaUnion<String, StringFieldRefInput> gt;

  final _i1.PrismaUnion<String, StringFieldRefInput> gte;

  final _i1.PrismaUnion<String, StringFieldRefInput> contains;

  final _i1.PrismaUnion<String, StringFieldRefInput> startsWith;

  final _i1.PrismaUnion<String, StringFieldRefInput> endsWith;

  final _i1.PrismaUnion<String, NestedStringWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedStringFilter min;

  final NestedStringFilter max;
}

class NestedEnumRoleWithAggregatesFilter {
  final _i1.PrismaUnion<Role, EnumRoleFieldRefInput> equals;

  final _i1.PrismaUnion<Role, ListEnumRoleFieldRefInput> $in;

  final _i1.PrismaUnion<Role, ListEnumRoleFieldRefInput> notIn;

  final _i1.PrismaUnion<Role, NestedEnumRoleWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedEnumRoleFilter min;

  final NestedEnumRoleFilter max;
}

class NestedDecimalWithAggregatesFilter {
  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> equals;

  final _i1.PrismaUnion<_i1.Decimal, ListDecimalFieldRefInput> $in;

  final _i1.PrismaUnion<_i1.Decimal, ListDecimalFieldRefInput> notIn;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> lt;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> lte;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> gt;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldRefInput> gte;

  final _i1.PrismaUnion<_i1.Decimal, NestedDecimalWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedDecimalFilter avg;

  final NestedDecimalFilter sum;

  final NestedDecimalFilter min;

  final NestedDecimalFilter max;
}

class NestedBigIntWithAggregatesFilter {
  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> equals;

  final _i1.PrismaUnion<BigInt, ListBigIntFieldRefInput> $in;

  final _i1.PrismaUnion<BigInt, ListBigIntFieldRefInput> notIn;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> lt;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> lte;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> gt;

  final _i1.PrismaUnion<BigInt, BigIntFieldRefInput> gte;

  final _i1.PrismaUnion<BigInt, NestedBigIntWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedFloatFilter avg;

  final NestedBigIntFilter sum;

  final NestedBigIntFilter min;

  final NestedBigIntFilter max;
}

class NestedBytesWithAggregatesFilter {
  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldRefInput> equals;

  final _i1.PrismaUnion<_i2.Uint8List, ListBytesFieldRefInput> $in;

  final _i1.PrismaUnion<_i2.Uint8List, ListBytesFieldRefInput> notIn;

  final _i1.PrismaUnion<_i2.Uint8List, NestedBytesWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedBytesFilter min;

  final NestedBytesFilter max;
}

class NestedJsonNullableFilter {
  final _i1.PrismaUnion<_i1.PrismaJson,
      _i1.PrismaUnion<JsonFieldRefInput, JsonNullValueFilter>> equals;

  final String path;

  final _i1.PrismaUnion<String, StringFieldRefInput> stringContains;

  final _i1.PrismaUnion<String, StringFieldRefInput> stringStartsWith;

  final _i1.PrismaUnion<String, StringFieldRefInput> stringEndsWith;

  final _i1
      .PrismaUnion<_i1.PrismaJson, _i1.PrismaUnion<JsonFieldRefInput, Null>>
      arrayContains;

  final _i1
      .PrismaUnion<_i1.PrismaJson, _i1.PrismaUnion<JsonFieldRefInput, Null>>
      arrayStartsWith;

  final _i1
      .PrismaUnion<_i1.PrismaJson, _i1.PrismaUnion<JsonFieldRefInput, Null>>
      arrayEndsWith;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> lt;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> lte;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> gt;

  final _i1.PrismaUnion<_i1.PrismaJson, JsonFieldRefInput> gte;

  final _i1.PrismaUnion<_i1.PrismaJson,
      _i1.PrismaUnion<JsonFieldRefInput, JsonNullValueFilter>> not;
}

class NestedIntNullableWithAggregatesFilter {
  final _i1.PrismaUnion<int, _i1.PrismaUnion<IntFieldRefInput, Null>> equals;

  final _i1.PrismaUnion<int, _i1.PrismaUnion<ListIntFieldRefInput, Null>> $in;

  final _i1.PrismaUnion<int, _i1.PrismaUnion<ListIntFieldRefInput, Null>> notIn;

  final _i1.PrismaUnion<int, IntFieldRefInput> lt;

  final _i1.PrismaUnion<int, IntFieldRefInput> lte;

  final _i1.PrismaUnion<int, IntFieldRefInput> gt;

  final _i1.PrismaUnion<int, IntFieldRefInput> gte;

  final _i1.PrismaUnion<int,
      _i1.PrismaUnion<NestedIntNullableWithAggregatesFilter, Null>> not;

  final NestedIntNullableFilter count;

  final NestedFloatNullableFilter avg;

  final NestedIntNullableFilter sum;

  final NestedIntNullableFilter min;

  final NestedIntNullableFilter max;
}

class NestedFloatNullableFilter {
  final _i1.PrismaUnion<double, _i1.PrismaUnion<FloatFieldRefInput, Null>>
      equals;

  final _i1.PrismaUnion<double, _i1.PrismaUnion<ListFloatFieldRefInput, Null>>
      $in;

  final _i1.PrismaUnion<double, _i1.PrismaUnion<ListFloatFieldRefInput, Null>>
      notIn;

  final _i1.PrismaUnion<double, FloatFieldRefInput> lt;

  final _i1.PrismaUnion<double, FloatFieldRefInput> lte;

  final _i1.PrismaUnion<double, FloatFieldRefInput> gt;

  final _i1.PrismaUnion<double, FloatFieldRefInput> gte;

  final _i1
      .PrismaUnion<double, _i1.PrismaUnion<NestedFloatNullableFilter, Null>>
      not;
}

class NestedFloatWithAggregatesFilter {
  final _i1.PrismaUnion<double, FloatFieldRefInput> equals;

  final _i1.PrismaUnion<double, ListFloatFieldRefInput> $in;

  final _i1.PrismaUnion<double, ListFloatFieldRefInput> notIn;

  final _i1.PrismaUnion<double, FloatFieldRefInput> lt;

  final _i1.PrismaUnion<double, FloatFieldRefInput> lte;

  final _i1.PrismaUnion<double, FloatFieldRefInput> gt;

  final _i1.PrismaUnion<double, FloatFieldRefInput> gte;

  final _i1.PrismaUnion<double, NestedFloatWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedFloatFilter avg;

  final NestedFloatFilter sum;

  final NestedFloatFilter min;

  final NestedFloatFilter max;
}

class NestedDateTimeWithAggregatesFilter {
  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> equals;

  final _i1.PrismaUnion<DateTime, ListDateTimeFieldRefInput> $in;

  final _i1.PrismaUnion<DateTime, ListDateTimeFieldRefInput> notIn;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> lt;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> lte;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> gt;

  final _i1.PrismaUnion<DateTime, DateTimeFieldRefInput> gte;

  final _i1.PrismaUnion<DateTime, NestedDateTimeWithAggregatesFilter> not;

  final NestedIntFilter count;

  final NestedDateTimeFilter min;

  final NestedDateTimeFilter max;
}

class PostCreateWithoutAuthorInput {
  final String id;

  final String title;
}

class PostUncheckedCreateWithoutAuthorInput {
  final String id;

  final String title;
}

class PostCreateOrConnectWithoutAuthorInput {
  final PostWhereUniqueInput where;

  final _i1.PrismaUnion<PostCreateWithoutAuthorInput,
      PostUncheckedCreateWithoutAuthorInput> create;
}

class PostCreateManyAuthorInputEnvelope {
  final _i1.PrismaUnion<PostCreateManyAuthorInput, PostCreateManyAuthorInput>
      data;

  final Boolean skipDuplicates;
}

class PostUpsertWithWhereUniqueWithoutAuthorInput {
  final PostWhereUniqueInput where;

  final _i1.PrismaUnion<PostUpdateWithoutAuthorInput,
      PostUncheckedUpdateWithoutAuthorInput> update;

  final _i1.PrismaUnion<PostCreateWithoutAuthorInput,
      PostUncheckedCreateWithoutAuthorInput> create;
}

class PostUpdateWithWhereUniqueWithoutAuthorInput {
  final PostWhereUniqueInput where;

  final _i1.PrismaUnion<PostUpdateWithoutAuthorInput,
      PostUncheckedUpdateWithoutAuthorInput> data;
}

class PostUpdateManyWithWhereWithoutAuthorInput {
  final PostScalarWhereInput where;

  final _i1.PrismaUnion<PostUpdateManyMutationInput,
      PostUncheckedUpdateManyWithoutAuthorInput> data;
}

class PostScalarWhereInput {
  final _i1.PrismaUnion<PostScalarWhereInput, PostScalarWhereInput> AND;

  final PostScalarWhereInput OR;

  final _i1.PrismaUnion<PostScalarWhereInput, PostScalarWhereInput> NOT;

  final _i1.PrismaUnion<StringFilter, String> id;

  final _i1.PrismaUnion<StringFilter, String> title;

  final _i1.PrismaUnion<IntFilter, int> userId;
}

class UserCreateWithoutPostsInput {
  final String name;

  final Role role;

  final _i1.Decimal price;

  final BigInt size;

  final _i2.Uint8List bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson> json;

  final _i1.PrismaUnion<int, Null> age;

  final double demo;

  final DateTime createdAt;
}

class UserUncheckedCreateWithoutPostsInput {
  final int id;

  final String name;

  final Role role;

  final _i1.Decimal price;

  final BigInt size;

  final _i2.Uint8List bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson> json;

  final _i1.PrismaUnion<int, Null> age;

  final double demo;

  final DateTime createdAt;
}

class UserCreateOrConnectWithoutPostsInput {
  final UserWhereUniqueInput where;

  final _i1.PrismaUnion<UserCreateWithoutPostsInput,
      UserUncheckedCreateWithoutPostsInput> create;
}

class UserUpsertWithoutPostsInput {
  final _i1.PrismaUnion<UserUpdateWithoutPostsInput,
      UserUncheckedUpdateWithoutPostsInput> update;

  final _i1.PrismaUnion<UserCreateWithoutPostsInput,
      UserUncheckedCreateWithoutPostsInput> create;

  final UserWhereInput where;
}

class UserUpdateToOneWithWhereWithoutPostsInput {
  final UserWhereInput where;

  final _i1.PrismaUnion<UserUpdateWithoutPostsInput,
      UserUncheckedUpdateWithoutPostsInput> data;
}

class UserUpdateWithoutPostsInput {
  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput> role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput> price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput> size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput> bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson> json;

  final _i1.PrismaUnion<int,
      _i1.PrismaUnion<NullableIntFieldUpdateOperationsInput, Null>> age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput> demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput> createdAt;
}

class UserUncheckedUpdateWithoutPostsInput {
  final _i1.PrismaUnion<int, IntFieldUpdateOperationsInput> id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> name;

  final _i1.PrismaUnion<Role, EnumRoleFieldUpdateOperationsInput> role;

  final _i1.PrismaUnion<_i1.Decimal, DecimalFieldUpdateOperationsInput> price;

  final _i1.PrismaUnion<BigInt, BigIntFieldUpdateOperationsInput> size;

  final _i1.PrismaUnion<_i2.Uint8List, BytesFieldUpdateOperationsInput> bytes;

  final _i1.PrismaUnion<NullableJsonNullValueInput, _i1.PrismaJson> json;

  final _i1.PrismaUnion<int,
      _i1.PrismaUnion<NullableIntFieldUpdateOperationsInput, Null>> age;

  final _i1.PrismaUnion<double, FloatFieldUpdateOperationsInput> demo;

  final _i1.PrismaUnion<DateTime, DateTimeFieldUpdateOperationsInput> createdAt;
}

class PostCreateManyAuthorInput {
  final String id;

  final String title;
}

class PostUpdateWithoutAuthorInput {
  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> title;
}

class PostUncheckedUpdateWithoutAuthorInput {
  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> title;
}

class PostUncheckedUpdateManyWithoutAuthorInput {
  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> id;

  final _i1.PrismaUnion<String, StringFieldUpdateOperationsInput> title;
}
