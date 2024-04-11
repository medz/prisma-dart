import 'dart:io';

import 'package:path/path.dart';

final Directory projectDirectory = _findProjectDirectory(Directory.current);

Directory _findProjectDirectory(Directory directory) {
  final pubspec = File(join(directory.path, 'pubspec.yaml'));
  if (pubspec.existsSync() || _isOsRoot(directory)) {
    return directory;
  }

  return _findProjectDirectory(directory.parent);
}

bool _isOsRoot(Directory directory) {
  if (Platform.isWindows) {
    return directory.path.endsWith(':\\');
  }

  return relative(directory.path, from: '/') == '.';
}
