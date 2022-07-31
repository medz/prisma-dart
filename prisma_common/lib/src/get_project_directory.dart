import 'dart:io';

import 'package:path/path.dart' show join;

/// Get project directory.
String getProjectDirectory() {
  final Directory? projectDirectory = _findProjectDirectory(Directory.current);

  // If project directory is null, throw an exception.
  if (projectDirectory == null) {
    throw Exception(
        'Not found a Dart or Flutter project in ${Directory.current.path}');
  }

  return projectDirectory.path;
}

/// Check the [directory] is a Dart or Flutter project.
bool _isDartProject(String directory) {
  return File(join(directory, 'pubspec.yaml')).existsSync();
}

/// Find a directory recursively.
Directory? _findProjectDirectory(Directory directory) {
  // Current directory is a Dart project, return it.
  if (_isDartProject(directory.path)) {
    return directory;
  }

  // If parent equals to current directory, return null.
  if (directory.path == directory.parent.path) {
    return null;
  }

  // Find in parent directory.
  return _findProjectDirectory(directory.parent);
}
