import 'package:spry/spry.dart';
import 'package:spry_json/spry_json.dart';
import 'package:spry_router/spry_router.dart';

import 'prisma_client.dart';
import 'prisma_inject.dart';

void getAllUsers(Context context) async {
  final PrismaClient prisma = context.prisma;
  final Response response = context.response;

  final Iterable<User> users = await prisma.user.findMany();
  final result = users.map((user) => user.toJson()).toList();
  response.json(result);
}

void createUser(Context context) async {
  final PrismaClient prisma = context.prisma;
  final Request request = context.request;
  final Response response = context.response;

  final Map<String, dynamic> body = await request.json;
  final String name = body['name'] as String;

  final User? exists = await prisma.user.findFirst(
    where: UserWhereInput(
      name: StringFilter(equals: name),
    ),
  );

  if (exists != null) {
    throw HttpException.conflict('User already exists');
  }

  final User user = await prisma.user.create(
    data: UserCreateInput(name: body['name']),
  );

  response
    ..status(201)
    ..json(user);
}

void getUser(Context context) async {
  final PrismaClient prisma = context.prisma;
  final Request request = context.request;
  final Response response = context.response;

  final int id = int.parse(request.param('id') as String);
  final User user = await prisma.user.findUniqueOrThrow(
    where: UserWhereUniqueInput(id: id),
  );

  response.json(user.toJson());
}

void updateUser(Context context) async {
  final PrismaClient prisma = context.prisma;
  final Request request = context.request;
  final Response response = context.response;

  final int id = int.parse(request.param('id') as String);
  final Map<String, dynamic> body = await request.json;
  final User? user = await prisma.user.update(
    where: UserWhereUniqueInput(id: id),
    data: UserUpdateInput(
      name: StringFieldUpdateOperationsInput(
        set: body['name'] as String,
      ),
    ),
  );

  if (user == null) {
    throw HttpException.notFound('User not found');
  }

  response.json(user.toJson());
}

void deleteUser(Context context) async {
  final PrismaClient prisma = context.prisma;
  final Request request = context.request;
  final Response response = context.response;

  final int id = int.parse(request.param('id') as String);
  await prisma.user.delete(
    where: UserWhereUniqueInput(id: id),
  );

  response.status(204);
}
