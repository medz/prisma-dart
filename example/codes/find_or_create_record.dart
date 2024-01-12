import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/client.dart';
import '../prisma/generated_dart_client/model.dart';
import '../prisma/generated_dart_client/prisma.dart';

// #region extension
extension UserFindOrCreate on UserDelegate {
  ActionClient<User> findOrCreate({
    required UserWhereUniqueInput where,
    required UserCreateInput data,
    // ... More fields can be added here
  }) {
    return upsert(
      where: where,
      create: PrismaUnion.$1(data),
      // Create a empty update input, make sure the update input is not null
      update: PrismaUnion.$2(UserUncheckedUpdateInput()),
    );
  }
}
// #endregion extension

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final user = await prisma.user.findOrCreate(
      where: UserWhereUniqueInput(email: "seven@odroe.com"),
      data: UserCreateInput(
        email: "seven@odroe.com",
        name: PrismaUnion.$1("Seven Du"),
      ),
    );
    // #endregion snippet

    print(user);
  });
}
