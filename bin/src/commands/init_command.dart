import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart';

import '../datasource.dart';
import '../utils/ansi_progress.dart';
import '../utils/find_project.dart';

class InitCommand extends Command {
  InitCommand() {
    argParser.addOption(
      'url',
      help: 'Define a custom datasource url',
    );
    argParser.addOption(
      'datasource-provider',
      help: 'Define the datasource provider',
      allowed: DatasourceProvider.values.map((e) => e.name),
      defaultsTo: DatasourceProvider.postgresql.name,
    );
  }

  @override
  String get description => 'Setup Prisma for you project';

  @override
  String get name => 'init';

  @override
  void run() {
    final File schema = findSchemaFile();
    final DatasourceProvider provider = resolveProvider();
    final Uri url = resolveUrl(provider);

    // Create ansi progress bar.
    final AnsiProgress process = AnsiProgress('Initializing Prisma...');

    // Create prisma schema file.
    createPrismaSchemaFile(schema, provider);

    // Create prisma config file.
    createPrismaConfigFile(url);

    // Cancel progress bar.
    process.cancel(
      overrideMessage: 'Initialization completed successfully.',
      showTime: true,
    );
  }

  /// Create prisma config file.
  void createPrismaConfigFile(Uri uri) {
    final File config = File(joinPaths(['.prismarc']));
    if (!config.existsSync()) {
      config.createSync(recursive: true);
    }

    config.writeAsStringSync('DATABASE_URL = ${uri.toString()}');
  }

  /// Create prisma schema file.
  void createPrismaSchemaFile(File schema, DatasourceProvider provider) {
    if (!schema.existsSync()) {
      schema.createSync(recursive: true);
    }

    final String template = r'''
// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

generator client {
  provider        = "prisma-client-dart"
  previewFeatures = ["interactiveTransactions"]
}

datasource db {
  provider = "{datasource-provider}"
  url      = env("DATABASE_URL")
}
'''
        .replaceAll('{datasource-provider}', provider.name);
    schema.writeAsStringSync(template);
  }

  /// Resolve URL.
  Uri resolveUrl(DatasourceProvider provider) {
    if (argResults?.wasParsed('url') == true) {
      final Uri uri = Uri.parse(argResults!['url']);
      if (uri.scheme.isEmpty || uri.isScheme('sqlite')) {
        return uri.replace(scheme: 'file');
      }

      return uri;
    }

    switch (provider) {
      case DatasourceProvider.postgresql:
        return Uri.parse(
            'postgres://postgres:postgres@localhost:5432/postgres?schema=public');
      case DatasourceProvider.mysql:
        return Uri.parse('mysql://root:root@localhost:3306/mysql');
      case DatasourceProvider.sqlite:
        return Uri.parse('file://./prisma/prisma.db');
      case DatasourceProvider.sqlserver:
        return Uri.parse('sqlserver://sa:sa@localhost:1433/sqlserver');
      case DatasourceProvider.mongodb:
        return Uri.parse('mongodb://localhost:27017/mongodb');
      case DatasourceProvider.cockroachdb:
        return Uri.parse('cockroachdb://localhost:26257/cockroachdb');
    }
  }

  /// Resolve the provider from the command line arguments.
  DatasourceProvider resolveProvider() {
    if (argResults?.wasParsed('url') == true) {
      return resolveProviderWithUrl();
    }

    return DatasourceProvider.lookup(argResults!['datasource-provider']);
  }

  /// Resolve provider with url.
  DatasourceProvider resolveProviderWithUrl() {
    final String url = argResults!['url'];
    final Uri uri = Uri.parse(url);

    // If schema is empty, then it is a file.
    if (uri.scheme.isEmpty) {
      return DatasourceProvider.sqlite;
    }

    return DatasourceProvider.lookup(uri.scheme);
  }

  /// Find prisma schema file.
  File findSchemaFile() {
    final File schema = File(joinPaths(['prisma', 'schema.prisma']));

    if (schema.existsSync()) {
      throw Exception('''
${relative(schema.path)} already exists.

Please try again in a project that is not yet using Prisma.''');
    }

    return schema;
  }
}
