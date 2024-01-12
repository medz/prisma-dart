import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) => providePrisma((prisma) async {
      // #region relation-count
      final relationCount = await prisma.user.findMany(
        include: UserInclude(),
      );
      // #endregion relation-count
      print(relationCount);
    });
