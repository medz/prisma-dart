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

    final options = Struct.create<ConstructorOptions>()
      ..base_path = nullptr
      ..datamodel = schema.toNativeUtf8().cast()
      ..datasource_overrides = json
          .encode(datasources.entries
              .map((e) => {'name': e.key, 'url': e.value})
              .toList())
          .toNativeUtf8()
          .cast()
      ..env = json.encode(Platform.environment).toNativeUtf8().cast()
      ..id = idptr
      ..ignore_env_var_errors = true
      ..native = Struct.create<ConstructorOptionsNative>();
    final errptr = Pointer<Pointer<Char>>.fromAddress(0);
    final status = _bindings.prisma_create(options, enginePtr, errptr);

    if (status != _bindings.PRISMA_OK) {
      if (errptr == nullptr) {
        malloc.free(errptr);
        malloc.free(idptr);

        throw StateError('Create Query engine fail');
      }

      final message = errptr.value.cast<Utf8>().toDartString();

      malloc.free(errptr);
      malloc.free(idptr);

      throw StateError('Failed to create prisma engine: $message');
    }
  }

  late final Pointer<Char> idptr;
  final Pointer<Pointer<QueryEngine>> enginePtr = Pointer.fromAddress(0);

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
    final status = _bindings.prisma_connect(enginePtr.value, idptr, errptr);

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
    final status = _bindings.prisma_disconnect(enginePtr.value, idptr);
    if (status != _bindings.PRISMA_OK) {
      throw StateError('Could not disconnect from prisma query engine');
    }
  }
}
