import 'package:orm/logger.dart';

import 'prisma_client.dart';

final prisma = PrismaClient(
  stdout: Event.values,
  datasources: Datasources(
    db: 'file:./prisma/db.sqlite',
  ),
);

void main() async {
  try {
    SaySomething? result = await prisma.saySomething.findFirst();
    result ??= await prisma.saySomething.create(
      data: SaySomethingCreateInput(text: 'Hello World!'),
    );

    print(result.toJson());
  } finally {
    await prisma.$disconnect();
  }
}
