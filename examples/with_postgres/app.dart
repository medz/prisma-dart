import 'package:orm/orm.dart';

import 'prisma/generated_dart_client/client.dart';
import 'prisma/generated_dart_client/prisma.dart';

final prisma = PrismaClient();

void main() async {
  try {
    final users = await prisma.user.findMany(
      where: UserWhereInput(
        name: PrismaUnion.$1(
          StringFilter($in: PrismaUnion.$1(['First', 'Last'])),
        ),
      ),
    );

    print('Found ${users.length} users.');
  } finally {
    await prisma.$disconnect();
  }
}
