import 'package:prisma_query_engine/src/shared/protocol.dart';

/// Fork see: https://github.com/prisma/prisma/blob/main/packages/engine-core/src/common/Engine.ts
abstract class Engine {
  const Engine();
  Future<void> start();
  Future<void> stop();
  Future<GQLBatchResponse> batch(GQLBatchRequest payload);
  Future<GQLResponse> request(GQLRequest payload);
}
