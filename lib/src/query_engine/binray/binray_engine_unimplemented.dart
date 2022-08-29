import '../../dmmf/dmmf.dart';
import '../common/engine.dart';
import '../common/get_config_result.dart';
import '../common/types/query_engine.dart';
import '../common/types/transaction.dart';

class BinrayEngine extends Engine {
  const BinrayEngine(super.config);

  @override
  Future<void> commitTransaction(
      {required TransactionHeaders headers, required TransactionInfo info}) {
    throw UnimplementedError();
  }

  @override
  Future<GetConfigResult> getConfig() {
    throw UnimplementedError();
  }

  @override
  Future<Document> getDmmf() {
    throw UnimplementedError();
  }

  @override
  Future<QueryEngineResult> request(
      {required String query,
      QueryEngineRequestHeaders? headers,
      int? numTry}) {
    throw UnimplementedError();
  }

  @override
  Future<QueryEngineResult> requestBatch(
      {required List<String> queries,
      QueryEngineRequestHeaders? headers,
      bool? transaction,
      int? numTry}) {
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
      {required TransactionHeaders headers, TransactionOptions? options}) {
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    throw UnimplementedError();
  }

  @override
  Future<String> version({bool forceRun = false}) {
    throw UnimplementedError();
  }
}
