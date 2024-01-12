import '../prisma.dart';
import '../prisma/generated_dart_client/prisma.dart';

void main(List<String> args) {
  providePrisma((prisma) {
    // #region snippet
    final user = prisma.user.findUnique(
      where: UserWhereUniqueInput(id: "ckqj7q2qo0000q7tq6z6z6z6z"),
    );
    // #endregion snippet

    print({
      "user": user,
    });
  });
}
