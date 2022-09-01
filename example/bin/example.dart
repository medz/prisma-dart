import 'package:orm/configure.dart';
import 'package:orm/orm.dart';

void main() async {
  final config = EngineConfig(
    env: configure.environment,
    datamodelPath: 'prisma/schema.prisma',
  );

  final engine = BinaryEngine(config);

  final version = await engine.version(forceRun: true);

  print(version);
}
