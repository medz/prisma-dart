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
    final result = await engine.requestBatch(
      queries: [
        r'''
          query {
            findManyUser {
              name
            }
          }
        ''',
        r'''
          query {
            findManyUser {
              id
            }
          }
        ''',
      ],
    );
    print(result);
  } on PrismaClientKnownRequestError catch (e) {
    print(e.message);
  } finally {
    await engine.stop();
  }
}
