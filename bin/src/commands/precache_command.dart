import 'package:args/command_runner.dart';
import 'package:orm/version.dart';
import 'package:prisma_get_platform/prisma_get_platform.dart';

import '../binary_engine/binary_engine.dart';
import '../binary_engine/binary_engine_type.dart';
import '../utils/ansi_progress.dart';

class PrecacheCommand extends Command {
  @override
  String get description =>
      'Populate the Prisma engines cache of binary artifacts.';

  @override
  String get name => 'precache';

  PrecacheCommand() {
    argParser.addMultiOption(
      'type',
      abbr: 't',
      help: 'The engine type to precache.',
      valueHelp: 'engine',
      allowed: BinaryEngineType.values.map((e) => e.name),
      defaultsTo: BinaryEngineType.values.map((e) => e.name),
    );
  }

  Iterable<BinaryEngineType> get types {
    final List<String> types = argResults?['type'] as List<String>;
    if (types.isEmpty) return BinaryEngineType.values;

    return BinaryEngineType.values
        .where((element) => types.contains(element.name));
  }

  @override
  void run() async {
    for (final BinaryEngineType type in types) {
      final BinaryEngine binaryEngine = BinaryEngine(
        platform: getBinaryPlatform(),
        type: type,
        version: binaryVersion,
      );

      if (!await binaryEngine.hasDownloaded) {
        await binaryEngine.download(AnsiProgress.createFutureHandler(
            'Download Prisma ${type.name} engine'));
        await Future.delayed(Duration(microseconds: 100));
        continue;
      }

      print('Prisma ${type.name} engine is already downloaded.');
    }
  }
}
