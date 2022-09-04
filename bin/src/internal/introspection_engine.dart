import 'json_rpc.dart';
import 'rpc_engine.dart';

class IntrospectionEngine extends RpcEngine {
  IntrospectionEngine({required super.engine});

  @override
  Future<List<String>> get arguments async => <String>[];

  /// Introspect database.
  Future<IntrospectResponse> introspect({
    required String schema,
    bool force = false,
    compositeTypeDepth = -1,
  }) async {
    final JsonRpcPayload payload = JsonRpcPayload(
      id: id.next(),
      method: 'introspect',
      params: <Map<String, dynamic>>[
        <String, dynamic>{
          'schema': schema,
          'force': force,
          'compositeTypeDepth': compositeTypeDepth,
        }
      ],
    );

    return command(payload: payload, parser: IntrospectResponse.fromJson);
  }
}
