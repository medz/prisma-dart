import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:stream_channel/stream_channel.dart';
import 'package:json_rpc_2/json_rpc_2.dart' as json_rpc;

import 'types.dart';

/// An abstract interface class defining the structure for Generator implementations.
abstract interface class Generator {
  /// Runs the generator asynchronously.
  ///
  /// This method should be implemented to perform the main generation task.
  /// Returns a Future that completes when the generation process is finished.
  Future<void> run();

  /// Closes the generator and performs any necessary cleanup.
  ///
  /// This method should be implemented to release resources or perform
  /// final operations before the generator is disposed.
  /// Returns a Future that completes when the closing process is finished.
  Future<void> close();
}

/// Creates and returns a [Generator] instance.
///
/// This function sets up a JSON-RPC server for communication and configures
/// the generator with the provided parameters.
///
/// Parameters:
/// - [stream]: Optional input stream for receiving messages. Defaults to stdin if not provided.
/// - [sink]: Optional output sink for sending messages. Defaults to stdout if not provided.
/// - [getManifest]: Optional function to retrieve the manifest based on the provided config.
///
/// Returns a [Generator] instance ready to be run.
Generator createGenerator({
  Stream<String>? stream,
  StreamSink<String>? sink,
  FutureOr Function(Config config)? getManifest,
}) {
  final channel = StreamChannel<String>(
    stream?.transform(const LineSplitter()) ??
        stdin.transform(utf8.decoder).transform(const LineSplitter()),
    sink ?? _createStdoutSink(),
  );
  final server = json_rpc.Server(channel);

  server.registerMethod('getManifest', (json_rpc.Parameters params) async {
    if (getManifest == null) {
      return {'manifest': null};
    }

    final config = Config.fromJson({
      for (final MapEntry(:key, :value) in params.asMap.entries)
        key.toString(): value,
    });
    final manifest = await getManifest(config);

    return {'manifest': manifest?.toJson()};
  });

  return _Generator(server);
}

/// Create stdout sink for JSON-RPC 2.0 communication.
StreamSink<String> _createStdoutSink() {
  final controller = StreamController<String>();
  controller.stream.transform(const LineSplitter()).listen(stdout.writeln);

  return controller.sink;
}

class _Generator implements Generator {
  const _Generator(this.server);

  final json_rpc.Server server;

  @override
  Future<void> close() async {
    await server.close();
  }

  @override
  Future<void> run() async {
    await server.listen();
  }
}
