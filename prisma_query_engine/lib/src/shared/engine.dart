/// Fork see: https://github.com/prisma/prisma/blob/main/packages/engine-core/src/common/Engine.ts
abstract class Engine {
  const Engine();
  Future<void> start();
  Future<void> stop();
  Future<Map<String, dynamic>> batch(Map<String, dynamic> payload) ;
  Future<Map<String, dynamic>> request(Map<String, dynamic> payload) ;
}
