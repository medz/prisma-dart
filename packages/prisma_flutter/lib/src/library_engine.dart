import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:orm/orm.dart';

import 'query_engine_bindings.dart';

late final QueryEngineBindings _bindings;
int _evalId = 0;

class LibraryEngine extends Engine {
  LibraryEngine({required super.schema, required super.datasources}) {
    _bindings = QueryEngineBindings(DynamicLibrary.process());
    idptr = _evalId.toString().toNativeUtf8().cast();
    _evalId++;

    final env = {
      ...Platform.environment,
      'RUST_BACKTRACE': 1,
    };

    final datasourcesOverrides =
        json.encode(datasources.isEmpty ? null : datasources).toNativeUtf8();

    final options = Struct.create<ConstructorOptions>()
      ..base_path = nullptr
      ..datamodel = schema.toNativeUtf8().cast()
      ..datasource_overrides = datasourcesOverrides.cast()
      ..env = json.encode(env).toNativeUtf8().cast()
      ..id = idptr
      ..ignore_env_var_errors = true
      ..native = Struct.create<ConstructorOptionsNative>();
    final errptr = malloc<Char>();
    final status = _bindings.prisma_create(options, enginePtr, errptr.cast());

    print(status);

    if (status != _bindings.PRISMA_OK) {
      if (errptr == nullptr) {
        malloc.free(errptr);
        malloc.free(idptr);

        throw StateError('Create Query engine fail');
      }

      print(errptr.cast<Utf8>().toDartString());

      // final message = errptr.value.cast<Utf8>().toDartString();

      // malloc.free(errptr);
      // malloc.free(idptr);

      // throw StateError('Failed to create prisma engine: $message');
    }
  }

  late final Pointer<Char> idptr;
  final enginePtr = malloc<Pointer<QueryEngine>>();

  @override
  Future<void> commitTransaction(
      {required TransactionHeaders headers, required Transaction transaction}) {
    // TODO: implement commitTransaction
    throw UnimplementedError();
  }

  @override
  Future metrics(
      {Map<String, String>? globalLabels, required MetricsFormat format}) {
    throw UnimplementedError();
  }

  @override
  Future<Map> request(JsonQuery query,
      {TransactionHeaders? headers, Transaction? transaction}) {
    // TODO: implement request
    throw UnimplementedError();
  }

  @override
  Future<void> rollbackTransaction(
      {required TransactionHeaders headers, required Transaction transaction}) {
    // TODO: implement rollbackTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> start() async {
    final errptr = Pointer<Pointer<Char>>.fromAddress(0);
    final status = _bindings.prisma_connect(enginePtr.cast(), idptr, errptr);

    if (status != _bindings.PRISMA_OK) {
      final message = errptr.value.cast<Utf8>().toDartString();
      malloc.free(errptr);

      throw StateError(message);
    }
  }

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
  Future<void> stop() async {
    final status = _bindings.prisma_disconnect(enginePtr.cast(), idptr);
    if (status != _bindings.PRISMA_OK) {
      throw StateError('Could not disconnect from prisma query engine');
    }
  }
}
