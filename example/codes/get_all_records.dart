import '../prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final users = await prisma.user.findMany();
    // #endregion snippet

    print(users);
  });
}
