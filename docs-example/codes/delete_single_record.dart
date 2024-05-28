import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) async {
    // #region snippet
    final deletedUser = await prisma.user.delete(
      where: UserWhereUniqueInput(
        email: "bob@prusma.pub",
      ),
    );
    // #endregion snippet

    print(deletedUser);
  });
}
