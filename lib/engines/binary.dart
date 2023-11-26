library prisma.engines;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:orm/orm.dart';
import 'package:path/path.dart';

class BinaryEngine implements Engine {
  /// Prisma schema string.
  ///
  /// Exported from `client.dart` file.
  final String schema;

  /// Your datasource defined in `schema.prisma` file.
  ///
  /// Example:
  ///
  /// ```prisma
  /// datasource db {
  ///  provider = "postgresql"
  ///  url      = env("DATABASE_URL")
  /// }
  /// ```
  ///
  /// You **datasource** name is `db`.
  final String datasource;

  /// Path to prisma binary query engine.
  ///
  /// If not provided, it will search for `prisma-query-engine` binary in
  /// current directory.
  ///
  /// If you provide a path, but the file does not exist, it will search for
  /// base name of the path in current directory.
  final String? binary;

  /// Your database url.
  ///
  /// If you not provide [url], it will search for [envVariable] environment:
  ///
  /// Priority:
  ///
  /// 1. [url]
  /// 2. `String.fromEnvironment(envVariable)`
  /// 3. `Platform.environment[envVariable]`
  final Uri? url;

  /// Database url environment variable name.
  ///
  /// If you provide [url], this will be ignored.
  final String envVariable;

  const BinaryEngine({
    required this.schema,
    required this.datasource,
    this.binary,
    this.url,
    this.envVariable = 'DATABASE_URL',
  });

  /// Resolve prisma binary query engine path.
  File get _executable {
    if (this.binary == null) {
      return _searchExecutable();
    }

    final binary = File(this.binary!);
    if (!binary.existsSync()) return _searchExecutable();

    return binary;
  }

  /// Search for prisma binary query engine path.
  File _searchExecutable() {
    const defaultExecutableName = 'prisma-query-engine';
    final executableName = switch (binary) {
      String binary => basename(binary),
      _ => defaultExecutableName,
    };

    final executable = File(executableName);
    if (executable.existsSync()) return executable;

    final defaultExecutable = File(defaultExecutableName);
    if (defaultExecutable.existsSync()) return defaultExecutable;

    throw Exception('No query engine binary found ($executableName)');
  }

  /// Generate owerwrite datasources.
  String get _overwriteDatasources {
    final overwrite = [
      {'name': datasource, 'url': url ?? _urlFromEnv},
    ];

    return base64.encode(
      utf8.encode(
        json.encode(overwrite),
      ),
    );
  }

  /// Get database url from environment.
  String get _urlFromEnv {
    if (bool.hasEnvironment(envVariable)) {
      return String.fromEnvironment(envVariable);
    } else if (Platform.environment.containsKey(envVariable)) {
      return Platform.environment[envVariable]!;
    }

    throw Exception('No database url found ($envVariable)');
  }

  @override
  Future<void> start() {
    // TODO: implement start
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }

  @override
  Future request(JsonQuery query,
      {int attempts = 1,
      TransactionHeaders? headers,
      Transaction? transaction}) {
    // TODO: implement request
    throw UnimplementedError();
  }

  @override
  Future<void> commitTransaction(
      {required TransactionHeaders headers, required Transaction transaction}) {
    // TODO: implement commitTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> rollbackTransaction(
      {required TransactionHeaders headers, required Transaction transaction}) {
    // TODO: implement rollbackTransaction
    throw UnimplementedError();
  }

  @override
  Future<Transaction> startTransaction(
      {required TransactionHeaders headers,
      int maxWait = 2000,
      int timeout = 5000,
      IsolationLevel? isolationLevel}) {
    // TODO: implement startTransaction
    throw UnimplementedError();
  }

  @override
  FutureOr<String> version([bool force = false]) {
    // TODO: implement version
    throw UnimplementedError();
  }

  @override
  Future metrics(
      {Map<String, String>? globalLabels, required MetricsFormat format}) {
    // TODO: implement metrics
    throw UnimplementedError();
  }
}
