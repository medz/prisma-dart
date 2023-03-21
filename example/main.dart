import 'dart:io';

import 'package:orm/logger.dart';

import 'prisma/prisma_client.dart';

/// Database URL
///
/// Note: The `prisma.sqlite` file will be created automatically if it
/// does not exist.
///
/// The Dart code only runs on the Dart VM, so we can use the `Platform.script`
/// to get the path to the current script.
///
/// See: https://api.dart.dev/stable/2.19.4/dart-io/Platform/script.html
final databaseUrl =
    Platform.script.resolve('prisma/prisma.sqlite').toFilePath();

final prisma = PrismaClient(
  // Output all events to stdout
  stdout: Event.values,

  // In real business, you should fill in the correct information, here is the demonstration information of the example.
  datasources: Datasources(db: 'file:$databaseUrl'),
);

void main() async {
  try {
    // Delete all users
    final deleted = await prisma.user.deleteMany();
    print('------------------ delete users ------------------');
    print('Deleted: ${deleted.count}');
    print('-------------------------------------------------');

    // Create a user
    final created = await prisma.user.create(
      data: UserCreateInput(id: 'seven', name: 'Seven(世伟) Du(杜)'),
    );
    print('------------------ create user ------------------');
    print(
        'User: ${created.id} - ${created.name}, Created At: ${created.createdAt}');
    print('------------------------------------------------');

    // Create many users
    // Note: The `createMany` method is not supported by SQLite
    //
    // final createdMany = await prisma.user.createMany(
    //  data: [
    //   UserCreateInput(id: 'user1', name: 'User 1'),
    //   UserCreateInput(id: 'user2', name: 'User 2'),
    //  ],
    // );
    // print('------------------ create many users ------------------');
    // print('Created: ${createdMany.count}');
    // print('-------------------------------------------------------');

    // Upsert a user
    final upserted = await prisma.user.upsert(
      where: UserWhereUniqueInput(id: 'seven'),
      create: UserCreateInput(id: 'seven', name: 'Odroe'),
      update: UserUpdateInput(
        name: StringFieldUpdateOperationsInput(set: 'Odroe'),
      ),
    );
    print('------------------ upsert user ------------------');
    print(
        'User: ${upserted.id} - ${upserted.name}, Created At: ${upserted.createdAt}');
    print('------------------------------------------------');

    User? user = await prisma.user.findFirst();
    if (user != null) {
      print('------------------ first user ------------------');
      print('User: ${user.id} - ${user.name}, Created At: ${user.createdAt}');
      print('------------------------------------------------');
    }

    final users = await prisma.user.findMany();
    print('------------------ all users ------------------');
    for (final user in users) {
      print('User: ${user.id} - ${user.name}, Created At: ${user.createdAt}');
    }
    print('-----------------------------------------------');
  } finally {
    await prisma.$disconnect();
  }
}
