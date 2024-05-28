import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final updatedUser = await prisma.user.update(
      where: UserWhereUniqueInput(email: "seven@odroe.com"),
      data: PrismaUnion.$2(
        UserUncheckedUpdateInput(
          name: PrismaUnion.$1("Seven Odroe"),
        ),
      ),
    );
    // #endregion snippet

    print(updatedUser);
  });
}
