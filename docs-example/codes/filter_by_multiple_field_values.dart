import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/model.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final users = await prisma.user.findMany(
      where: UserWhereInput(
        OR: [
          UserWhereInput(
            name: PrismaUnion.$1(
              StringNullableFilter(startsWith: PrismaUnion.$1("S")),
            ),
          ),
          UserWhereInput(
            role: PrismaUnion.$2(Role.admin),
          ),
        ],
      ),
    );
    // #endregion snippet

    print(users);
  });
}
