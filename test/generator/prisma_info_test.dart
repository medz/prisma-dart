import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import '../../bin/src/prisma_info.dart';

void main() {
  late String version;
  late PrismaInfo info;

  setUpAll(() {
    info = PrismaInfo.lookup('npm');
    version = Process.runSync(
      findNpmExecutable('npm'),
      ['exec', '--', 'prisma', 'version', '--json'],
      stdoutEncoding: utf8,
    ).stdout;
  });

  test('version', () {
    final jsonLine = '"prisma": "${info.version}"';
    expect(version, contains(jsonLine));
  });

  test('platform', () {
    final jsonLine = '"current-platform": "${info.platform}"';
    expect(version, contains(jsonLine));

    if (Platform.isMacOS) {
      expect(info.platform, equals('darwin'));
    } else if (Platform.isWindows) {
      expect(info.platform, equals('windows'));
    }
  });
}
