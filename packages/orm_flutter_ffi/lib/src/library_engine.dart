import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:orm/orm.dart';
import 'package:ffi/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '_generate_bindings.dart';
import 'bindings.dart';

/// Current query engine ID counter
int _currentEngineId = 0;

/// Callback function for logging from the query engine
void _logCallback(Pointer<Char> idPtr, Pointer<Char> msgPtr) {
  // TODO
}

/// Implementation of the Prisma Query Engine using FFI bindings
class LibraryEngine extends Engine implements Finalizable {
  LibraryEngine({
    required super.options,
    required super.schema,
    required super.datasources,
  }) : id = _currentEngineId++;

  final int id;
  late final _qeptr = malloc<Pointer<QueryEngine>>();
  bool _started = false;
  bool _qeCreated = false;

  Future<void> _createQueryEngine() async {
    if (_qeCreated) return;

    final logLevel =
        this.options.logEmitter.definition.fold<String?>(null, (prev, e) {
      if (prev == 'info' || e.$1 == LogLevel.info) {
        return 'info';
      }

      return e.$1.name;
    });
    final logQueries =
        this.options.logEmitter.definition.any((e) => e.$1 == LogLevel.query);

    final basePath = await getTemporaryDirectory().then((dir) => dir.path);

    final options = Struct.create<ConstructorOptions>()
      ..base_path = basePath.toNativeUtf8().cast()
      ..datamodel = schema.toNativeUtf8().cast()
      ..datasource_overrides = createOverwriteDatasourcesPtr().cast()
      ..env = createEnvironmentPtr().cast()
      ..id = id.toString().toNativeUtf8().cast()
      ..ignore_env_var_errors = true
      ..log_callback = Pointer.fromFunction(_logCallback)
      ..log_level = (logLevel ?? 'info').toNativeUtf8().cast()
      ..log_queries = logQueries
      ..native = createOptionsNative(basePath);

    final errPtr = malloc<Pointer<Char>>();
    try {
      final status = bindings.create(options, _qeptr, errPtr);
      if (status == Status.err) {
        if (errPtr.value == nullptr) {
          throw StateError('Unknown query engine error');
        }

        final message = errPtr.value.cast<Utf8>().toDartString();
        throw StateError('Failed to create query engine: $message');
      } else if (status == Status.miss) {
        throw StateError('Missing create query engine.');
      }

      _qeCreated = true;
    } catch (_) {
      rethrow;
    } finally {
      malloc.free(errPtr);
    }
  }

  // Lifecycle methods
  @override
  Future<void> start() async {
    await _createQueryEngine();
    if (_started) return;

    final errPtr = malloc<Pointer<Char>>();
    try {
      final status = bindings.start(
        _qeptr.value,
        '00'.toNativeUtf8().cast(),
        nullptr,
        errPtr,
      );
      if (status == Status.err) {
        if (errPtr.value == nullptr) {
          throw StateError('Start query engine fail.');
        }

        final message = errPtr.value.cast<Utf8>().toDartString();
        throw StateError(message);
      }

      _started = true;
    } finally {
      malloc.free(errPtr);
    }
  }

  @override
  Future<void> stop() async {
    if (_qeptr.value == nullptr || !_started) return;
    try {
      final status = bindings.stop(_qeptr.value, nullptr, nullptr);
      if (status != Status.ok) {
        throw StateError('Could not stop from prisma query engine');
      }
    } finally {
      _started = false;
    }
  }

  @override
  Future<Map> request(JsonQuery query,
      {TransactionHeaders? headers, Transaction? transaction}) async {
    await start();

    final Pointer<Char> body =
        json.encode(query.toJson()).toNativeUtf8().cast();
    final Pointer<Char> trace =
        (headers?.traceparent ?? '00').toNativeUtf8().cast();
    final Pointer<Char> txId = transaction?.id.toNativeUtf8().cast() ?? nullptr;
    final errptr = malloc<Pointer<Char>>();

    try {
      final response =
          bindings.query(_qeptr.value, body, trace, txId, nullptr, errptr);
      if (response == nullptr || errptr.value != nullptr) {
        if (errptr.value == nullptr) {
          throw StateError('Prisma engine did not request.');
        }

        final message = errptr.value.cast<Utf8>().toDartString();
        throw StateError(message);
      }

      final result = response.cast<Utf8>().toDartString();

      // TODO error parse.
      return switch (json.decode(result)) {
        {'data': final Map data} => deserializeJsonResponse(data),
        {'errors': final Iterable errors} => throw Exception(errors),
        _ => throw PrismaClientUnknownRequestError(message: result),
      };
    } finally {
      malloc.free(errptr);
    }
  }

