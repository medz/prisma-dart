library prisma.environtment;

import 'dart:io';

abstract class Environtment {
  /// PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION
  static final String? clientDataProxyClientVersion =
      bool.hasEnvironment('PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION')
          ? String.fromEnvironment('PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION')
          : Platform.environment['PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION'];

  /// Prisma Binary Query Engine
  static final String? queryEngineBinary =
      bool.hasEnvironment('PRISMA_QUERY_ENGINE_BINARY')
          ? String.fromEnvironment('PRISMA_QUERY_ENGINE_BINARY')
          : Platform.environment['PRISMA_QUERY_ENGINE_BINARY'];
}
