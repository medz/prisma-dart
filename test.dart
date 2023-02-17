import 'package:orm/logger.dart';
import 'package:orm/prisma_client.dart';

final prisma = PrismaClient(
  stdout: Event.values,
  datasources: Datasources(
    db: 'postgres://seven@localhost:5432/prisma-dart?schema=public',
  ),
);

void main() async {
  try {
    final fluent = prisma.user.findUniqueOrThrow(
      where: UserWhereUniqueInput(id: 1),
    );

    final user = await fluent;
    print(user);

    final count = await fluent.$count();
    print(count.posts);

    final posts = await fluent.posts();
    print(posts);

    final group = await prisma.user.groupBy(
      by: [UserScalarFieldEnum.id],
    );
    print(group.map((e) => e.toJson()));

    final aggregate = prisma.user.aggregate();
    print(await aggregate.$count().id());
  } finally {
    await prisma.$disconnect();
  }
}
