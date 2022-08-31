import 'dart:io';

import 'package:orm/configure.dart';
import 'package:orm/orm.dart';

void main() async {
  final config = EngineConfig(
    env: configure.environment,
    datamodelPath: 'prisma/schema.prisma',
    prismaPath: '.dart_tool/prisma-engines/query-engine',
    cwd: Directory.current.path,
  );

  final engine = BinaryEngine(config);

  await engine.start();
  await Future.delayed(const Duration(seconds: 5));
  await engine.stop();
}
