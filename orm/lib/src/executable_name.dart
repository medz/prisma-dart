import 'dart:io';

import 'package:io/ansi.dart';
import 'package:path/path.dart';

import 'utils/get_project_directory.dart';

/// ORM executable name.
String get executableName {
  // If ".dart_tool/pub/bin/orm" exists, then we're running from the Dart SDK.
  if (Directory(
          joinAll([getProjectDirectory(), '.dart_tool', 'pub', 'bin', 'orm']))
      .existsSync()) {
    return green.wrap('dart run orm')!;
  }

  return green.wrap('prisma')!;
}
