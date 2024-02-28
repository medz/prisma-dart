import 'package:orm/orm.dart';
import 'package:test/test.dart';

import 'generated/client.dart';
import 'generated/prisma.dart';

void main() {
  late PrismaClient client;

  setUpAll(() async {
    client = PrismaClient(datasourceUrl: 'file:test/test.db');
    await client.$connect();

    // Clear database
    await client.post.deleteMany();
    await client.user.deleteMany();
  });

  tearDownAll(() async {
    await client.$disconnect();
  });

  test('findMany include list refer', () async {
    // Seed database
    await client.user.create(
      data: PrismaUnion.$2(
        UserUncheckedCreateInput(
          name: "Seven",
          posts: PostUncheckedCreateNestedManyWithoutAuthorInput(
            create: PrismaUnion.$2(
              PrismaUnion.$1([
                PostCreateWithoutAuthorInput(title: "First post"),
                PostCreateWithoutAuthorInput(title: "Second post"),
              ]),
            ),
          ),
        ),
      ),
    );

    final users = await client.user.findMany(
      include: UserInclude(posts: PrismaUnion.$1(true)),
    );

    expect(users.length, 1);
    expect(users.first.posts?.length, 2);
  });
}
