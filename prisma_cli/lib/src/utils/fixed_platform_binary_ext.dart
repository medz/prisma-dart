import 'dart:io';

/// fixed platform binary extension.
String fixedPlatformBinaryExt(String path) {
  if (Platform.isWindows && !path.endsWith('.exe')) {
    return '$path.exe';
  }

  return path;
}
