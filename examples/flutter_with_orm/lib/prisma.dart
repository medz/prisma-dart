import 'package:flutter/widgets.dart';
import 'package:orm_flutter/orm_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '_generated_prisma_client/client.dart';

late final PrismaClient prisma;

Future<void> initPrismaClient() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supportDir = await getApplicationSupportDirectory();
  final database = join(supportDir.path, 'database.sqlite');

  late final PrismaFlutterEngine engine;
  prisma = PrismaClient.use((schema, datasources) {
    return engine = PrismaFlutterEngine(schema: schema, datasources: {
      ...datasources,
      'db': 'file:$database',
    });
  });

  await prisma.$connect();
  await engine.applyMigrations(path: 'prisma/migrations');
}
