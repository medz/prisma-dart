import 'package:orm/prisma_client.dart';

void main() async {
  final PrismaClient prisma = createPrismaClient();

  try {
    final users = await prisma.user.findMany(
      where: UserWhereInput(
        id: UserWhereInput_id.withIntFilter(
          IntFilter(
            dart__in: [1, 2, 3],
          ),
        ),
      ),
    );

    print(users.map((e) => e.toJson()));

    await prisma.user.findUniqueOrThrow(
      where: UserWhereUniqueInput(
        id: 2,
      ),
    );
  } catch (e) {
    print(e);
  } finally {
    await prisma.$disconnect();
  }
}
