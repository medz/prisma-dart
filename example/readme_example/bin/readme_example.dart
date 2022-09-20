import 'package:orm/orm.dart';
import 'package:readme_example/readme_example.dart';

void main() async {
  final PrismaClient prisma = PrismaClient();

  try {
    final String email = 'hello@odroe.com';
    final User upsertUser = await prisma.user.upsert(
      where: UserWhereUniqueInput(email: email),
      create: UserCreateInput(email: email),
      update: UserUpdateInput(
        name: NullableStringFieldUpdateOperationsInput(
          set$: PrismaUnion.one(prismaNull),
        ),
      ),
    );

    final List<User> nullableUsers = await prisma.user.findMany(
      where: UserWhereInput(
        name: StringNullableFilter(
          equals: PrismaUnion.one(prismaNull),
        ),
      ),
    );

    print('Update or create user: \n ${upsertUser.toJson()}');
    print('');
    print(
        'Find nullable users: \n ${nullableUsers.map((e) => e.toJson()).toList()}');
  } finally {
    await prisma.$disconnect();
  }
}