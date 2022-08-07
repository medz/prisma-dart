import '../../shared/shared.dart' as shared;

class Engine extends shared.Engine {
  @override
  Future<void> start() {
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> batch(Map<String, dynamic> payload) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> request(Map<String, dynamic> payload) {
    throw UnimplementedError();
  }
}
