import '../prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final affectedRows = await prisma.user.deleteMany();
    // #endregion snippet

    print(affectedRows);
  });
}
