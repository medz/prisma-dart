import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

void main() {
  final process = Process.runSync('bun', ['prisma', 'version', '--json']);
  final result = json.decode(process.stdout);
  if (result case {"default-engines-hash": String hash}) {
    final versionFile = File(path.join(
      path.dirname(Platform.script.toFilePath(windows: Platform.isWindows)),
      '..',
      'prisma-engines-version.txt',
    ));

    versionFile.writeAsStringSync(hash);
    stdout.writeln(
        '✅ [orm flutter] Write the hash "$hash" to ${path.relative(versionFile.path)}');
    return;
  }

  stderr.writeln('\n⚠️     Skip update engine hash. \n');
}
