import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../binary_engine/binary_engine.dart';
import 'json_rpc.dart';

class Migrate {
  Migrate({
    required this.engine,
    required this.schemaPath,
    this.enabledPreviewFeatures,
  });

  final BinaryEngine engine;
  final String schemaPath;
  final List<String>? enabledPreviewFeatures;

  Process? _process;
  int _messageId = 0;
  final Map<int, void Function(Map<String, dynamic> json)> _listeners =
      <int, void Function(Map<String, dynamic> json)>{};

  /// Start the migrate engine.
  Future<Process> _start() async {
    if (_process is Process) _process;

    final List<String> arguments = ['-d', schemaPath];

    // Add enabled preview features.
    if (enabledPreviewFeatures != null && enabledPreviewFeatures!.isNotEmpty) {
      arguments.add('--enabled-preview-features');
      arguments.add(enabledPreviewFeatures!.join(','));
    }

    _process = await engine.start(arguments);
    _process?.stderr.pipe(stderr);
    _process?.stdout.listen(_stdoutHandler, onDone: stop);

    return _process!;
  }

  /// Stop the migrate engine.
  void stop() {
    _process?.kill();
    _process = null;
    _listeners.clear();
  }

  /// Stdout handler.
  void _stdoutHandler(List<int> data) {
    final String jsonString = utf8.decode(data);
    final Map<String, dynamic> json = jsonDecode(jsonString);
    final JsonRpcMessage message = JsonRpcMessage.fromJson(json);

    if (_listeners.containsKey(message.id)) {
      final void Function(Map<String, dynamic> json)? handler =
          _listeners[message.id];
      handler?.call(json);
      _listeners.remove(message.id);
    }
  }

  /// Run command.
  Future<T> _command<T>({
    required JsonRpcPayload payload,
    required T Function(Map<String, dynamic> json) handler,
  }) async {
    final Process process = await _start();
    final Completer<T> completer = Completer<T>();

    // Register message listener.
    _listeners[payload.id] =
        (Map<String, dynamic> json) => completer.complete(handler(json));

    // Send message.
    final String json = jsonEncode(payload.toJson());
    process.stdin.add(utf8.encode(json));
    process.stdin.add(utf8.encode('\n'));

    return completer.future;
  }

  /// Schema push.
  Future<SchemaPushResponse> schemaPush({bool force = false}) {
    final SchemaPushRequest request = SchemaPushRequest(
      schema: File(schemaPath).readAsStringSync(),
      force: force,
    );
    final JsonRpcPayload payload = JsonRpcPayload(
      id: _messageId++,
      method: 'schemaPush',
      params: request.toJson(),
    );

    return _command(payload: payload, handler: SchemaPushResponse.fromJson);
  }
}
