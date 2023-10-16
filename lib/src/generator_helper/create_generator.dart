import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:stream_channel/stream_channel.dart';

typedef Generator = ZoneCallback<Future<void>>;
typedef ManifestHandler = FutureOr<dynamic> Function(dynamic config);
typedef GenerateHandler = FutureOr<void> Function(dynamic options);

Generator createGenerator({
  required ManifestHandler onManifest,
  required GenerateHandler onGenerate,
}) {
  // Create a JSON-RPC server that listens on stdin, splits input into lines,
  final input = stdin.transform(utf8.decoder).transform(const LineSplitter());

  // Create a output stream that writes.
  final controller = StreamController<String>();

  // Listen for output from the server and write it to stderr.
  controller.stream.listen(stderr.writeln);

  final channel = StreamChannel<String>(input, controller.sink);
  final server = Server(channel);

  // Register a method called 'getManifest'.
  server.registerMethod('getManifest', _createManifestHandler(onManifest));

  return server.listen;
}

/// Create a handler for the 'getManifest' method.
Function _createManifestHandler(ManifestHandler onManifest) =>
    (Parameters params) {
      print(params.value);
    };
