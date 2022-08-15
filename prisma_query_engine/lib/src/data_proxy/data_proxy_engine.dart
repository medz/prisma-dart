import 'package:prisma_query_engine/prisma_query_engine.dart';

import '../shared/shared.dart' as shared;

class DataProxyEngine implements shared.Engine {
  @override
  Future<void> start() {
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    throw UnimplementedError();
  }
  
  @override
  Future<GQLBatchResponse> batch(GQLBatchRequest payload) {
    throw UnimplementedError();
  }
  
  @override
  Future<GQLResponse> request(GQLRequest payload) {
    throw UnimplementedError();
  }
}
