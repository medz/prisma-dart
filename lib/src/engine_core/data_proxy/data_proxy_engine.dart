import 'dart:async';

import '../common/engine.dart';
import '../common/get_config_result.dart';
import '../common/types/query_engine.dart';
import '../common/types/transaction.dart';

class DataProxyEngine extends Engine {
  DataProxyEngine({
    required super.schema,
    required super.dmmf,
    required super.datasources,
    required super.environment,
  });

  @override
  Future<void> commitTransaction(
      {required TransactionHeaders headers, required TransactionInfo info}) {
    throw UnimplementedError('Interactive transactions are not yet supported');
  }

  @override
  Future<void> rollbackTransaction(
      {required TransactionHeaders headers, required TransactionInfo info}) {
    throw UnimplementedError('Interactive transactions are not yet supported');
  }

  @override
  Future<TransactionInfo> startTransaction(
      {required TransactionHeaders headers,
      TransactionOptions options = const TransactionOptions()}) {
    throw UnimplementedError('Interactive transactions are not yet supported');
  }

  @override
  Future<void> start() async {
    // Ignore: Data proxy don't need to start
  }

  @override
  Future<void> stop() async {
    // Ignore: Data proxy don't need to stop
  }

  @override
  FutureOr<GetConfigResult> getConfig() {
    // TODO: implement getConfig
    throw UnimplementedError();
  }

  @override
  Future<QueryEngineResult> request(
      {required String query, QueryEngineRequestHeaders? headers}) {
    // TODO: implement request
    throw UnimplementedError();
  }
}
