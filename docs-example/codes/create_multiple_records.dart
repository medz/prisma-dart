import 'package:orm/orm.dart';

import '../prisma.dart';
import '../prisma/generated_dart_client/client.dart';
import '../prisma/generated_dart_client/prisma.dart';

createMultipleRecords(PrismaClient prisma) async {
  // #region snippet
  final affectedRows = await prisma.user.createMany(
    data: PrismaUnion.$2([
      UserCreateManyInput(
          name: PrismaUnion.$1("Bob1"), email: "bob@prisma.pub"),
      UserCreateManyInput(
          name: PrismaUnion.$1("Bob2"), email: "bob@prisma.pub"),
      UserCreateManyInput(
          name: PrismaUnion.$1("Yewande"), email: "yewande@prisma.pub"),
      UserCreateManyInput(
          name: PrismaUnion.$1("Ange"), email: "ange@prisma.pub"),
    ]),
    skipDuplicates: true, // Skip 'Bob2'
  );
  // #endregion snippet

  print({
    "count": affectedRows.count,
  });
}

void main(List<String> args) => providePrisma(createMultipleRecords);
