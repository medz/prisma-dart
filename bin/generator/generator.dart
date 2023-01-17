import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:code_builder/code_builder.dart' as code;

import 'generator_options.dart';
import 'prisma_info.dart';

class Generator {
  final PrismaInfo info;
  final int generatorId;
  final GeneratorOptions options;
  final code.LibraryBuilder library;

  Generator._internal({
    required this.info,
    required this.generatorId,
    required this.options,
    required this.library,
  });

  static Future<Generator> create({
    required PrismaInfo info,
    required code.LibraryBuilder library,
  }) async {
    final buffer = StringBuffer();
    final completer = Completer<Generator>();

    final subscription = stdin.transform(convert.utf8.decoder).listen((event) {
      buffer.write(event);
      // Try to parse event to JSON.
      //
      // If it fails, add it to the buffer and wait for the next event.
      try {
        final result = convert.json.decode(buffer.toString());
        buffer.clear();

        if (result['method'] == 'getManifest') {
          _onManifest(result['id']);
        } else if (result['method'] == 'generate') {
          final options = GeneratorOptions.fromJson(result['params']);
          final generator = Generator._internal(
            info: info,
            generatorId: result['id'],
            options: options,
            library: library,
          );

          completer.complete(generator);
        }
      } catch (_) {
        // todo;
      }
    });

    final generator = await completer.future;
    await subscription.cancel();

    return generator;
  }

  static void _onManifest(int id) {
    final result = {
      'manifest': {
        "prettyName": "Prisma Dart Client",
        "defaultOutput": "../lib/prisma_client.dart",
        "requiresEngines": ["queryEngine"],
      }
    };
    final message = convert.json.encode({
      "jsonrpc": "2.0",
      'result': result,
      'id': id,
    });

    stderr.writeln(message);
  }

  Future<void> call() async {
    final message = convert.json.encode({
      "jsonrpc": "2.0",
      'result': null,
      'id': generatorId,
    });
    stderr.writeln(message);
  }
}