  // Transaction methods
  @override
  Future<Transaction> startTransaction({
    required TransactionHeaders headers,
    int maxWait = 2000,
    int timeout = 5000,
    TransactionIsolationLevel? isolationLevel,
  }) async {
    await start();

    final Pointer<Char> trace =
        headers.traceparent?.toNativeUtf8().cast() ?? nullptr;
    final options = json.encode({
      'max_wait': maxWait,
      'timeout': timeout,
      if (isolationLevel != null) 'isolation_level': isolationLevel.name,
    }).toNativeUtf8();

    try {
      final response = bindings.startTransaction(
        _qeptr.value,
        options.cast(),
        trace,
        nullptr,
      );
      final result = json.decode(response.cast<Utf8>().toDartString());
      if (result case {'id': final String id}) {
        return Transaction(id);
      }

      throw 'Not match transcation ID';
    } catch (e) {
      throw StateError('Prisma engine did not start transaction. -> $e');
    }
  }

  @override
  Future<void> commitTransaction({
    required TransactionHeaders headers,
    required Transaction transaction,
  }) async {
    final Pointer<Char> trace =
        headers.traceparent?.toNativeUtf8().cast() ?? nullptr;
    final response = bindings.commitTransaction(
      _qeptr.value,
      transaction.id.toNativeUtf8().cast(),
      trace,
      nullptr,
    );
    if (response == nullptr) {
      throw StateError('Prisma engine did not commit transaction.');
    }
  }

  @override
  Future<void> rollbackTransaction({
    required TransactionHeaders headers,
    required Transaction transaction,
  }) async {
    final Pointer<Char> trace =
        headers.traceparent?.toNativeUtf8().cast() ?? nullptr;
    final response = bindings.rollbackTransaction(
      _qeptr.value,
      transaction.id.toNativeUtf8().cast(),
      trace,
      nullptr,
    );
    if (response == nullptr) {
      throw StateError('Prisma engine did not rollback transaction.');
    }
  }

  @override
  Future metrics({
    Map<String, String>? globalLabels,
    required MetricsFormat format,
  }) {
    throw UnsupportedError('Prisma Flutter engine not support metrics.');
  }

  /// Destroy the query engine instance
  void destroy() {
    final status = bindings.destroy(_qeptr.value);
    if (status != Status.ok) {
      throw StateError('Destory engine fail.');
    }
  }

  /// Apply Prisma migrations from Flutter assets
  Future<void> applyMigrations({
    required String path,
    AssetBundle? bundle,
  }) async {
    await _createQueryEngine();
    final resoolvedPath = normalize(path);
    final resolvedBundle = bundle ?? rootBundle;
    final assetManifest =
        await AssetManifest.loadFromAssetBundle(resolvedBundle);
    final lock =
        assetManifest.getAssetVariants('$resoolvedPath/migration_lock.toml');
    if (lock?.isEmpty == true) {
      throw ArgumentError(
          'Path($resoolvedPath) is not a Prisma migrations directory');
    }

    final temporary = await getTemporaryDirectory();
    final mark = (DateTime.timestamp().millisecondsSinceEpoch ~/ 1000);
    final migrationTempDir = await temporary.createTemp('prisma_${mark}_');

    for (final asset in assetManifest.listAssets()) {
      if (!asset.startsWith(resoolvedPath)) {
        continue;
      }

      final basename = asset.substring(resoolvedPath.length);
      final file = File(
        normalize(join(
          migrationTempDir.path,
          basename.startsWith('/') ? '.$basename' : basename,
        )),
      );
      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      final bytes = await resolvedBundle.load(asset);
      await file.writeAsBytes(bytes.buffer.asUint8List());
    }

    final errorPtr = malloc<Pointer<Char>>();
    print('MDIR: ${migrationTempDir.path}');
    try {
      final status = bindings.applyMigrations(
          _qeptr.value, migrationTempDir.path.toNativeUtf8().cast(), errorPtr);

      if (status != Status.ok) {
        final message = errorPtr.value.cast<Utf8>().toDartString();
        malloc.free(errorPtr);

        throw StateError(message);
      }
    } finally {
      malloc.free(errorPtr);
    }
  }
}

/// Extension methods for LibraryEngine
extension on LibraryEngine {
  /// Create environment pointer for query engine
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

  /// Create native options for query engine constructor
  ConstructorOptionsNative createOptionsNative(String basePath) {
    return Struct.create<ConstructorOptionsNative>()
      ..config_dir = basePath.toNativeUtf8().cast();
  }

  /// Create datasource overrides pointer for query engine
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

/// Extension to provide an "or" operator for nullable types
extension<T> on T? {
  T or(T Function() factory) => factory();
}
