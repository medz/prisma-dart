import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:prisma_cli/prisma_cli.dart';

import '../dmmf/dmmf.dart';
import '../logger.dart';

class GenerateCommand extends Command<int> {
  GenerateCommand() {
    argParser.addOption(
      'schema',
      help: 'Custom path to your Prisma schema',
      valueHelp: 'path',
    );
    argParser.addFlag(
      'watch',
      help: 'Watch the Prisma schema and rerun after a change',
      defaultsTo: false,
    );
  }

  @override
  String get description => 'Generate artifacts';

  @override
  String get name => 'generate';

  /// Run handler for the generate command.
  @override
  Future<int> run() async {
    final EngineOptions options = EngineOptions(
      version: engineVersion,
      platform: EnginePlatform.darwin,
      binary: BinaryType.queryEngine,
    );
    final BinaryEngine engine = BinaryEngine(
      options,
      onDownloadEvent: createOnDownloadProgress(options),
    );

    final ProcessResult result =
        await engine.run(['--datamodel-path', getSchemaPath(), 'cli', 'dmmf']);

    final DMMF dmmf = DMMF.fromJson(json.decode(result.stdout));

    print(dmmf.mappings.modelOperations);

    return 0;
  }
}
