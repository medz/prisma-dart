import 'dart:convert';
import 'dart:ffi';

import 'package:orm/orm.dart';
import 'package:ffi/ffi.dart';

import '_generate_bindings.dart';
import 'bindings.dart';

int _currentEngineId = 0;

class LibraryEngine extends Engine {
  LibraryEngine({
    required super.options,
    required super.schema,
    required super.datasources,
  }) : id = _currentEngineId++ {
    final logLevel =
        this.options.logEmitter.definition.fold<String?>(null, (prev, e) {
      if (prev == 'info' || e.$1 == LogLevel.info) {
        return 'info';
      }

      return e.$1.name;
    });
    final logQueries =
        this.options.logEmitter.definition.any((e) => e.$1 == LogLevel.query);

    final options = Struct.create<ConstructorOptions>()
      ..base_path = nullptr
      ..datamodel = schema.toNativeUtf8().cast()
      ..datasource_overrides = createOverwriteDatasourcesPtr().cast()
      ..env = createEnvironmentPtr().cast()
      ..id = id.toString().toNativeUtf8().cast()
      ..ignore_env_var_errors = true
      ..log_callback = Pointer.fromFunction(logCallback)
      ..log_level = (logLevel ?? 'info').toNativeUtf8().cast()
      ..log_queries = logQueries
      ..native = createOptionsNative();

    final err = malloc<Pointer<Char>>();

    try {
      final status = bindings.create(options, qe, err);
      if (status == Status.err) {
        final message = err.value.cast<Utf8>().toDartString();
        throw StateError('Failed to create query engine: $message');
      } else if (status == Status.miss) {
        throw StateError('Missing create query engine.');
      }
    } catch (_) {
      malloc.free(qe);
    } finally {
      malloc.free(err);
    }
  }

  final int id;
  late final qe = malloc<Pointer<QueryEngine>>();

  // Lifecycle methods
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

  // Query methods
  @override
  Future<Map> request(JsonQuery query,
      {TransactionHeaders? headers, Transaction? transaction}) {
    // TODO: implement request
    throw UnimplementedError();
  }

  // Transaction methods
  @override
  Future<Transaction> startTransaction(
      {required TransactionHeaders headers,
      int maxWait = 2000,
      int timeout = 5000,
      TransactionIsolationLevel? isolationLevel}) {
    // TODO: implement startTransaction
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

  // Monitoring methods
  @override
  Future metrics(
      {Map<String, String>? globalLabels, required MetricsFormat format}) {
    // TODO: implement metrics
    throw UnimplementedError();
  }
}

extension on LibraryEngine {
  void logCallback(Pointer<Char> idPtr, Pointer<Char> msgPtr) {
    // TODO
  }

  Pointer<Utf8> createEnvironmentPtr() {
    final environment = Map<String, String>.from(Prisma.environment);

    // log queries
    if (options.logEmitter.definition.any((e) => e.$1 == LogLevel.query)) {
      environment['LOG_QUERIES'] = 'true';
    }

    // no color
    if (!Prisma.envAsBoolean('NO_COLOR') &&
        options.errorFormat == ErrorFormat.pretty) {
      environment['CLICOLOR_FORCE'] = "1";
    }

    environment['RUST_BACKTRACE'] = Prisma.env('RUST_BACKTRACE') ?? '1';
    environment['RUST_LOG'] = Prisma.env('RUST_LOG') ?? LogLevel.info.name;

    return json.encode(environment).toNativeUtf8();
  }

  ConstructorOptionsNative createOptionsNative() {
    return Struct.create<ConstructorOptionsNative>()
      ..config_dir = "".toNativeUtf8().cast();
  }

  Pointer<Utf8> createOverwriteDatasourcesPtr() {
    final overwriteDatasources = datasources.map((name, datasource) {
      if (options.datasourceUrl != null) {
        return MapEntry(name, options.datasourceUrl!);
      }

      if (options.datasources?.containsKey(name) == true) {
        return MapEntry(name, options.datasources![name]!);
      }

      final url = switch (datasource) {
        Datasource(type: DatasourceType.url, value: final url) => url,
        Datasource(type: DatasourceType.environment, value: final name) =>
          Prisma.env(name).or(
            () => throw PrismaClientInitializationError(
              errorCode: "P1013",
              message: 'The environment variable "$name" does not exist',
            ),
          ),
      };

      return MapEntry(name, Prisma.validateDatasourceURL(url));
    });

    final shouldThrowUrlError =
        overwriteDatasources.entries.any((e) => !e.value.startsWith('file:'));
    if (shouldThrowUrlError) {
      throw PrismaClientInitializationError(
        errorCode: "P1013",
        message:
            'Prisma and Flutter integration (FFI) engine only support SQLite connection strings (start with the `file:`)',
      );
    }

    return json.encode(overwriteDatasources).toNativeUtf8();
  }
}

extension<T> on T? {
  T or(T Function() factory) => factory();
}
