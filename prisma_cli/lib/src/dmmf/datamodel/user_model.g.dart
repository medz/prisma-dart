// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String,
      dbName: json['dbName'] as String?,
      primaryKey: json['primaryKey'] as String?,
      uniqueFields: (json['uniqueFields'] as List<dynamic>?)
              ?.map(
                  (e) => (e as List<dynamic>).map((e) => e as String).toList())
              .toList() ??
          const [],
      uniqueIndexes: (json['uniqueIndexes'] as List<dynamic>?)
              ?.map((e) => UniqueIndexe.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isGenerated: json['isGenerated'] as bool,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => UserModelField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

UniqueIndexe _$UniqueIndexeFromJson(Map<String, dynamic> json) => UniqueIndexe(
      name: json['name'] as String?,
      fields:
          (json['fields'] as List<dynamic>).map((e) => e as String).toList(),
    );

UserModelField _$UserModelFieldFromJson(Map<String, dynamic> json) =>
    UserModelField(
      name: json['name'] as String,
      kind: json['kind'] as String,
      isList: json['isList'] as bool,
      isRequired: json['isRequired'] as bool,
      isUnique: json['isUnique'] as bool,
      isId: json['isId'] as bool,
      isReadOnly: json['isReadOnly'] as bool,
      hasDefaultValue: json['hasDefaultValue'] as bool,
      type: json['type'] as String,
      defaultValue: json['default'],
      isGenerated: json['isGenerated'] as bool,
      isUpdatedAt: json['isUpdatedAt'] as bool,
    );
