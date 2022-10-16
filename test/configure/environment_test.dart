import 'package:orm/configure.dart';
import 'package:orm/version.dart';
import 'package:rc/rc.dart';
import 'package:test/test.dart';

void main() {
  late PrismaEnvironment environment;

  setUp(() {
    environment = PrismaEnvironment();
  });

  tearDown(() {
    environment.clear();
  });

  test('is MapBase<String, String>', () {
    expect(environment, isA<Map<String, String>>());
  });

  test('is Environment', () {
    expect(environment, isA<Environment>());
  });

  test('debug', () {
    expect(environment.debug, isFalse);
    environment['DEBUG'] = 'true';
    expect(environment.debug, isTrue);
  });

  test('noColor', () {
    expect(environment.noColor, isNull);
    environment['NO_COLOR'] = 'true';
    expect(environment.noColor, 'true');
  });

  test('clientEngineType', () {
    expect(environment.clientEngineType, QueryEngineType.binary);

    environment['PRISMA_CLIENT_ENGINE_TYPE'] = 'demo';
    expect(environment.clientEngineType, QueryEngineType.binary);

    environment['PRISMA_CLIENT_ENGINE_TYPE'] = 'library';
    expect(environment.clientEngineType, QueryEngineType.library);
  });

  test('enginesMirror', () {
    expect(environment.enginesMirror, 'https://binaries.prisma.sh');
    environment['PRISMA_ENGINES_MIRROR'] = 'https://demo.prisma.sh';
    expect(environment.enginesMirror, 'https://demo.prisma.sh');
  });

  test('queryEngineBinary', () {
    expect(environment.queryEngineBinary, isNull);
    environment['PRISMA_QUERY_ENGINE_BINARY'] = 'demo';
    expect(environment.queryEngineBinary, 'demo');
  });

  test('queryEngineLibrary', () {
    expect(environment.queryEngineLibrary, isNull);
    environment['PRISMA_QUERY_ENGINE_LIBRARY'] = 'demo';
    expect(environment.queryEngineLibrary, 'demo');
  });

  test('migrationEngineBinary', () {
    expect(environment.migrationEngineBinary, isNull);
    environment['PRISMA_MIGRATION_ENGINE_BINARY'] = 'demo';
    expect(environment.migrationEngineBinary, 'demo');
  });

  test('introspectionEngineBinary', () {
    expect(environment.introspectionEngineBinary, isNull);
    environment['PRISMA_INTROSPECTION_ENGINE_BINARY'] = 'demo';
    expect(environment.introspectionEngineBinary, 'demo');
  });

  test('fmtBinary', () {
    expect(environment.fmtBinary, isNull);
    environment['PRISMA_FMT_BINARY'] = 'demo';
    expect(environment.fmtBinary, 'demo');
  });

  test('clientDataProxyClientVersion', () {
    expect(
        environment.clientDataProxyClientVersion, dataProxyRemoteClientVersion);
    environment['PRISMA_CLIENT_DATA_PROXY_CLIENT_VERSION'] = 'demo';
    expect(environment.clientDataProxyClientVersion, 'demo');
  });

  // generateDataProxy
  test('generateDataProxy', () {
    expect(environment.generateDataProxy, isFalse);
    environment['PRISMA_GENERATE_DATAPROXY'] = 'true';
    expect(environment.generateDataProxy, isTrue);
  });
}
