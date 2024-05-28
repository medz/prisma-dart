import 'dart:async';

import 'prisma/generated_dart_client/client.dart';

/// Create a new instance of PrismaClient
final _client = PrismaClient();

/// Provide a PrismaClient instance to a function.
///
/// Wrapped in a function to ensure that the instance is diconnected
/// after the function is done.
FutureOr<T> providePrisma<T>(
    FutureOr<T> Function(PrismaClient prisma) main) async {
  try {
    return await main(_client);
  } finally {
    await _client.$disconnect();
  }
}
