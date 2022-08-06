/// Fork see: https://github.com/prisma/prisma/blob/main/packages/engine-core/src/common/Engine.ts
abstract class Engine {
  const Engine();
  Future<void> start();
  Future<void> stop();
}
