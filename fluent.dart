class PrismaClient {
  late final user = UserModelDelegate(this);
}

abstract class ModelDelegate {
  const ModelDelegate(this.client);

  final PrismaClient client;
}

class UserModelDelegate extends ModelDelegate {
  UserModelDelegate(super.client);

  late final findUnique = FindUniqueAction(this);
}

class FindUniqueAction<Delegate extends ModelDelegate> {
  const FindUniqueAction(this.delegate);

  final Delegate delegate;
}

main() {
  // final prisma = PrismaClient();

  // // Unsafe JSON params query
  // final user = prisma.user.findUnique.fromJson({
  //   'where': {'id': 1},
  // });

  // // Type-safe inputs query
  // final user = prisma.user.findUnique(
  //   where: UserWhereUniqueInput(id: $1(1)),
  // );

  // // Type-safe fluent query
  // final user = prisma.user.findUnique
  //     .where((where) => where.id(1))
  //     .select((user) => [user.id, user.name]);

  // // Default serialized User
  // final defaultUser = await user; // User class

  // // Custom serialize
  // final customUser = user.serialize(CustomUserResul.fromJson);
}
