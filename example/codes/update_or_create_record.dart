import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final user = await prisma.user.upsert(
      where: UserWhereUniqueInput(email: "medz@prisma.pub"),
      create: PrismaUnion.$1(UserCreateInput(
        email: "medz@prisma.pub",
        name: PrismaUnion.$1("Seven at GitHub username"),
      )),
      update: PrismaUnion.$1(
        UserUpdateInput(
          name: PrismaUnion.$1("Seven at GitHub username"),
        ),
      ),
    );
    // #endregion snippet

    print(user);
  });
}
