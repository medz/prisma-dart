import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import '../../bin/generator/prisma_info.dart';

testKit(String packageManager, String version) {
  return () {
    late PrismaInfo info;

    setUpAll(() {
      info = PrismaInfo.lookup(packageManager);
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
  };
}

void main() {
  final String version = Process.runSync(
    'npm',
    ['exec', '--', 'prisma', 'version', '--json'],
    stdoutEncoding: utf8,
  ).stdout;

  group('npm', testKit('npm', version));
  group('yarn', testKit('yarn', version));
  group('pnpm', testKit('pnpm', version));
}
