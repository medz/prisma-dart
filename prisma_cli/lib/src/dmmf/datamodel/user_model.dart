import 'package:json_annotation/json_annotation.dart';

import '../base_object.dart';
import 'base_db_name_object.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: false)
class UserModel extends BaseDbNameObject {
  final PrimaryKey? primaryKey;
  final List<List<String>> uniqueFields;
  final List<UniqueIndexe> uniqueIndexes;
  final bool isGenerated;
  final List<UserModelField> fields;

  const UserModel({
    required super.name,
    super.dbName,
    this.primaryKey,
    this.uniqueFields = const [],
    this.uniqueIndexes = const [],
    required this.isGenerated,
    required this.fields,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class PrimaryKey extends BaseNameNullableObject {
  final List<String> fields;

  const PrimaryKey({required super.name, required this.fields});
  factory PrimaryKey.fromJson(Map<String, dynamic> json) =>
      _$PrimaryKeyFromJson(json);
}

@JsonSerializable(createToJson: false)
class UniqueIndexe extends BaseNameNullableObject {
  final List<String> fields;

  const UniqueIndexe({
    super.name,
    required this.fields,
  });

  factory UniqueIndexe.fromJson(Map<String, dynamic> json) =>
      _$UniqueIndexeFromJson(json);
}

@JsonSerializable(createToJson: false)
class UserModelField extends BaseNamedObject {
  final String kind;
  final bool isList;
  final bool isRequired;
  final bool isUnique;
  final bool isId;
  final bool isReadOnly;
  final bool hasDefaultValue;
  final String type;

  @JsonKey(name: 'default')
  final dynamic defaultValue;

  final bool isGenerated;
  final bool isUpdatedAt;

  UserModelField({
    required super.name,
    required this.kind,
    required this.isList,
    required this.isRequired,
    required this.isUnique,
    required this.isId,
    required this.isReadOnly,
    required this.hasDefaultValue,
    required this.type,
    required this.defaultValue,
    required this.isGenerated,
    required this.isUpdatedAt,
  });

  factory UserModelField.fromJson(Map<String, dynamic> json) =>
      _$UserModelFieldFromJson(json);
}
