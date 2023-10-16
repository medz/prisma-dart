import 'package:json_annotation/json_annotation.dart';

import '../../engine_core.dart';
import '../exceptions.dart';

part 'result.g.dart';

const _jsonSerializable = JsonSerializable(
  createToJson: false,
  createFactory: true,
);

@_jsonSerializable
class GraphQLError {
  /// Graphql error message.
  final String? message;

  /// Prisma error message.
  final String? error;

  @JsonKey(name: 'user_facing_error')
  final UserFacingError? userFacingError;

  /// Create a new instance of [PrismaError].
  GraphQLError({
    this.message,
    this.error,
    this.userFacingError,
  }) : assert(message != null || error != null,
            '$GraphQLError: message or error is null');

  /// Create Prisma error from json.
  factory GraphQLError.fromJson(Map<String, dynamic> json) =>
      _$GraphQLErrorFromJson(json);

  /// Covert Prisma error to [PrismaRequestException].
  PrismaRequestException toException(Engine engine) {
    return PrismaRequestException(
      engine: engine,
      message: userFacingError?.message ?? message ?? error ?? 'Unknown error',
      code: userFacingError?.errorCode,
    );
  }
}

@_jsonSerializable
class UserFacingError {
  final String message;

  @JsonKey(name: 'error_code')
  final String? errorCode;

  /// Create a new instance of [UserFacingError].
  const UserFacingError({
    required this.message,
    this.errorCode,
  });

  /// Create user facing error from json.
  factory UserFacingError.fromJson(Map<String, dynamic> json) =>
      _$UserFacingErrorFromJson(json);
}

/// GraphQL result.
@_jsonSerializable
class GraphQLResult {
  /// GraphQL query or mutation data.
  final Map<String, dynamic>? data;

  /// GraphQL or Prisma errors.
  final Iterable<GraphQLError>? errors;

  /// Original json.
  final Map<String, dynamic> orginal;

  /// Create a new instance of [GraphQLResult].
  const GraphQLResult({
    this.data,
    this.errors,
    required this.orginal,
  });

  /// Create GraphQL result from json.
  factory GraphQLResult.fromJson(Map<String, dynamic> json) =>
      _$GraphQLResultFromJson({...json, 'orginal': json});
}
