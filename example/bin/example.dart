import 'package:orm/configure.dart';
import 'package:orm/orm.dart';

void main() async {
  final config = EngineConfig(
    env: configure.environment,
    datamodelPath: 'prisma/schema.prisma',
    allowTriggerPanic: true,
  );

  final engine = BinaryEngine(config);
  await engine.start();

  // await Future.delayed(Duration(days: 1));

  try {
    final result = await engine.startTransaction(
      headers: TransactionHeaders(),
      options: TransactionOptions(
        isolationLevel: TransactionIsolationLevel.ReadCommitted,
      ),
    );
    print(result);
  } on PrismaClientKnownRequestError catch (e) {
    print(e.message);
  } on PrismaServerError catch (e) {
    print(e.message);
  } finally {
    await engine.stop();
  }
}
