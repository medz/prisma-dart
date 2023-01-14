import 'package:orm/prisma_client.dart';

void main() async {
  final PrismaClient prisma = createPrismaClient();

  try {
    // Create a new and delete it.
    final data = CreateOneUserData.withUserUncheckedCreateInput(
      UserUncheckedCreateInput(
        name: 'Some name',
        createdAt: DateTime.now(),
      ),
    );
    final user = await prisma.user.create(data: data);

    await prisma.user.delete(
      where: UserWhereUniqueInput(id: user.id),
    );
  } catch (e) {
    print(e);
  } finally {
    await prisma.$disconnect();
  }
}
