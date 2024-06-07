import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path_utils;
import 'package:flutter/services.dart';
import 'package:orm/orm.dart';
import 'package:path_provider/path_provider.dart';

import 'query_engine_bindings.dart';

const String _libName = 'orm_flutter';

// final DynamicLibrary _dylib = () {
//   if (Platform.isMacOS || Platform.isIOS) {
//     return DynamicLibrary.open('$_libName.framework/$_libName');
//   }
//   if (Platform.isAndroid || Platform.isLinux) {
//     return DynamicLibrary.open('lib$_libName.so');
//   }
//   if (Platform.isWindows) {
//     return DynamicLibrary.open('$_libName.dll');
//   }
//   throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
// }();
final DynamicLibrary _dylib = () {
  if (Platform.isIOS) {
    return DynamicLibrary.open("$_libName.framework/$_libName");
  }

  if (Platform.isAndroid) {
    return DynamicLibrary.open('lib$_libName.so');
  }

  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

final _bindingsInstance = QueryEngineBindings(_dylib);
int _evalEngineId = 0;

class LibraryEngine extends Engine implements Finalizable {
  late final Pointer<QueryEngine> _qe;
  bool _started = false;

  LibraryEngine({
    required super.schema,
    required super.datasources,
    required super.options,
  }) {
    final currentEngindId = _evalEngineId.toString();

    void logCallbackProxy(Pointer<Char> idptr, Pointer<Char> message) {
      // TODO: log callback. C-ABI engine bug, unable to parse message
    }

    final logNativeCallable =
        NativeCallable<Void Function(Pointer<Char>, Pointer<Char>)>.listener(
            logCallbackProxy);

    final native = Struct.create<ConstructorOptionsNative>()
      ..config_dir = ''.toNativeUtf8().cast();

    final logLevel = this.options.logEmitter.definition.fold<String?>(null,
        (value, current) {
      if (current.$1 == LogLevel.query) return value;
      if (value == null) return current.$1.name;
      if (value == 'info' || current.$1 == LogLevel.info) {
        return 'info';
      }

      return current.$1.name;
    });

    final options = Struct.create<ConstructorOptions>()
      ..id = currentEngindId.toNativeUtf8().cast()
      ..datamodel = schema.toNativeUtf8().cast()
      ..base_path = nullptr
      ..log_level = (logLevel ?? 'info').toNativeUtf8().cast()
      ..log_queries =
          this.options.logEmitter.definition.any((e) => e.$1 == LogLevel.query)
      ..log_callback = logNativeCallable.nativeFunction
      ..env = json.encode(createQueryEngineEnvironment()).toNativeUtf8().cast()
      ..ignore_env_var_errors = true
      ..native = native
      ..datasource_overrides =
          json.encode(createOverwriteDatasources()).toNativeUtf8().cast();

    final enginePtr = malloc<Pointer<QueryEngine>>();
    final errorPtr = malloc<Pointer<Char>>();

    void cleanup() {
      malloc.free(errorPtr);
      malloc.free(enginePtr);
      logNativeCallable.close();
    }

    final status = _bindingsInstance.create(options, enginePtr, errorPtr);

    if (status == Status.ok) {
      _evalEngineId++;
      malloc.free(errorPtr);

      _qe = enginePtr.value;
      return;
    } else if (status == Status.err) {
      final message = errorPtr.value.cast<Utf8>().toDartString();
      cleanup();

      throw StateError('Failed to create query engine: $message');
    } else if (status == Status.miss) {
      cleanup();
      throw StateError('Missing create query engine.');
    }

    cleanup();
    throw StateError('Unknown create query engine error.');
  }

  void destroy() {
    final status = _bindingsInstance.destroy(_qe);
    if (status != Status.ok) {
      throw StateError('Destory engine fail.');
    }
  }

  @override
  Future<void> start() async {
    if (_started) return;

    final errorPtr = malloc<Pointer<Char>>();
    final status =
        _bindingsInstance.start(_qe, '00'.toNativeUtf8().cast(), errorPtr);
    if (status != Status.ok) {
      if (status == Status.miss) {
        malloc.free(errorPtr);
        throw StateError('Start query engine fail.');
      }

      final message = errorPtr.value.cast<Utf8>().toDartString();
      malloc.free(errorPtr);
      throw StateError(message);
    }

    malloc.free(errorPtr);
    _started = true;
  }

  @override
  Future<void> stop() async {
    if (!_started) return;

    final status = _bindingsInstance.stop(_qe, nullptr);
    if (status != Status.ok) {
      throw StateError('Could not stop from prisma query engine');
    }
    _started = false;
  }

  Future<void> applyMigrations(
      {required String path, AssetBundle? bundle}) async {
    final resoolvedPath = path_utils.normalize(path);
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
        path_utils.normalize(path_utils.join(
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
    final status = _bindingsInstance.applyMigrations(
        _qe, migrationTempDir.path.toNativeUtf8().cast(), errorPtr);
    if (status != Status.ok) {
      final message = errorPtr.value.cast<Utf8>().toDartString();
      malloc.free(errorPtr);

      throw StateError(message);
    }

    malloc.free(errorPtr);
  }

  @override
  Future<void> commitTransaction(
      {required TransactionHeaders headers,
      required Transaction transaction}) async {
    final Pointer<Char> trace =
        headers.traceparent?.toNativeUtf8().cast() ?? nullptr;
    final response = _bindingsInstance.rollbackTransaction(
        _qe, transaction.id.toNativeUtf8().cast(), trace);
    if (response == nullptr) {
      throw StateError('Prisma engine did not commit transaction.');
    }
  }

  @override
  Future<void> rollbackTransaction(
      {required TransactionHeaders headers,
      required Transaction transaction}) async {
    final Pointer<Char> trace =
        headers.traceparent?.toNativeUtf8().cast() ?? nullptr;
    final response = _bindingsInstance.rollbackTransaction(
        _qe, transaction.id.toNativeUtf8().cast(), trace);
    if (response == nullptr) {
      throw StateError('Prisma engine did not rollback transaction.');
    }
  }

  @override
  Future<Transaction> startTransaction(
      {required TransactionHeaders headers,
      int maxWait = 2000,
      int timeout = 5000,
      TransactionIsolationLevel? isolationLevel}) async {
    await start();

    final Pointer<Char> trace =
        headers.traceparent?.toNativeUtf8().cast() ?? nullptr;
    final options = json.encode({
      'max_wait': maxWait,
      'timeout': timeout,
      if (isolationLevel != null) 'isolation_level': isolationLevel.name,
    }).toNativeUtf8();

    final response =
        _bindingsInstance.startTransaction(_qe, options.cast(), trace);

    try {
      final result = json.decode(response.cast<Utf8>().toDartString());
      if (result case {'id': final String id}) {
        return Transaction(id);
      }

      throw 'Not match transcation ID';
    } catch (_) {
      throw StateError('Prisma engine did not start transaction. -> $_');
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
    final errPtr = malloc<Pointer<Char>>();

    final response = _bindingsInstance.query(_qe, body, trace, txId, errPtr);

    if (response == nullptr || errPtr.value != nullptr) {
      if (errPtr.value == nullptr) {
        malloc.free(errPtr);
        throw StateError('Prisma engine did not request.');
      }

      final message = errPtr.value.cast<Utf8>().toDartString();
      malloc.free(errPtr);

      throw StateError(message);
    }

    final result = json.decode(response.cast<Utf8>().toDartString());

    return switch (result) {
      {'data': final Map data} => deserializeJsonResponse(data),
      {'errors': final Iterable errors} => throw Exception(errors),
      _ => throw Exception(result),
    };
  }

  @override
  Future metrics(
      {Map<String, String>? globalLabels, required MetricsFormat format}) {
    throw UnimplementedError('Prisma Flutter engine not support metrics.');
  }
}

extension on LibraryEngine {
  Map<String, String> createQueryEngineEnvironment() {
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

    environment['RUST_BACKTRACE'] = Prisma.env('RUST_BACKTRACE').or(() => '1');
    environment['RUST_LOG'] =
        Prisma.env('RUST_LOG').or(() => LogLevel.info.name);

    return environment;
  }

  /// Creates overwrite datasources string.
  Map<String, String> createOverwriteDatasources() {
    return datasources.map((name, datasource) {
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

      return MapEntry(name, Prisma.validateDatasourceURL(url, isProxy: false));
    });
  }
}

extension<T> on T? {
  T or(T Function() fn) {
    if (this != null) return this as T;

    return fn();
  }
}
