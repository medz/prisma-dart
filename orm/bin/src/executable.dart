import 'dart:io' if (dart.library.io) 'dart:io';

/// Executable install type for the Prisma CLI.
enum ExecutableInstallType {
  none,
  native,
  projectDependency(['pub', 'run', 'prisma_cli']),
  globalDependency(['pub', 'global', 'run', 'prisma_cli']),
  ;

  final List<String> arguments;

  const ExecutableInstallType([this.arguments = const <String>[]]);

  /// Get executable
  String get executable =>
      this == ExecutableInstallType.native ? 'prisma' : 'dart';

  /// Arguments wrap for the executable.
  List<String> argumentsWrap(List<String> args) => [...arguments, ...args];
}

/// Prisma CLI executable.
class Executable {
  /// Creates a new executable.
  Executable(this.arguments);

  /// Input arguments.
  final List<String> arguments;

  /// Run proxy executable.
  void run() async {
    final ExecutableInstallType type = _getInstallType();
    if (type == ExecutableInstallType.none) {
      _printNotInstalledMessage();
      return;
    }
    final Process process = await Process.start(
      type.executable,
      type.argumentsWrap(arguments),
      workingDirectory: Directory.current.path,
      includeParentEnvironment: true,
    );

    await Future.wait([
      stdin.pipe(process.stdin),
      process.stderr.pipe(stderr),
      process.stdout.pipe(stdout),
    ]);

    exitCode = await process.exitCode;
    process.kill();
  }

  /// Get executable install type.
  ExecutableInstallType _getInstallType() {
    // If current platform is Windows, Find `prisma` in PATH.
    if (Platform.isWindows) {
      final List<String> paths =
          (Process.runSync('where', ['prisma']).stdout as String)
              .split('\r\n')
              .where((String path) => path.trim().isNotEmpty)
              .toList();
      if (paths.isNotEmpty) {
        return ExecutableInstallType.native;
      }
    }

    // Unix platform, Find `prisma` in PATH.
    final List<String> paths =
        (Process.runSync('command', ['-v', 'prisma']).stdout as String)
            .split('\n')
            .where((String path) => path.trim().isNotEmpty)
            .toList();
    if (paths.isNotEmpty) {
      return ExecutableInstallType.native;
    }

    /// Find `prisma_cli` in project dependency.
    final String findInProjectOutput = Process.runSync(
            Platform.resolvedExecutable, ['pub', 'deps', '-s', 'list']).stdout
        as String;
    if (findInProjectOutput.contains('prisma_cli')) {
      return ExecutableInstallType.projectDependency;
    }

    /// Find `prisma_cli` in global dependency.
    final String findInGlobalOutput =
        Process.runSync(Platform.resolvedExecutable, ['pub', 'global', 'list'])
            .stdout as String;
    if (findInGlobalOutput.contains('prisma_cli')) {
      return ExecutableInstallType.globalDependency;
    }

    return ExecutableInstallType.none;
  }

  /// Print not installed Prisma CLI message.
  void _printNotInstalledMessage() {
    stderr.writeln('Prisma CLI is not installed.');
    stdout.writeln();
    stdout.writeln('🚀 Now, install Prisma CLI for your project:');
    stdout.writeln('    \$ dart pub add prisma_cli');
    exitCode = 1;
  }
}
