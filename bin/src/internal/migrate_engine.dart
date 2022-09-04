import 'dart:async';
import 'dart:io';

import 'json_rpc.dart';
import 'rpc_engine.dart';

class MigrateEngine extends RpcEngine {
  MigrateEngine({
    required super.engine,
    required this.schemaPath,
  });

  /// Prisma schema path.
  final String schemaPath;

  @override
  Future<List<String>> get arguments async =>
      <String>['--datamodel', schemaPath];

  /// Push schema to database.
  Future<SchemaPushResponse> schemaPush({bool force = false}) {
    final SchemaPushRequest request = SchemaPushRequest(
      schema: File(schemaPath).readAsStringSync(),
      force: force,
    );
    final JsonRpcPayload payload = JsonRpcPayload(
      id: id.next(),
      method: 'schemaPush',
      params: request.toJson(),
    );

    return command(payload: payload, parser: SchemaPushResponse.fromJson);
  }
}
