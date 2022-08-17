import 'dart:io';
import 'dart:async';

import 'package:prisma_query_engine/src/native/binary/engine/life_cycle.dart';
import 'package:prisma_query_engine/src/shared/protocol.dart';

import '../../shared/shared.dart' as shared;
import 'engine/helper/command.dart';
import 'engine/request.dart' as req;

/// Binary engine.
class BinaryEngine implements shared.Engine {
  final HttpClient client = HttpClient();
  late Command cmd;
  late String url;
  final String schema;
  bool get disconnected => starting == null;
  Future<void>? starting;
  BinaryEngine(this.schema);

  @override
  Future<void> start() async {
    if (starting != null) return starting;
    final file = ensure(this);
    return starting = spawn(this, file);
  }

  @override
  Future<void> stop() async {
    starting = null;
    client.close();
    await cmd.kill();
  }

  @override
  Future<GQLBatchResponse> batch(GQLBatchRequest payload) async {
    await start();
    return req.batch(this, payload);
  }

  @override
  Future<GQLResponse> request(GQLRequest payload) async {
    await start();
    return req.execute(this, payload);
  }
}
