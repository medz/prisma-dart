import 'dart:io';

String getPlatform() {
  // macOS
  if (Platform.isMacOS) {
    // If Platform.version include "macos_arm64", it's a arm64 device.
    if (Platform.version.contains('macos_arm64')) {
      return 'darwin-arm64';
    }
    return 'darwin';

    // Windows
  } else if (Platform.isWindows) {
    return 'windows';
  }

  return 'debian-openssl-1.1.x';
}
