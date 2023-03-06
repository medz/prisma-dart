import 'dart:io';
import 'dart:convert' as convert;

import 'package:path/path.dart';

class PrismaInfo {
  /// Prisma version
  final String version;

  /// Current platform
  final String platform;

  const PrismaInfo._(this.version, this.platform);

  /// Lookup the Prisma version and platform.
  factory PrismaInfo.lookup(String packageManager) {
    final pm = NodePackageManager(packageManager.trim());

    final result = Process.runSync(
      pm.toExecutable(),
      [
        'exec',
        if (pm.isNpm) '--',
        'prisma',
        'version',
        if (pm.isYarn) '--',
        '--json'
      ],
      stdoutEncoding: convert.utf8,
    );

    // Find JSON block.
    final json = result.stdout.toString().split('{').last.split('}').first;
    final map = convert.json.decode('{$json}');

    return PrismaInfo._(map['prisma'], map['current-platform']);
  }
}

class NodePackageManager {
  static final separator = Platform.isWindows ? ';' : ':';

  final String packageManager;

  const NodePackageManager(this.packageManager);

  Iterable<String> get executables sync* {
    yield '$packageManager.cmd';
    yield '$packageManager.ps1';
    yield '$packageManager.bat';
    yield '$packageManager.exe';
    yield packageManager;
  }

  Iterable<String> get paths sync* {
    yield Directory.current.path;
    yield join(Directory.current.path, 'node_modules', '.bin');
    yield* Platform.environment['PATH']?.split(separator) ?? [];
  }

  /// Find the executable for the package manager full path.
  String toExecutable() {
    // If the package manager is already an executable, return it.
    if (File(packageManager).existsSync()) {
      return packageManager;
    }

    for (final path in paths) {
      for (final executable in executables) {
        final full = join(path.trim(), executable);
        if (File(full).existsSync()) {
          return full;
        }
      }
    }

    throw StateError('Unable to find $packageManager executable.');
  }

  bool get isNpm => basename(toExecutable()).toLowerCase().startsWith('npm');
  bool get isYarn => basename(toExecutable()).toLowerCase().startsWith('yarn');
}
