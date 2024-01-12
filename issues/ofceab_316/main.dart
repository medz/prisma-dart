import 'prisma/generated_dart_client/client.dart';

void main(List<String> args) async {
  final prisma = PrismaClient();
  try {
    final jobs = await prisma.clientJob.findMany();

    print(jobs);
  } finally {
    await prisma.$disconnect();
  }
}
