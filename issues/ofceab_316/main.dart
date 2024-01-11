import 'prisma/generated_dart_client/client.dart';

void main(List<String> args) async {
  final prisma = PrismaClient();
  try {
    final users = await prisma.user.findMany();

    print(users);
  } finally {
    await prisma.$disconnect();
  }
}
