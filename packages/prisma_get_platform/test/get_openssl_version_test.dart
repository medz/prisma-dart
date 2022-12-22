import 'package:prisma_get_platform/src/get_openssl_version.dart';
import 'package:test/test.dart';

void main() {
  test('openssl version', () async {
    final String version = getOpenSSLVersion();
    final Iterable<String> supportedVersions = [
      '1.0.x',
      '1.1.x',
      '3.0.x',
    ];

    expect(supportedVersions.contains(version), isTrue);
  });
}
