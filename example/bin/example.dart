import 'package:example/example.dart';

void main(List<String> args) async {
  final prisma = PrismaClient();

  final user = await prisma.user.create(
    data: PrismaUnion(
      one: UserUncheckedCreateInput(
        name: 'Odroe',
      ),
    ),
  );

  print(user);
}
