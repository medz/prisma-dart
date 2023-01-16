import 'package:prisma_env/prisma_env.dart';
import 'package:test/test.dart';

void main() {
  group('Default Prisma Env', () {
    test('debug', () => expect(PrismaEnv.debug, isEmpty));
    test('noColor', () => expect(PrismaEnv.noColor, isFalse));
    test('generateDataProxy',
        () => expect(PrismaEnv.generateDataProxy, isFalse));
    test('clientDataProxyClientVersion',
        () => expect(PrismaEnv.clientDataProxyClientVersion, isNull));
    test(
        'enginesMirror',
        () => expect(
            PrismaEnv.enginesMirror, Uri.parse('https://binaries.prisma.sh')));
    test(
        'queryEngineBinary', () => expect(PrismaEnv.queryEngineBinary, isNull));
    test('migrationEngineBinary',
        () => expect(PrismaEnv.migrationEngineBinary, isNull));
    test('introspectionEngineBinary',
        () => expect(PrismaEnv.introspectionEngineBinary, isNull));
    test('fmtBinary', () => expect(PrismaEnv.fmtBinary, isNull));
  });
}
