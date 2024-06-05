import '_env.shared.dart' show Environment;
import '_env.shared.dart' if (dart.library.io) '_create_environment.io.dart'
    show createEnvironment;

export '_env.shared.dart' show Environment;

/// Enviroment
///
/// Match stack:
/// 1. `bool.hasEnviroment`, Using the `--define` key-value part.
/// 2. Internal enviroment map, contains key, if extsis return it.
/// 3. load `.env` from `<PWD | Exe Dir>/.env` or `<PWD | Exe Dir>/prisma.env` file.
///
/// Example:
/// ```dart
/// // Read a env value.
/// final debug = env('DEBUG'); // String or null
///
/// // Add other env
/// env.add({'HI': "Hello"});
/// final hi = env('HI'); // "Hello"
/// ```
final env = createEnvironment();

extension EnvironmentUtils on Environment {
  /// Returns a value parsed to [bool] type.
  ///
  /// If the value is `true` | `on` | `1` return `true`, other reurn `false` value.
  bool boolean(String name) {
    const trueStrings = <String>['true', '1', 'on'];

    return trueStrings.contains(this(name));
  }

  /// Returns a value parsed to [num] type.
  ///
  /// Try parse string value, if faild return `0`
  num number(String name) {
    final value = this(name);
    if (value == null) return 0;

    final number = num.tryParse(value);
    if (number != null) return number;

    final bigint = BigInt.tryParse(value);
    if (bigint != null) bigint.toDouble();

    return 0;
  }
}
