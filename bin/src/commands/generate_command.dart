import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:orm/configure.dart';
import 'package:orm/dmmf.dart';
import 'package:orm/generator_helper.dart';
import 'package:orm/orm.dart';
import 'package:orm/version.dart';

import '../binary_engine/binary_engine.dart' as _binary;
import '../binary_engine/binary_engine_platform.dart';
import '../binary_engine/binray_engine_type.dart';
import '../utils/ansi_progress.dart';
import '../utils/find_project.dart';

class GenerateCommand extends Command {
  @override
  String get description => 'Generate artifacts';

  @override
  String get name => 'generate';

  GenerateCommand() {
    argParser.addOption(
      'schema',
      help: 'Custom path to your Prisma schema',
      valueHelp: 'path',
      defaultsTo:
          configure('schema', joinRelativePaths(['prisma', 'schema.prisma'])),
    );
  }

  @override
  Future<void> run() async {
    final File schema = File(argResults!['schema']);
    if (!schema.existsSync()) {
      return print('Missing schema file path.');
    }

    final _binary.BinaryEngine cliBinaryEngine = _binary.BinaryEngine(
      platform: BinaryEnginePlatform.current,
      type: BinaryEngineType.query,
      version: binaryVersion,
    );
    if (!cliBinaryEngine.hasDownloaded) {
      await cliBinaryEngine.download(
          AnsiProgress.createFutureHandler('Download binray query engine'));
      await Future.delayed(Duration(microseconds: 500));
    }

    // Create engine config.
    final EngineConfig config = EngineConfig(
      datamodelPath: schema.path,
      env: configure.environment,
      prismaPath: cliBinaryEngine.executable,
    );

    // Create query engine.
    final BinaryEngine engine = BinaryEngine(config);

    // Get config result.
    final GetConfigResult configResult = await engine.getConfig();

    // Print warnings.
    if (configResult.warnings?.isNotEmpty == true) {
      for (final warning in configResult.warnings!) {
        print(warning);
      }
    }

    // Get DMMF.
    final Document dmmf = await engine.getDmmf();

    for (final GeneratorConfig config in configResult.generators) {
      if (config.provider.value == 'prisma-client-dart') {
        // await generatePrismaClientDart(config, dmmf);
      }
    }
  }
}
