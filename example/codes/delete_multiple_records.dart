import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final affectedRows = await prisma.user.deleteMany(
      where: UserWhereInput(
        email: PrismaUnion.$1(
          StringFilter(
            endsWith: PrismaUnion.$1('@odroe.com'),
          ),
        ),
      ),
    );
    // #endregion snippet

    print(affectedRows);
  });
}
