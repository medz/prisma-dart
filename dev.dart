import 'package:orm/logger.dart';
import 'package:orm/src/generated/prisma/prisma_client.dart';

final prisma = PrismaClient(
  stdout: Event.values,
  datasources: Datasources(db: "file:./prisma/prisma.sqlite"),
);

void main() async {
  try {
    User? user = await prisma.user.findFirst();
    user ??= await prisma.user.create(
      data: UserCreateInput(name: 'Seven'),
    );

    print(user.toJson());

    final users = await prisma.user.findMany();
    print(users.map((e) => e.toJson()));
  } finally {
    await prisma.$disconnect();
  }
}
