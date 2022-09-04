import 'package:example/example.dart';

void main(List<String> args) async {
  final prisma = PrismaClient();

  final user = await prisma.user.findUnique(
    where: UserWhereUniqueInput(id: 1),
  );

  print(user);

  await prisma.$disconnect();
}
