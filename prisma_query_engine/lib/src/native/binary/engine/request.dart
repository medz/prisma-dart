import 'dart:convert';

import 'package:prisma_query_engine/src/shared/protocol.dart';

import 'helper/http.dart';
import '../binary.dart';
import './helper/json_map.dart';

const internalUpdateNotFoundMessage =
    "Error occurred during query execution: InterpretationError(\"Error for binding '0'\", Some(QueryGraphBuilderError(RecordNotFound(\"Record to update not found.\"))))";
const internalDeleteNotFoundMessage =
    "Error occurred during query execution: InterpretationError(\"Error for binding '0'\", Some(QueryGraphBuilderError(RecordNotFound(\"Record to delete does not exist.\"))))";


Future<GQLResponse> execute(
  BinaryEngine engine,
  GQLRequest payload,
) async {
  final body = await request(engine, "POST", "/", payload.toJson());
  final GQLResponse response = GQLResponse.fromJson(json.decode(body));
  if ((response.errors??[]).isNotEmpty) {
    final first = response.errors!.first;
    if (first.rawMessage() == internalUpdateNotFoundMessage ||
        first.rawMessage() == internalDeleteNotFoundMessage) {
      throw "Error : not found";
    }
    throw Exception("pgl error: ${first.rawMessage()}");
  }
  return response;
}

Future<GQLBatchResponse> batch(BinaryEngine engine, GQLBatchRequest payload) async {
  final body = await request(engine, "POST", "/", payload.toJson());
  return json.decode(body);
}

Future<String> request(
    BinaryEngine engine, String method, String path, JsonMap payload) async {
  if (engine.disconnected) {
    throw Exception("Engine is disconnected");
  }
  final requestBody = jsonEncode(payload);
  return await requestHttp(
      engine.client, method, "${engine.url}$path", requestBody, );
}
