import 'package:orm/orm.dart';
import 'package:prisma_with_sqlite/with_sqlite.dart';

final prisma = PrismaClient(log: {
  (LogLevel.query, LogEmit.stdout),
});

Future<void> main() async {
  try {
    // With transaction run query
    final gamesWithTransaction = await prisma.$transaction((prisma) async {
      final result = await prisma.game.aggregate(
        select: AggregateGameSelect(
          $count: PrismaUnion.$2(
            AggregateGameCountArgs(
              select: GameCountAggregateOutputTypeSelect(id: true),
            ),
          ),
        ),
      );
      if (result.$count!.id! <= 3) {
        await prisma.game.create(
          data: PrismaUnion.$2(
            GameUncheckedCreateInput(name: 'Game ${result.$count?.id}'),
          ),
        );
      }

      return await prisma.game.findMany();
    });
    print(gamesWithTransaction.map((e) => e.toJson()));

    // Find many
    final games = await prisma.game.findMany();
    print(games.map((e) => e.toJson()));

    // SQL query all rows.
    final result = await prisma.$raw.query('SELECT * FROM games');
    print(result);

    // Delete a `game_id` eq "1" row, DB not found "1", returns `0`
    print(await prisma.$raw.execute(r'delete from games where game_id = "1"'));
  } finally {
    await prisma.$disconnect();
  }
}
