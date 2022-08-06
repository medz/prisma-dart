/// Fork see: https://github.com/prisma/prisma/blob/main/packages/engine-core/src/common/Engine.ts
abstract class PrismaQueryEngine {
  Future<void> start();
  Future<void> stop();
}
