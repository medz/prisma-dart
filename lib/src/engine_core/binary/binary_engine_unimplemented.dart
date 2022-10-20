import 'dart:async';

import '../../../version.dart';
import '../../dmmf/dmmf.dart' show Document;
import '../common/engine.dart';
import '../common/get_config_result.dart';
import '../common/types/query_engine.dart';
import '../common/types/transaction.dart';

class BinaryEngine extends Engine {
  const BinaryEngine({
    required super.dmmf,
    required super.schema,
    required super.datasources,
    required super.environment,
    required super.logEmitter,
    this.allowTriggerPanic = false,
    this.executable,
    this.workingDirectory,
  });

  /// The binary engine executable.
  final FutureOr<String?>? executable;

  /// Binary engine working directory.
  final String? workingDirectory;

  /// Allow trigger panic.
  final bool allowTriggerPanic;

  @override
  Future<QueryEngineResult> request({
    required String query,
    QueryEngineRequestHeaders? headers,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> rollbackTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<TransactionInfo> startTransaction({
    required TransactionHeaders headers,
    TransactionOptions options = const TransactionOptions(),
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> commitTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> start() {
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    throw UnimplementedError();
  }

  @override
  Future<String> version({bool forceRun = false}) async {
    if (forceRun) return binaryVersion;

    return super.version(forceRun: forceRun);
  }

  @override
  FutureOr<GetConfigResult> getConfig({bool forceRun = false}) {
    throw UnimplementedError();
  }

  @override
  FutureOr<Document> getDmmf({bool forceRun = false}) {
    if (!forceRun) return super.getDmmf();

    throw UnimplementedError();
  }
}
