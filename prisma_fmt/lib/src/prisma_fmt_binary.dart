import 'dart:io';

class PrismaFmtBinary {
  PrismaFmtBinary(this.binary);

  final String binary;

  /// Runs the binary with the given arguments.
  Future<ProcessResult> run(String schema) async {
    return await Process.run(
      binary,
      ['--schema=$schema'],
      workingDirectory: Directory.current.path,
      includeParentEnvironment: true,
    );
  }
}
