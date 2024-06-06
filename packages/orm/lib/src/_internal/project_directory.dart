import 'dart:io';

import 'package:path/path.dart' as path;

Directory? findProjectDirectory() =>
    _nestFindPubspecDirectory(File.fromUri(Platform.script).parent);

Directory? _nestFindPubspecDirectory(Directory directory) {
  try {
    final pubspec = File(path.join(directory.path, 'pubspec.yaml'));
    if (pubspec.existsSync()) return directory;
    if (_isOsRoot(directory)) return null;

    return _nestFindPubspecDirectory(directory.parent);
  } catch (_) {
    return null;
  }
}

bool _isOsRoot(Directory directory) {
  if (Platform.isWindows) {
    return directory.path.endsWith(':\\');
  }

  return path.relative(directory.path, from: '/') == '.';
}
