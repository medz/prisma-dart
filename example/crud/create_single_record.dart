import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/client.dart';
import '../prisma/generated_dart_client/prisma.dart';

/// Create a single record.
createSingleRecord(PrismaClient prisma) async {
  // #region snippet
  final user = await prisma.user.create(
    data: PrismaUnion.$1(UserCreateInput(
      email: "seven@odroe.com",
      name: PrismaUnion.$1("Seven Du"),
    )),
  );
  // #endregion snippet

  print({
    "id": user.id,
    "name": user.name,
    "email": user.email,
    "role": user.role,
  });
}

void main(List<String> args) => providePrisma(createSingleRecord);
