import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final user = await prisma.post.findFirst(
      include: PostInclude(
        author: PrismaUnion.$1(true),
      ),
    );
    // #endregion snippet

    print(user);
  });
}
