/// Prisma configuration.
///
/// E.g:
/// ```dart
/// final value = configure('key');
/// final environment = configure.environment;
/// final envValue = configure.env('key');
/// ```
abstract class Configure {
  /// Get all configuration.
  Map<String, dynamic> get all;

  /// Call getter.
  dynamic call(String name, [dynamic defaultValue]) =>
      all.containsKey(name.toLowerCase())
          ? all[name.toLowerCase()]
          : defaultValue;

  /// Environments.
  Map<String, String> get environment => call('environment');

  /// Get environment variable.
  String? env(String name) => environment[name];
}
