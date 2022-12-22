import 'package:prisma_get_platform/prisma_get_platform.dart';

void main() {
  final String version = getBinaryPlatform();

  print(version);
}
