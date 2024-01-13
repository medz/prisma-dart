import 'package:orm/orm.dart';

import 'prisma/generated_dart_client/client.dart';
import 'prisma/generated_dart_client/prisma.dart';

void main(List<String> args) async {
  final prisma = PrismaClient();
  try {
    // #region interactive
    /// Transfer views from one post to another
    transfer(int from, int to, int views) async {
      await prisma.$transaction((tx) async {
        // 1. Decrement views from the source post
        await tx.post.update(
          where: PostWhereUniqueInput(id: from),
          data: PrismaUnion.$1(
            PostUpdateInput(
              views: PrismaUnion.$2(
                IntFieldUpdateOperationsInput(decrement: views),
              ),
            ),
          ),
        );

        // 2. Increment views from the destination post
        await tx.post.update(
          where: PostWhereUniqueInput(id: to),
          data: PrismaUnion.$1(
            PostUpdateInput(
              views: PrismaUnion.$2(
                IntFieldUpdateOperationsInput(increment: views),
              ),
            ),
          ),
        );
      });
    }

    await transfer(1, 2, 10); // Transfer 10 views from post 1 to post 2
    await transfer(2, 1, 10); // Transfer 10 views from post 2 to post 1
    // #endregion interactive

    // #region catch
    try {
      await prisma.$transaction((tx) async {
        // Code running in a transaction...
      });
    } catch (e) {
      // Handle the rollback...
    }
    // #endregion catch

    // #region isolation
    await prisma.$transaction(
      isolationLevel: TransactionIsolationLevel.serializable, // [!code focus]
      (tx) async {
        // Code running in a transaction...
      },
    );
    // #endregion isolation

    // #region timeout
    await prisma.$transaction(
      (tx) async {
        // Code running in a transaction...
      },
      maxWait: 5000, // Default is 2000 // [!code focus]
      timeout: 10000, // Default is 5000 // [!code focus]
    );
    // #endregion timeout

    // #region manual
    final tx = await prisma.$transaction.start(); // [!code focus]
    try {
      // Delete all posts
      await tx.post.deleteMany();
      // Delete all users
      await tx.user.deleteMany();

      // Commit the transaction
      await tx.$transaction.commit(); // [!code focus]
    } catch (e) {
      // Rollback the transaction
      await tx.$transaction.rollback(); // [!code focus]
    }
    // #endregion manual
  } finally {
    await prisma.$disconnect();
  }
}
