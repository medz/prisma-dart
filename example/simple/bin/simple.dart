import 'package:faker/faker.dart';
<<<<<<< HEAD:example/simple/bin/simple.dart
import 'package:simple/simple.dart';
=======

import 'prisma_client.dart';
>>>>>>> main:example/simple/bin/simple_example.dart

/// Create a Prisma client.
final PrismaClient prisma = PrismaClient();

void main(List<String> args) async {
  try {
    final User user = await prisma.user.create(
      data: UserCreateInput(name: Faker().person.name()),
    );

    print(user.toJson());
  } catch (e) {
    print(e);
  } finally {
    await prisma.$disconnect();
  }
}
