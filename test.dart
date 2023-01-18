import 'dart:convert';
import 'dart:io';

import 'package:orm/logger.dart';
import 'package:orm/binary_engine.dart';

final executable = 'node_modules/prisma/query-engine-darwin-arm64';
final schema = File('prisma/schema.prisma').readAsStringSync();

void main() async {
  final logger = Logger(stdout: Event.values);
  final engine = BinaryEngine(
    logger: logger,
    executable: executable,
    schema: base64.encode(utf8.encode(schema)),
    datasources: {
      'db': 'postgres://seven@localhost:5432/prisma-dart?schema=public',
    },
  );

  await engine.start();

  // Query many user
  final users = await engine.request(
    query: '''
query {
  findManyUser {
    id
    name
    createdAt
  }
}
''',
  );

  print(users);
  await engine.stop();
}
