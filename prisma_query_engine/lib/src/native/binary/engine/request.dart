import 'dart:convert';

import 'helper/http.dart';
import './protocol.dart';
import '../binary.dart';
import './helper/json_map.dart';

const internalUpdateNotFoundMessage =
    "Error occurred during query execution: InterpretationError(\"Error for binding '0'\", Some(QueryGraphBuilderError(RecordNotFound(\"Record to update not found.\"))))";
const internalDeleteNotFoundMessage =
    "Error occurred during query execution: InterpretationError(\"Error for binding '0'\", Some(QueryGraphBuilderError(RecordNotFound(\"Record to delete does not exist.\"))))";


Future<JsonMap> execute(
  BinaryEngine engine,
  JsonMap payload,
) async {
  final body = await request(engine, "POST", "/", payload);
  final GQLResponse response = GQLResponse.fromJson(json.decode(body));
  if (response.errors.isNotEmpty) {
    final first = response.errors.first;
    if (first.rawMessage() == internalUpdateNotFoundMessage ||
        first.rawMessage() == internalDeleteNotFoundMessage) {
      throw "Error : not found";
    }
    throw Exception("pgl error: ${first.rawMessage()}");
  }
  return json.decode(body);
}

Future<JsonMap> batch(BinaryEngine engine, JsonMap payload) async {
  final body = await request(engine, "POST", "/", payload);
  return json.decode(body);
}

Future<String> request(
    BinaryEngine engine, String method, String path, JsonMap payload) async {
  if (engine.disconnected) {
    throw Exception("Engine is disconnected");
  }
  final requestBody = jsonEncode(payload);
  return await requestHttp(
      engine.client, method, "${engine.url}$path", requestBody, (req) {
    req.headers["content-type"] = "application/json";
  });
}
