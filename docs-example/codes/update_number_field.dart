import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final affectedRows = await prisma.post.updateMany(
      data: PrismaUnion.$1(
        PostUpdateManyMutationInput(
          views: PrismaUnion.$2(
            IntFieldUpdateOperationsInput(increment: 1),
          ),
          likes: PrismaUnion.$2(
            IntFieldUpdateOperationsInput(increment: 1),
          ),
        ),
      ),
    );
    // #endregion snippet

    print(affectedRows);
  });
}
