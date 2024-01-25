import 'package:orm/orm.dart';
import 'package:test/test.dart';

import 'generated/client.dart';
import 'generated/prisma.dart';

void main() {
  late PrismaClient client;

  setUpAll(() async {
    client = PrismaClient(datasourceUrl: 'file:test/test.db');
    await client.$connect();

    // Clear database
    await client.user.deleteMany();
  });

  tearDownAll(() async {
    await client.$disconnect();
  });

  test('Encoding', () async {
    final chars = [
      "中文",
      '😊',
      'にちほん',
      '한국어',
      'اَلْعَرَبِيَّةُ',
      'عربي/عربى',
      'خصوصي',
    ];
    for (final char in chars) {
      final user = await client.user.create(
        data: PrismaUnion.$2(UserUncheckedCreateInput(name: char)),
      );

      expect(user.name, char);

      final found = await client.user.findUniqueOrThrow(
        where: UserWhereUniqueInput(id: user.id),
        select: UserSelect(name: true),
      );
      expect(found.name, char);
    }
  });
}
