import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:orm/dmmf.dart';
import 'package:orm/generator_helper.dart';
import 'package:orm/orm.dart';
import 'package:orm/src/configure/io/cli.dart';
import 'package:orm/version.dart';

import '../binary_engine/binary_engine.dart' as binary;
import '../binary_engine/binary_engine_platform.dart';
import '../binary_engine/binray_engine_type.dart';
import '../generator/generator.dart';
import '../generator/generator_options.dart';
import '../utils/ansi_progress.dart';

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
      defaultsTo: defaultSchemaPath,
    );
    argParser.addFlag(
      'data-proxy',
      help: 'Enable the Data Proxy in the Prisma Client',
      defaultsTo: development.PRISMA_GENERATE_DATAPROXY,
    );
    argParser.addMultiOption(
      'preview',
      help: 'Enable preview features',
      defaultsTo: const [],
      allowed: GeneratorPreviewFeatures.values.map((e) => e.name),
      allowedHelp: GeneratorPreviewFeatures.values
          .asMap()
          .map((key, value) => MapEntry(value.name, value.description)),
      splitCommas: true,
      valueHelp: 'flag',
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
    if (!await cliBinaryEngine.hasDownloaded) {
      await cliBinaryEngine.download(
          AnsiProgress.createFutureHandler('Download binray query engine'));
      await Future.delayed(Duration(microseconds: 500));
    }

    // Request config result.
    final ProcessResult configProcessResult = await cliBinaryEngine.run(
      ['cli', 'get-config'],
      environment: <String, String>{
        'PRISMA_DML': base64.encode(schema.readAsBytesSync()),
      },
    );

    // throw error
    if (configProcessResult.exitCode > 0) {
      final json = jsonDecode(configProcessResult.stderr);
      throw json['message'];
    }

    // Parse config result.
    final GetConfigResult configResult = GetConfigResult.fromJson(
      jsonDecode(configProcessResult.stdout as String) as Map<String, dynamic>,
    );

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

    final ProcessResult dmmfProcessResult = await cliBinaryEngine.run(
      ['--enable-raw-queries', 'cli', 'dmmf'],
      environment: <String, String>{
        'PRISMA_DML': base64.encode(schema.readAsBytesSync()),
      },
    );
    final Document dmmf = Document.fromJson(
      jsonDecode(dmmfProcessResult.stdout as String) as Map<String, dynamic>,
    );

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
      dataProxy: argResults?['data-proxy'],
      datasources: configResult.datasources,
      dmmf: dmmf,
      schema: await File(schemaPath).readAsString(),
      schemaPath: schemaPath,
      executable: executable,
      version: version,
      previewFeatures: GeneratorPreviewFeatures.fromNames(
        argResults!['preview'],
      ),
    );

    await generator(options);

    return 'Generation of "${generatorConfig.name}" succeeded';
  }
}
