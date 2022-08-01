import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:io/ansi.dart';
import 'package:orm/orm.dart';
import 'package:path/path.dart';

import '../logger_mixin.dart';
import 'init/orm_template.dart';
import 'init/schema_template.dart';

class InitCommand extends Command<int> with LoggerMixin {
  InitCommand() {
    argParser.addOption(
      'url',
      help: 'Define a custom datasource url',
    );
    argParser.addOption(
      'datasource-provider',
      help: 'Define the datasource provider',
      allowed: [
        'postgresql',
        'mysql',
        'sqlite',
        'sqlserver',
        'mongodb',
        'cockroachdb',
      ],
      defaultsTo: 'postgresql',
    );
  }

  @override
  String get description => 'Setup Prisma for you project';

  @override
  String get name => 'init';

  @override
  Future<int> run() async {
    final String schemaPath = getSchemaPath();
    final File schema = File(schemaPath);
    if (schema.existsSync()) {
      final String prefix =
          wrapWith(' ERROR ', [backgroundRed, white, styleBold])!;
      final String schemaPathStr =
          wrapWith(relative(schemaPath), [lightRed, styleBold])!;

      logger.write('$prefix $schemaPathStr ${red.wrap('already exists')}');
      logger.write('\n');
      logger
          .write('Please try again in a project that is not yet using Prisma.');

      return 1;
    }

    final Progress process = logger.progress('Initializing Prisma');

    await _createPrismaSchemaFile(schema);
    await _createConfigFile();

    process.finish(showTiming: true);
    logger.write('\n');
    logger.write(
        'Your Prisma schema was created at ${green.wrap(relative(schemaPath))}');

    return 0;
  }

  Future<void> _createPrismaSchemaFile(File schema) async {
    if (!schema.existsSync()) {
      schema.createSync(recursive: true);
    }

    await schema.writeAsString(schemaTemplate
        .replaceAll('{executableName}', executableName)
        .replaceAll(
            '{datasource-provider}', argResults!['datasource-provider']));
  }

  Future<void> _createConfigFile() async {
    final String url = argResults?['url'] ??
        'postgresql://dbuser:password@localhost:5432/dbname?schema=public';

    final File config = File(getConfigFilePath());
    if (!config.existsSync()) {
      config.createSync(recursive: true);
    }

    await config.writeAsString(ormTemplate.replaceAll('{url}', url));
  }

  @override
  EngineOptions get options => throw UnimplementedError();
}
