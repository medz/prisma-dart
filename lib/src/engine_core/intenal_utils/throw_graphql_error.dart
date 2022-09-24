import 'dart:convert';

import '../../../version.dart';
import '../common/errors/prisma_client_known_request_error.dart';
import '../common/errors/prisma_client_unknown_request_error.dart';

/// Request error handler.
void throwGraphQLError(List<dynamic>? errors) {
  // If errors is null, return.
  if (errors == null || errors.isEmpty == true) return;

  // Throw errors.
  for (final dynamic error in errors) {
    // If error is user_facing_error.
    if (error is Map && error['user_facing_error'] is Map) {
      throw PrismaClientKnownRequestError.fromJson({
        ...error['user_facing_error'],
        'code': error['user_facing_error']['error_code'] ??
            error['user_facing_error']['code'] ??
            'UNKNOWN',
        'clientVersion': packageVersion,
      });
    }

    // Otherwise, throw unknown error.
    throw PrismaClientUnknownRequestError(
      json.encode(error),
      clientVersion: packageVersion,
    );
  }
}
