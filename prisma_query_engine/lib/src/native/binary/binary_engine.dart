import 'dart:io';
import 'package:prisma_query_engine/src/native/binary/engine/life_cycle.dart';

import '../../shared/shared.dart' as shared;
import 'engine/helper/command.dart';
import 'package:http/http.dart';
import 'engine/request.dart' as req;

/// Binary engine.
class BinaryEngine implements shared.Engine {
  final Client client;
  late Command cmd;
  late String url;
  final bool hasBinaryTargets;
  final String schema;
  bool disconnected = false;

  BinaryEngine(this.client, this.hasBinaryTargets, this.schema);

  @override
  Future<void> start() async {
    final file = File('prisma/engines/query-engine');
    if (!file.existsSync()) throw "no binary found";
    await spawn(this, file.path);
  }

  @override
  Future<void> stop() async {
    disconnected = true;
    await cmd.kill();
  }

  @override
  Future<Map<String, dynamic>> batch(Map<String, dynamic> payload) =>
      req.batch(this, payload);

  @override
  Future<Map<String, dynamic>> request(Map<String, dynamic> payload) =>
      req.execute(this, payload);
}
