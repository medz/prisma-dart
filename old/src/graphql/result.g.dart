// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphQLError _$GraphQLErrorFromJson(Map<String, dynamic> json) => GraphQLError(
      message: json['message'] as String?,
      error: json['error'] as String?,
      userFacingError: json['user_facing_error'] == null
          ? null
          : UserFacingError.fromJson(
              json['user_facing_error'] as Map<String, dynamic>),
    );

UserFacingError _$UserFacingErrorFromJson(Map<String, dynamic> json) =>
    UserFacingError(
      message: json['message'] as String,
      errorCode: json['error_code'] as String?,
    );

GraphQLResult _$GraphQLResultFromJson(Map<String, dynamic> json) =>
    GraphQLResult(
      data: json['data'] as Map<String, dynamic>?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => GraphQLError.fromJson(e as Map<String, dynamic>)),
      orginal: json['orginal'] as Map<String, dynamic>,
    );
