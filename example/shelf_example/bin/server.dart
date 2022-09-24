import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'src/prisma_client.dart';

/// Create prisma client.
final PrismaClient prisma = PrismaClient();

/// Find all users.
Future<Response> _allUsers(Request request) async {
  final List<User> users = await prisma.user.findMany(
    orderBy: [
      UserOrderByWithRelationInput(
        createdAt: SortOrder.desc,
      ),
    ],
    take: request.url.queryParameters['take'] != null
        ? int.parse(request.url.queryParameters['take']!)
        : 10,
    skip: request.url.queryParameters['skip'] != null
        ? int.parse(request.url.queryParameters['skip']!)
        : 0,
  );

  return Response.ok(
    jsonEncode(
      users.map((User user) => user.toJson()).toList(),
    ),
    headers: {
      'Content-Type': 'application/json',
    },
  );
}

/// Find user by id.
Future<Response> _userById(Request request, String id) async {
  final User? user = await prisma.user.findUnique(
    where: UserWhereUniqueInput(id: id),
  );

  if (user == null) {
    return Response.notFound(
      'User with id ${request.params['id']} not found',
    );
  }

  return Response.ok(
    jsonEncode(user.toJson()),
    headers: {
      'Content-Type': 'application/json',
    },
  );
}

/// Create a new user
Future<Response> _createUser(Request request) async {
  final Map<String, dynamic> body = await request.readAsString().then(
        (String body) => body.isNotEmpty ? jsonDecode(body) : {},
      );

  if (body['name'] == null || body['name'].toString().isEmpty) {
    return Response.badRequest(
      body: 'Name is required',
    );
  }

  final User user = await prisma.user.create(
    data: UserCreateInput(
      name: body['name'] as String,
    ),
  );

  return Response.ok(
    jsonEncode(user.toJson()),
    headers: {
      'Content-Type': 'application/json',
    },
  );
}

// Configure routes.
final _router = Router()
  ..get('/', _allUsers)
  ..post('/', _createUser)
  ..get('/<id>', _userById);

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
