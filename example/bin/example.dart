import 'package:orm/configure.dart';
import 'package:orm/orm.dart';

void main() async {
  final config = EngineConfig(
    env: configure.environment,
    datamodelPath: 'prisma/schema.prisma',
  );

  final engine = BinaryEngine(config);
  await engine.start();

  try {
    final result = await engine.request(
      query: r'''
query {
  findManyUser {
    id
    name
  }
}
      ''',
    );
    print(result.toJson());
  } on PrismaClientKnownRequestError catch (e) {
    print(e.message);
  } finally {
    await engine.stop();
  }
}
