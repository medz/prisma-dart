import 'package:orm/prisma_client.dart';

void main() async {
  final PrismaClient prisma = PrismaClient();

  try {
    final User user = await prisma.user.upsert(
      where: UserWhereUniqueInput(name: 'Odroe'),
      create: UserCreateInput(name: 'Odroe'),
      update: UserUpdateInput(),
    );

    print(user.toJson());
  } catch (e) {
    await prisma.$disconnect();
    rethrow;
  } finally {
    await prisma.$disconnect();
  }
}
