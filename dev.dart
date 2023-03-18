import 'package:orm/logger.dart';
import 'package:orm/prisma_client.dart';

final prisma = PrismaClient(
  stdout: Event.values,
  datasources: Datasources(db: "file:./prisma/prisma.sqlite"),
);

void main() async {
  try {
    final users = await prisma.user.findMany();

    print(users.map((e) => e.toJson()));
  } finally {
    await prisma.$disconnect();
  }
}
