import 'dart:io';

import 'package:with_sqlite/with_sqlite.dart';

final datasourceUrl =
    'file:${File.fromUri(Platform.script).parent.parent.path}/prisma/dev.db';
final prisma = PrismaClient(datasourceUrl: datasourceUrl);

Future<void> main() async {
  try {
    await prisma.$connect();

    final games = await prisma.game.findMany();
    print(games.map((e) => e.toJson()));
  } finally {
    await prisma.$disconnect();
  }
}
