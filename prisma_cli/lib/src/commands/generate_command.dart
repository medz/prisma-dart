import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart';
import 'package:prisma_cli/src/generator/messages/get_config_response.dart';

import '../configure.dart';
import '../dmmf/dmmf.dart';
import '../engine_downloader/binary_engine_downloader.dart';
import '../engine_downloader/binary_engine_platform.dart';
import '../engine_downloader/binary_engine_type.dart';
import '../generator/generator.dart';
import '../json_rpc/json_rpc_response_error.dart';
import '../utils/ansi_progress.dart';
import '../version.dart';

class GenerateCommand extends Command<int> {
  GenerateCommand() {
    argParser.addOption(
      'schema',
      help: 'Custom path to your Prisma schema',
      valueHelp: 'path',
      defaultsTo: 'prisma/schema.prisma',
    );
    // argParser.addFlag(
    //   'watch',
    //   help: 'Watch the Prisma schema and rerun after a change',
    //   defaultsTo: false,
    // );
  }

  @override
  String get description => 'Generate artifacts';

  @override
  String get name => 'generate';

  /// Schema file.
  File get schema => File(argResults?['schema']);

  /// Run handler for the generate command.
  @override
  Future<int> run() async {
    // If schema file does not exist, exit.
    if (!schema.existsSync()) {
      stderr.writeln('Missing schema file path.');
      return 1;
    }

    // Create query engine binary file.
    final File queryEngineBinary =
        File('prisma/engines/${BinaryEngineType.query.value}');

    // If query engine binary file does not exist, download it.
    if (!queryEngineBinary.existsSync()) {
      final BinaryEngineDownloader downloader = BinaryEngineDownloader(
        binaryPath: queryEngineBinary.path,
        engineType: BinaryEngineType.query,
        platform: BinaryEnginePlatform.current,
        version: engineVersion,
      );

      await downloader.download(_onDownload);
    }

    final AnsiProgress progress = AnsiProgress('Generating...');

    // Run query engine binary, request config.
    final ProcessResult configResult = await Process.run(
      queryEngineBinary.path,
      ['--datamodel-path', schema.path, 'cli', 'get-config'],
      environment: configure.environment,
    );

    // If exit code is not 0, exit.
    if (configResult.exitCode != 0) {
      final JsonRpcResponseError error = JsonRpcResponseError()
        ..fromJson(json.decode(configResult.stderr));
      stderr.writeln(error.message);
      return 1;
    }

    final GetConfigResponse config = GetConfigResponse.fromJson(
      json.decode(configResult.stdout),
    );
    final bool dartClientGeneratorHasSet = config.generators
        .where((element) => element.provider.value == 'prisma-dart-client')
        .isNotEmpty;
    if (!dartClientGeneratorHasSet) {
      stderr.writeln('Dart client generator is not set.');
      stderr.writeln('Please set it in your ${relative(schema.path)} \n');
      stderr.writeln('''
generator client {
  provider = "prisma-dart-client"
}
''');
      return 1;
    }

    // Request dmmf.
    final ProcessResult dmmfResult = await Process.run(
      queryEngineBinary.path,
      ['--datamodel-path', schema.path, 'cli', 'dmmf'],
      environment: configure.environment,
    );

    // If exit code is not 0, exit.
    if (dmmfResult.exitCode != 0) {
      final JsonRpcResponseError error = JsonRpcResponseError()
        ..fromJson(json.decode(dmmfResult.stderr));
      stderr.writeln(error.message);
      return 1;
    }

    File('dmmf.json').writeAsStringSync(dmmfResult.stdout);

    final DMMF dmmf = DMMF.fromJson(json.decode(dmmfResult.stdout));
    final Generator genertaor = Generator(dmmf);
    final String code = genertaor.generate();

    File('lib/src/prisma_generated.dart').writeAsStringSync(code);

    // Run build_runner build
    Process.runSync(Platform.resolvedExecutable, [
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ]);
    progress.cancel(showTime: true);

    return 0;
  }

  // Called when download is started.
  void _onDownload(Future<void> done) async {
    final AnsiProgress progress =
        AnsiProgress('Downloading ${BinaryEngineType.query.value}...');

    // Await download done.
    await done;

    // Cancel progress.
    progress.cancel(
      showTime: true,
      overrideMessage: '${BinaryEngineType.query.value} downloaded.',
    );
  }
}
