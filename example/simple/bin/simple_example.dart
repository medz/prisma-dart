import 'package:faker/faker.dart';

import 'prisma_client.dart';

/// Create a Prisma client.
final PrismaClient prisma = PrismaClient();

void main(List<String> args) async {
  final DateTime now = DateTime.now();
  try {
    final User user = await prisma.user.create(
      data: UserCreateInput(
        name: Faker().person.name(),
        createdAt: now,
      ),
    );

    print(user.toJson());
  } catch (e) {
    print(e.toString());
  } finally {
    await prisma.$disconnect();
  }
}
