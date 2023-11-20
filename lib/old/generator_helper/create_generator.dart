import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:stream_channel/stream_channel.dart';

import 'types.dart';

typedef Generator = ZoneCallback<Future<void>>;
typedef ManifestHandler = FutureOr<GeneratorManifest?> Function(
    GeneratorConfig config);
typedef GenerateHandler = FutureOr<dynamic> Function(GeneratorOptions options);

Generator createGenerator({
  ManifestHandler? onManifest,
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
  server.registerMethod('getManifest', (Parameters params) async {
    final config = GeneratorConfig.fromJson(params.asMap.cast());
    final manifest = await onManifest?.call(config);

    return {'manifest': manifest?.toJson()};
  });

  // Register a method called 'generate'.
  server.registerMethod('generate',
      (params) => onGenerate(GeneratorOptions.fromJson(params.asMap)));

  // Return a callback that runs the server.
  return server.listen;
}
