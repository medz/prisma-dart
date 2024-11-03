import 'dart:io';

import 'package:flutter/services.dart';
import 'package:orm/orm.dart';
import 'package:orm_flutter_ffi/orm_flutter_ffi.dart' as ffi;

/// Unified query engine implementation for Prisma and Flutter integration.
///
/// Supported platforms:
/// - **iOS** at [orm_flutter_ffi](https://pub.dev/packages/orm_flutter_ffi) followed by [orm_flutter_ios](https://pub.dev/packages/orm_flutter_ios)
/// - **Android** at [orm_flutter_ffi](https://pub.dev/packages/orm_flutter_ffi) followed by [orm_flutter_android](https://pub.dev/packages/orm_flutter_android)
class LibraryEngine implements Engine {
  /// Create a new library engine instance
  ///
  /// The [datasources] parameter is required and contains the database connection information
  /// The [options] parameter is required and contains the Prisma client options
  /// The [schema] parameter is required and contains the Prisma schema
  factory LibraryEngine({
    required Datasources datasources,
    required PrismaClientOptions options,
    required String schema,
  }) {
    if (Platform.isIOS || Platform.isAndroid) {
      return LibraryEngine._(ffi.LibraryEngine(
          datasources: datasources, options: options, schema: schema));
    }

    throw UnsupportedError('Unsupport platform: ${Platform.operatingSystem}');
  }

  const LibraryEngine._(this._pe);
  final Engine _pe;

  @override
  Datasources get datasources => _pe.datasources;

  @override
  PrismaClientOptions get options => _pe.options;

  @override
  String get schema => _pe.schema;

  @override
  Future<void> start() => _pe.start();

  @override
  Future<void> stop() => _pe.stop();

  @override
  Future<Map> request(JsonQuery query,
          {TransactionHeaders? headers, Transaction? transaction}) =>
      _pe.request(query, headers: headers, transaction: transaction);

  @override
  Future<Transaction> startTransaction(
          {required TransactionHeaders headers,
          int maxWait = 2000,
          int timeout = 5000,
          TransactionIsolationLevel? isolationLevel}) =>
      _pe.startTransaction(
          headers: headers,
          maxWait: maxWait,
          timeout: timeout,
          isolationLevel: isolationLevel);

  @override
  Future<void> commitTransaction(
          {required TransactionHeaders headers,
          required Transaction transaction}) =>
      _pe.commitTransaction(headers: headers, transaction: transaction);

  @override
  Future<void> rollbackTransaction(
          {required TransactionHeaders headers,
          required Transaction transaction}) =>
      _pe.rollbackTransaction(headers: headers, transaction: transaction);

  @override
  Future metrics(
          {Map<String, String>? globalLabels, required MetricsFormat format}) =>
      _pe.metrics(globalLabels: globalLabels, format: format);

  /// Apply migrations from the specified path
  ///
  /// The [path] parameter is required and contains the path to the migrations
  /// The [bundle] parameter is optional and contains the asset bundle to load migrations from
  Future<void> applyMigrations({
    required String path,
    AssetBundle? bundle,
  }) async {
    if (Platform.isIOS || Platform.isAndroid) {
      return (_pe as ffi.LibraryEngine)
          .applyMigrations(path: path, bundle: bundle);
    }
  }
}
