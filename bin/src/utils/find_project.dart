import 'dart:io';

import 'package:path/path.dart';

/// project directory.
String get projectDirectory {
  final Directory current = Directory.current;
  if (!current.existsSync()) {
    throw Exception('Current directory does not exist.');
  }

  final File pubspec = File(joinAll([current.path, 'pubspec.yaml']));
  if (!pubspec.existsSync()) {
    throw Exception('Current directory is not a [Dart/Flutter] project.');
  }

  return current.path;
}

/// Join paths with [projectDirectory].
String joinPaths(List<String> parts) => joinAll([projectDirectory, ...parts]);
