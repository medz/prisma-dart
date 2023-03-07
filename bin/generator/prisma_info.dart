import 'dart:io';
import 'dart:convert' as convert;

import 'package:path/path.dart';

final _separator = Platform.isWindows ? ';' : ':';

Iterable<String> get _globalPaths sync* {
  yield Directory.current.path;
  yield join(Directory.current.path, 'node_modules', '.bin');
  yield* Platform.environment['PATH']?.split(_separator) ?? const <String>[];
}

const Iterable<String> _extensions = <String>[
  'cmd', // Windows CMD
  'ps1', // Windows PowerShell
  'bat', // Windows Batch
  'exe', // Windows Executable
  'sh', // Shell Script
];

String findNodePackageManagerExecutable(String packageManager) {
  if (File(packageManager).existsSync()) {
    return packageManager;
  }

  return _globalPaths.expand((path) sync* {
    // Generate all possible executable paths.
    yield* _extensions
        .map((extension) => join(path, '$packageManager.$extension'));

    // Generate without extension executable paths.
    yield join(path, packageManager);
  }).firstWhere((executable) => File(executable).existsSync(), orElse: () {
    // If no executable was found, throw an error.
    throw StateError('Unable to find $packageManager executable.');
  });
}

class PrismaInfo {
  /// Prisma version
  final String version;

  /// Current platform
  final String platform;

  const PrismaInfo._(this.version, this.platform);

  /// Lookup the Prisma version and platform.
  factory PrismaInfo.lookup(String packageManager) {
    final String result = Process.runSync(
      findNodePackageManagerExecutable(packageManager),
      ['exec', 'prisma', 'version'],
      stdoutEncoding: convert.utf8,
    ).stdout;

    final entries = result
        .split('\n')
        .where((element) => element.trim().isNotEmpty)
        .map((e) => e.split(':'))
        .where((element) => element.length == 2)
        .map((e) => MapEntry(e[0], e[1]))
        .map((e) => MapEntry(e.key.trim().toLowerCase(), e.value.trim()));
    final json = Map.fromEntries(entries);

    return PrismaInfo._(json['prisma']!, json['current platform']!);
  }
}
