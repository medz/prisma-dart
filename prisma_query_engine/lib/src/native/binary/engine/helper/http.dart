
import 'package:http/http.dart';


Future<String> requestHttp(Client client ,String method,String url,String payload, void Function(Request req) apply ) async {
  final req = Request(method, Uri.parse(url));
  apply(req);

  final res = await client.send(req);
  final strRes = await res.stream.bytesToString();
  return strRes;
}