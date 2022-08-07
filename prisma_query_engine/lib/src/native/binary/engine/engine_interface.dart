

abstract class Engine {
  Future<void>  connect();
  Future<void>  disconnect();
  Future<Map<String,dynamic>> execute(Map<String,dynamic> payload);
  Future<Map<String,dynamic>> batch(Map<String,dynamic> payload);
  String get name;
}
