import 'dart:typed_data';

import 'package:orm/orm.dart';

import '../prisma/client/client.dart';
import '../prisma/client/prisma.dart';

main() async {
  final prisma = PrismaClient(
      datasourceUrl: "postgresql://seven@localhost:5432/prisma?schema=public");
  try {
    final byteList = List.filled(50, 1);
    await prisma.test.create(
      data: PrismaUnion.$1(TestCreateInput(
        bytes: Uint8List.fromList(byteList),
      )),
    );
  } finally {
    await prisma.$disconnect();
  }
}
