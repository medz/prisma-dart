import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../binary_engine/binary_engine.dart';
import 'auto_increment_id.dart';
import 'json_rpc.dart';
import 'rpc_events.dart';

abstract class RpcEngine {
  RpcEngine({required this.engine});

  /// The CLI binary engine.
  final BinaryEngine engine;

  /// Get process arguments.
  Future<List<String>> get arguments;

  /// Get RPC events.
  final RpcEvents _events = RpcEvents();

  /// Get auto increment message id.
  final AutoIncrementId id = AutoIncrementId();

  /// Cached process.
  Process? _process;

  /// Start the RPC engine.
  Future<Process> start() async => _process ??= await _createProcrss();

  /// Create process.
  Future<Process> _createProcrss() async {
    final Process process = await engine.start(await arguments);

    // Pipe stderr.
    process.stderr.pipe(stderr);

    // Listen stdout.
    process.stdout.listen(_stdoutHandler);

    return process;
  }

  /// Stdout handler.
  void _stdoutHandler(List<int> bytes) {
    final Map<String, dynamic> json = jsonDecode(utf8.decode(bytes));
    final int event = JsonRpcMessage.fromJson(json).id;

    _events.trigger(event, json);
  }

  /// Stop the RPC engine.
  void stop() {
    _process?.kill();
    _process = null;
    _events.clear();
  }

  /// Send RPC message.
  Future<void> _sendMessage(JsonRpcPayload payload) async {
    final String json = jsonEncode(payload.toJson());
    final Process process = await start();

    process.stdin.writeln(json);
  }

  /// Run RPC command.
  Future<T> command<T>({
    required JsonRpcPayload payload,
    required T Function(Map<String, dynamic>) parser,
  }) async {
    final Completer<T> completer = Completer<T>();

    try {
      /// Register message listener.
      _events.on(payload.id, (json) => completer.complete(parser(json)));

      /// Send message.
      await _sendMessage(payload);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }
}
