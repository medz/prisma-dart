import 'package:orm/orm.dart';
import 'package:with_sqlite/with_sqlite.dart';

final prisma = PrismaClient(log: {
  (LogLevel.info, LogEmit.stdout),
});

Future<void> main() async {
  try {
    final games = await prisma.$transaction((prisma) async {
      return await prisma.game.findMany();
    });

    // final games = await prisma.game.findMany();
    print(games.map((e) => e.toJson()));
  } finally {
    await prisma.$disconnect();
  }
}
