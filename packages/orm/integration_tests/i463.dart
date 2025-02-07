import '../prisma/client/client.dart';

final prisma = PrismaClient(
    datasourceUrl: "postgresql://seven@localhost:5432/prisma?schema=public");

main() async {
  try {
    final query = 'SELECT * FROM "User"';
    // A series of valid queries
    await prisma.$raw.query(query);
    await prisma.$raw.query(query);
    await prisma.$raw.query(query);
    await prisma.$raw.query(query);
    await prisma.$raw.query(query);

    // Execute multiple queries concurrently, including one with an intentional syntax error
    Future.wait([
      prisma.$raw.query(query),
      prisma.$raw.query(query),
      prisma.$raw.query('SELEC Q FROM Q'), // Intentional syntax error
      prisma.$raw.query(query),
      prisma.$raw.query(query),
      prisma.$raw.query(query),
      prisma.$raw.query(query),
      prisma.$raw.query(query),
      prisma.$raw.query(query),
      prisma.$raw.query(query),
      prisma.$raw.query(query),
    ]);

    // More queries after the batch
    await prisma.$raw.query(query);
    await prisma.$raw.query(query);
    await prisma.$raw.query(query);
    await prisma.$raw.query(query);
    await prisma.$raw.query(query);
  } catch (e) {
    print(222);
    rethrow;
  } finally {
    print(333);
    await prisma.$disconnect();
  }
}
