import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../json_rpc/json_rpc_payload.dart';
import '../json_rpc/schema_push.dart';

class MigrateEngine {
  MigrateEngine({
    required this.enginePath,
    required this.schemaPath,
    this.enabledPreviewFeatures,
  });

  /// Migrate engine binary path.
  final String enginePath;

  /// Schema File.
  final String schemaPath;

  /// Enabled preview features.
  final List<String>? enabledPreviewFeatures;

  /// Initialized future.
  Future<void>? _initialized;

  /// Cached process.
  Process? process;

  /// message id.
  int messageId = 0;

  /// Message listeners.
  final listeners = <int, void Function(Map<String, dynamic> json)>{};

  /// Initialize engine.
  Future<void> _initialize() async {
    if (_initialized != null) {
      return _initialized;
    }

    return _initialized = _initializeInternal();
  }

  /// Internal initialize engine.
  Future<void> _initializeInternal() async {
    final List<String> arguments = ['-d', schemaPath];

    // Add enabled preview features.
    if (enabledPreviewFeatures != null && enabledPreviewFeatures!.isNotEmpty) {
      arguments.add('--enabled-preview-features');
      arguments.add(enabledPreviewFeatures!.join(','));
    }

    process = await Process.start(enginePath, arguments);
    process?.stdout.listen(
      (List<int> data) {
        final Map<String, dynamic> json = jsonDecode(utf8.decode(data));
        final int id = json['id'];
        if (listeners.containsKey(id)) {
          listeners[id]?.call(json);
          listeners.remove(id);
        }
      },
      onDone: () => stop,
    );
  }

  /// Stop engine.
  void stop() {
    process?.kill();
    process = null;
    listeners.clear();
  }

  /// Run command.
  Future<T> _runCommand<T>({
    required JsonRpcPayload payload,
    required T Function(Map<String, dynamic> json) parser,
  }) async {
    await _initialize();

    if (process == null) {
      throw Exception('Process is null');
    }

    final Completer<T> completer = Completer<T>();
    listeners[payload.id] =
        (Map<String, dynamic> json) => completer.complete(parser(json));

    process?.stdin.add(payload.toJsonBytes());
    process?.stdin.add(utf8.encode('\n'));

    return completer.future;
  }

  /// schema push.
  Future<SchemaPushResponse> schemaPush(SchemaPushRequest args) {
    return _runCommand<SchemaPushResponse>(
      payload: JsonRpcPayload(
        id: messageId++,
        method: 'schemaPush',
        params: args,
      ),
      parser: (json) => SchemaPushResponse()..fromJson(json),
    );
  }
}
