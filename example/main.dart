import 'dart:typed_data';

import 'package:orm/engines/binary.dart';
import 'package:orm/orm.dart';

import '../prisma/dart/client.dart';
import '../prisma/dart/types.dart';

void main() async {
  final engine = BinaryEngine(
    datasource: 'db',
    schema: schema,
    binary: 'prisma/dart/prisma-query-engine',
    url: Uri.parse('postgresql://seven@localhost:5432/prisma-dart'),
  );
  final prisma = PrismaClient(engine: engine);

  await prisma.$transaction((prisma) async {
    // Delete all users and posts.
    await prisma.post.deleteMany();
    await prisma.user.deleteMany();

    await prisma.user.create(
      data: PrismaUnion.$2(
        UserUncheckedCreateInput(
          name: 'Seven',
          price: Decimal.fromInt(1),
          size: BigInt.zero,
          bytes: Uint8List(0),
          count: 1,
          posts: PostUncheckedCreateNestedManyWithoutAuthorInput(
            create: PrismaUnion.$2(
              PrismaUnion.$1([
                PostCreateWithoutAuthorInput(title: 'Post 1'),
                PostCreateWithoutAuthorInput(title: 'Post 2'),
              ]),
            ),
          ),
        ),
      ),
    );
  });

  final users = await prisma.user
      .findMany(select: UserSelect(id: true, name: true, $count: true));
  final post = await prisma.post.findFirstOrThrow(
    include: PostInclude(author: true),
  );

  print(users);
  print(post.author);

  await prisma.$disconnect();
}
