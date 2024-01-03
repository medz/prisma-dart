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
  } finally {
    await prisma.$disconnect();
    exit(0);
  }
}
