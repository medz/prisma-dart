import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:orm/configure.dart';
import 'package:orm/dmmf.dart';
import 'package:orm/generator_helper.dart';
import 'package:orm/orm.dart';
import 'package:orm/version.dart';

import '../binary_engine/binary_engine.dart' as binary;
import '../binary_engine/binary_engine_platform.dart';
import '../binary_engine/binray_engine_type.dart';
import '../generator/generator.dart';
import '../generator/generator_options.dart';
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

    final binary.BinaryEngine cliBinaryEngine = binary.BinaryEngine(
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
      clientVersion: packageVersion,
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

    // Get dart client generators.
    final generators = configResult.generators
        .where((element) => element.provider.value == 'prisma-client-dart');

    // If generators is empty.
    if (generators.isEmpty) {
      final StringBuffer sb = StringBuffer();
      sb.writeln('Dart client generator is not set.');
      sb.writeln('Please set it in your ${schema.path}');
      sb.writeln();
      sb.writeln('generator client {');
      sb.writeln('    provider = "prisma-client-dart"');
      sb.writeln('}');

      throw Exception(sb);
    }

    // Get DMMF
    final Document dmmf = await engine.getDmmf();

    // Run all configured generator.
    for (final GeneratorConfig config in generators) {
      // Create genrator progress bar.
      final AnsiProgress progress = AnsiProgress('Generate ${config.name}...');

      // Run generator.
      final String message = await runGenerator(
        schemaPath: schema.path,
        dmmf: dmmf,
        generatorConfig: config,
        configResult: configResult,
        executable: cliBinaryEngine.executable,
        version: packageVersion,
      );

      // Cancel progress bar.
      progress.cancel(
        overrideMessage: message,
        showTime: true,
      );
      await Future.delayed(const Duration(microseconds: 500));
    }
  }

  /// Run generator
  Future<String> runGenerator({
    required String schemaPath,
    required Document dmmf,
    required GeneratorConfig generatorConfig,
    required GetConfigResult configResult,
    required String executable,
    required String version,
  }) async {
    // Create generator options
    final GeneratorOptions options = GeneratorOptions(
      config: generatorConfig,
      dataProxy: false,
      datasources: configResult.datasources,
      dmmf: dmmf,
      schema: await File(schemaPath).readAsString(),
      schemaPath: schemaPath,
      executable: executable,
      version: version,
    );

    await generator(options);

    return 'Generation of "${generatorConfig.name}" succeeded';
  }
}
