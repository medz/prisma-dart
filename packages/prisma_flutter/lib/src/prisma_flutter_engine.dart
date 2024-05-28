import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:orm/orm.dart';

import 'query_engine_bindings.dart';

const String _libName = 'prisma_flutter';

DynamicLibrary get _dylib {
  if (Platform.isIOS) {
    return DynamicLibrary.open("$_libName.framework/$_libName");
  }

  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}

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
      String? basePath,
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
      ..base_path = basePath?.toNativeUtf8().cast() ?? nullptr
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
    final status = _bindingsInstance.start(_qe, nullptr, errorPtr);
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

  void applyMigrations({required String path}) {
    final errorPtr = malloc<Pointer<Char>>();
    final status = _bindingsInstance.applyMigrations(
        _qe, path.toNativeUtf8().cast(), errorPtr);
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
      {TransactionHeaders? headers, Transaction? transaction}) {
    final Pointer<Char> body =
        json.encode(query.toJson()).toNativeUtf8().cast();
    final Pointer<Char> trace =
        (headers?.traceparent ?? '00').toNativeUtf8().cast();
    final Pointer<Char> txId = transaction?.id.toNativeUtf8().cast() ?? nullptr;
    final errPtr = malloc<Pointer<Char>>();

    final response = _bindingsInstance.query(_qe, body, trace, txId, errPtr);

    if (response == nullptr || errPtr != nullptr) {
      if (errPtr == nullptr) {
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
