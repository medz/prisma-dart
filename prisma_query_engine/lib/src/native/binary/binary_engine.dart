import 'dart:io';

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
  bool disconnected = false;
  BinaryEngine(this.schema);

  @override
  Future<void> start() async {
    final file = ensure(this);
    await spawn(this, file);
  }

  @override
  Future<void> stop() async {
    disconnected = true;
    client.close();
    await cmd.kill();
  }

  @override
  Future<GQLBatchResponse> batch(GQLBatchRequest payload) =>
      req.batch(this, payload);

  @override
  Future<GQLResponse> request(GQLRequest payload) => req.execute(this, payload);
}
