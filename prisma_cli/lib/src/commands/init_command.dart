import 'dart:io';

import 'package:args/command_runner.dart';

import '../data_source/data_source_provider.dart';
import '../data_source/data_source_url.dart';
import '../utils/ansi_progress.dart';

class InitCommand extends Command<int> {
  InitCommand() {
    argParser.addOption(
      'url',
      help: 'Define a custom datasource url',
    );
    argParser.addOption(
      'datasource-provider',
      help: 'Define the datasource provider',
      allowed: DataSourceProvider.values.map((e) => e.name),
      defaultsTo: DataSourceProvider.postgresql.name,
    );
  }

  @override
  String get description => 'Setup Prisma for you project';

  @override
  String get name => 'init';

  @override
  Future<int> run() async {
    final File schema = File('prisma/schema.prisma');
    if (schema.existsSync()) {
      stderr.writeln(' ERROR ${schema.path} already exists');
      stderr.writeln(
          'Please try again in a project that is not yet using Prisma.');
      return 1;
    }

    final AnsiProgress process = AnsiProgress('Initializing Prisma...');
    _createPrismaSchemaFile(schema);
    _createDotEnvFile();
    process.cancel(
      overrideMessage: 'Initialization completed successfully.',
      showTime: true,
    );

    return 0;
  }

  /// Create dot env file.
  void _createDotEnvFile() {
    final File dotEnv = File('.env');
    if (!dotEnv.existsSync()) {
      dotEnv.createSync(recursive: true);
    }

    if (argResults?['url'] != null) {
      final DataSourceUrl dataSourceUrl =
          DataSourceUrl.lookup(argResults!['url']);
      dotEnv.writeAsStringSync('DATABASE_URL=${dataSourceUrl.url}');
      return;
    }

    dotEnv.writeAsStringSync('DATABASE_URL=${datasourceProvider.defaultUrl}');
  }

  /// Create the schema.prisma file.
  void _createPrismaSchemaFile(File schema) {
    // If schema file does not exist, create it.
    if (!schema.existsSync()) {
      schema.createSync(recursive: true);
    }

    // Schema template
    final String template = r'''
// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

generator client {
  provider = "prisma-dart-client"
}

datasource db {
  provider = "{datasource-provider}"
  url      = env("DATABASE_URL")
}
''';
    if (argResults?['url'] != null) {
      final DataSourceUrl dataSourceUrl =
          DataSourceUrl.lookup(argResults!['url']);

      return schema.writeAsStringSync(template.replaceAll(
        '{datasource-provider}',
        dataSourceUrl.provider.name,
      ));
    }

    schema.writeAsStringSync(template.replaceAll(
      '{datasource-provider}',
      datasourceProvider.name,
    ));
  }

  /// Get and validate the datasource provider.
  DataSourceProvider get datasourceProvider =>
      DataSourceProvider.lookup(argResults?['datasource-provider']);
}
