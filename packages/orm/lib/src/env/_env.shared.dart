/// Prisma environment.
class Environment {
  Environment._();

  final _enviroment = <String, String>{};

  /// Returns a enviroment value by [name], if the [name]
  /// not contains, return [null].
  String? call(String name) {
    if (bool.hasEnvironment(name)) return String.fromEnvironment(name);
    if (_enviroment.containsKey(name)) return _enviroment[name];

    return null;
  }

  /// Add [other] to the enviroment.
  void add(Map<String, String> other) => _enviroment.addAll(other);
}

/// Internal, create enviroment.
Environment createEnvironment() => Environment._();
