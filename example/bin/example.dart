import 'package:example/example.dart';

/// Create a new User and a new Post record in the same query
Future<User> createUserAndPostExample(
  PrismaClient prisma, {
  required String username,
  required String title,
  required String content,
}) {
  return prisma.user.create(
    data: PrismaUnion.zero(
      UserCreateInput(
        name: username,
        posts: PostCreateNestedManyWithoutAuthorInput(
          create: [
            PostCreateWithoutAuthorInput(
              title: title,
              content: content,
              published: true,
            ),
          ],
        ),
      ),
    ),
  );
}

void main(List<String> args) async {
  final prisma = PrismaClient();

  final User? user = await prisma.user.findUnique(
    where: UserWhereUniqueInput(id: 1),
  );

  print(user?.toJson());

  await prisma.$disconnect();
}
