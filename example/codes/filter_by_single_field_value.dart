import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final users = await prisma.user.findMany(
      where: UserWhereInput(
        email: PrismaUnion.$1(
          StringFilter(endsWith: PrismaUnion.$1('@odroe.com')),
        ),
      ),
    );
    // #endregion snippet

    print(users);

    // #region 1
    await prisma.user.findMany(
      where: UserWhereInput(
        email: PrismaUnion.$1(
          StringFilter(endsWith: PrismaUnion.$1('@odroe.com')),
        ),
      ),
    );
    // #endregion 1
  });
}
