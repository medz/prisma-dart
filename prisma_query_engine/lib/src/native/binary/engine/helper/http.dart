import 'dart:convert';
import 'dart:io';

Future<String> requestHttp(
    HttpClient client, String method, String url, String payload) async {
  final request = await HttpClient().openUrl(method, Uri.parse(url));
  request.headers.contentLength = payload.length;
  request.headers.contentType = ContentType.json;
  request.write(payload);
  final res = await request.close();
  final body = await res.transform(const Utf8Decoder()).join();
  if (res.statusCode != 200) {
    throw "error at requestHttp: statusCode=${res.statusCode} body=$body";
  }
  return body;
}
