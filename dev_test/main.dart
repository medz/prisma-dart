import 'package:orm/prisma_client.dart';

void main() async {
  final PrismaClient prisma = createPrismaClient();

  try {
    final users = await prisma.user.findMany(
      // where: UserWhereInput(
      //   id: IntFilter(
      //     lte: 100,
      //   ),
      // ),
      where: UserWhereInput.fromJson({
        "id": {"lte": 100},
      }),
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
