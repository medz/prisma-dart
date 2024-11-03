import 'package:orm/orm.dart';

class LibraryEngine extends Engine {
  LibraryEngine({
    required super.options,
    required super.schema,
    required super.datasources,
  });

  @override
  Future<void> commitTransaction(
      {required TransactionHeaders headers, required Transaction transaction}) {
    // TODO: implement commitTransaction
    throw UnimplementedError();
  }

  @override
  Future metrics(
      {Map<String, String>? globalLabels, required MetricsFormat format}) {
    // TODO: implement metrics
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
  Future<void> start() {
    // TODO: implement start
    throw UnimplementedError();
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
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }
}
