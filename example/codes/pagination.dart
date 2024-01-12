import '../prisma.dart';

void main(List<String> args) => providePrisma((prisma) async {
      // #region 1
      final results = await prisma.user.findMany(
        take: 4,
        skip: 3,
      );
      // #endregion 1
      print(results);
    });
