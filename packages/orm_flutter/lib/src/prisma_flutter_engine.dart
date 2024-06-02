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

enum LogLevel { error, warn, info, debug, trace }

class PrismaFlutterEngine extends Engine implements Finalizable {
  final Pointer<QueryEngine> _qe;

  PrismaFlutterEngine._(this._qe,
      {required super.schema, required super.datasources});

  factory PrismaFlutterEngine(
      {required String schema,
      required Map<String, String> datasources,
      LogLevel logLevel = LogLevel.info,
      bool logQueries = false,
      void Function(String message)? logCallback,
      Map<String, String>? env,
      bool ignoreEnvVarErrors = false,
      String nativeConfigDir = ''}) {
    final currentEngindId = _evalEngineId.toString();

    void logCallbackProxy(Pointer<Char> idptr, Pointer<Char> message) {
      final id = idptr.cast<Utf8>().toDartString();
      if (id == currentEngindId && logCallback != null) {
        logCallback(message.cast<Utf8>().toString());
      }
    }

    final logNativeCallable =
        NativeCallable<Void Function(Pointer<Char>, Pointer<Char>)>.listener(
            logCallbackProxy);

    final native = Struct.create<ConstructorOptionsNative>()
      ..config_dir = nativeConfigDir.toNativeUtf8().cast();

    final options = Struct.create<ConstructorOptions>()
      ..id = currentEngindId.toNativeUtf8().cast()
      ..datamodel = schema.toNativeUtf8().cast()
      ..base_path = nullptr
      ..log_level = logLevel.name.toNativeUtf8().cast()
      ..log_queries = logQueries
      ..log_callback = logNativeCallable.nativeFunction
      ..env = json.encode(env ?? const <String, String>{}).toNativeUtf8().cast()
      ..ignore_env_var_errors = ignoreEnvVarErrors
      ..native = native
      ..datasource_overrides = json.encode(datasources).toNativeUtf8().cast();

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

      return PrismaFlutterEngine._(enginePtr.value,
          schema: schema, datasources: datasources);
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
  }

  @override
  Future<void> stop() async {
    final status = _bindingsInstance.stop(_qe, nullptr);
    if (status != Status.ok) {
      throw StateError('Could not stop from prisma query engine');
    }
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
