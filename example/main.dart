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

    final users = await prisma.$raw.query('SELECT * FROM "User"');
    print('\n');
    print('Raw Query users:');
    print(users);

    final posts = await prisma.$raw
        .query('SELECT * FROM "Post" WHERE "userId" = \$1', [user.id]);
    print('\n');
    print('Raw Query posts');
    print(posts);
  } catch (_) {
    rethrow;
  } finally {
    await prisma.$disconnect();
  }
}
