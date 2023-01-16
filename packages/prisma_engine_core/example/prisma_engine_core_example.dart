import 'package:prisma_engine_core/prisma_engine_core.dart';
import 'package:prisma_engine_core/src/transaction.dart';
import 'package:prisma_engine_core/src/query_engine_request_headers.dart';

class ExampleEngine implements Engine {
  @override
  Future<void> commitTransaction(
      {required TransactionHeaders headers, required TransactionInfo info}) {
    throw UnimplementedError();
  }

  @override
  Future request(
      {required String query,
      int? attempt,
      QueryEngineRequestHeaders? headers,
      TransactionInfo? transaction}) {
    throw UnimplementedError();
  }

  @override
  Future<void> rollbackTransaction(
      {required TransactionHeaders headers, required TransactionInfo info}) {
    throw UnimplementedError();
  }

  @override
  Future<void> start() {
    throw UnimplementedError();
  }

  @override
  Future<TransactionInfo> startTransaction(
      {required TransactionHeaders headers,
      Duration timeout = const Duration(seconds: 5),
      Duration maxWait = const Duration(seconds: 2),
      IsolationLevel? isolationLevel}) {
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    throw UnimplementedError();
  }
}
