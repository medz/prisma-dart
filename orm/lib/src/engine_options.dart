import 'binary_type.dart';
import 'engine_platform.dart';

class EngineOptions {
  const EngineOptions({
    required this.version,
    required this.platform,
    required this.binary,
    this.customBinaryPath,
  });

  /// Engine platform.
  final EnginePlatform platform;

  /// Engine version.
  final String version;

  /// Engine binary type.
  final BinaryType binary;

  /// Custom binary path.
  final String? customBinaryPath;
}
