import 'dart:io';

/// Set file execution permissions.
Future<void> chmod(String path) async {
  // If current platform is Windows, return.
  if (Platform.isWindows) {
    return;
  }

  final String permissions = File(path).statSync().modeString();
  // permission index of 2, 5, 8 equals to 'x'.
  if (permissions[2] == 'x' && permissions[5] == 'x' && permissions[8] == 'x') {
    return;
  }

  // Set file execution permissions.
  await Process.run('chmod', ['+x', path]).then<void>((ProcessResult result) {
    if (result.exitCode != 0) {
      throw Exception('Failed to set file execution permissions: $path');
    }
  });
}
