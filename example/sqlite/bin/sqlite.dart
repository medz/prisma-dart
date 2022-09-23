import 'package:sqlite/prisma_client.dart';

void main(List<String> arguments) async {
  final PrismaClient prisma = PrismaClient();

  try {
    final result = await prisma.task.upsert(
      where: TaskWhereUniqueInput(id: "cl8e3jsg60000k1qcunwd0v13"),
      create: TaskCreateInput(
        id: "cl8e3jsg60000k1qcunwd0v13",
        task: "Learn Prisma",
      ),
      update: TaskUpdateInput(),
    );
    print(result.toJson());
  } catch (e) {
    print(e);
  } finally {
    prisma.$disconnect();
  }
}
