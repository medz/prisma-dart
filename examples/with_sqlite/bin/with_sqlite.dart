import 'package:with_sqlite/with_sqlite.dart';

final prisma = PrismaClient();

Future<void> main() async {
  try {
    await prisma.$connect();

    final games = await prisma.game.findMany();
    print(games.map((e) => e.toJson()));
  } finally {
    await prisma.$disconnect();
  }
}
