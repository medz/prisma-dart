import 'dart:io';

import 'package:orm/orm.dart';

import '../prisma/dart/client.dart';
import '../prisma/dart/prisma.dart';

void main() async {
  final prisma = PrismaClient();
  try {
    final user = await prisma.user.findFirstOrThrow(
      select: UserSelect(
        id: true,
        name: true,
        $count: PrismaUnion.$1(true),
      ),
    );

    print(
        'Fond user ${user.name} (ID: ${user.id}), Total posts: ${user.$count?.posts}');

    final result = await prisma.$raw
        .query('SELECT * FROM "User" where id = \$1;', [user.id]);

    print('Raw Query result:');
    print(result);
    // print(json.encode(result));
  } finally {
    await prisma.$disconnect();
    exit(0);
  }
}
