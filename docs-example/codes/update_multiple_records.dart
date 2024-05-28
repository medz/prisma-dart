import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/model.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final affectedRows = await prisma.user.updateMany(
      where: UserWhereInput(
        email: PrismaUnion.$1(
          StringFilter(endsWith: PrismaUnion.$1("@odroe.com")),
        ),
      ),
      data: PrismaUnion.$1(
        UserUpdateManyMutationInput(
          role: PrismaUnion.$1(Role.admin),
        ),
      ),
    );
    // #endregion snippet

    print(affectedRows);
  });
}
