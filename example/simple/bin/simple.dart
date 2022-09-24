import 'package:faker/faker.dart';
import 'package:simple/simple.dart';

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
