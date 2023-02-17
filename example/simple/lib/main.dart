import 'package:orm/logger.dart';

import 'prisma_client.dart';

final prisma = PrismaClient(
  stdout: Event.values,
  datasources: Datasources(
    db: 'file:./prisma/db.sqlite',
  ),
);

void main() async {
  await prisma.$connect();
  await Future.delayed(Duration(seconds: 3600));
  try {
    SaySomething? result;
    result ??= await prisma.saySomething.create(
      data: SaySomethingCreateInput(text: 'Hello World!'),
    );

    print(result.text);
  } finally {
    // await prisma.$disconnect();
  }
}
