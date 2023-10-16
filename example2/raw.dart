import 'main.dart' hide main;

void main() async {
  try {
    const sql = 'SELECT DATE(\'now\')';
    final result = await prisma.$queryRaw(sql);

    print(result);
  } finally {
    await prisma.$disconnect();
  }
}
