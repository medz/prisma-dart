import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:stream_channel/stream_channel.dart';

import 'config.dart';
import 'manifest.dart';
import 'options.dart';

class Generator {
  final Server server;

  const Generator(this.server);

  factory Generator.channel(
      {required Stream<String> input, required StreamSink<String> output}) {
    return Generator(Server(StreamChannel<String>(input, output)));
  }

  factory Generator.stdio({
    required Stdin stdin,
    required Stdout stdout,
  }) {
    final input = stdin.transform(utf8.decoder).transform(const LineSplitter());

    final controller = StreamController<String>();
    controller.stream.listen(stdout.writeln);

    return Generator.channel(input: input, output: controller.sink);
  }

  void onManifest(
    FutureOr<GeneratorManifest?> Function(GeneratorConfig config) handler,
  ) {
    server.registerMethod('getManifest', (Parameters params) async {
      final config = GeneratorConfig.fromJson(params.asMap.cast());
      final manifest = await handler(config);

      return {'manifest': manifest?.toJson()};
    });
  }

  void onGenerate<T>(
    FutureOr<T> Function(GeneratorOptions options) handler,
  ) {
    server.registerMethod('generate', (Parameters params) async {
      final options = GeneratorOptions.fromJson(params.asMap);
      final result = await handler(options);

      return result;
    });
  }

  Future listen() => server.listen();
  Future close() => server.close();
}
