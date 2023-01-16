import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:orm/version.dart';
import 'package:prisma_get_platform/prisma_get_platform.dart';

import '../../../binary_engine/binary_engine.dart';
import '../../../binary_engine/binary_engine_type.dart';
import '../../../internal/introspection_engine.dart';
import '../../../internal/json_rpc.dart';
import '../../../utils/ansi_progress.dart';
import '../../../utils/finder.dart';

class DbPullSubCommand extends Command<void> {
  @override
  String get description =>
      r'Pull the state from the database to the Prisma schema using introspection';

  @override
  String get name => r'pull';

  DbPullSubCommand() {
    argParser.addFlag('force', help: r'Ignore current Prisma schema file');
    argParser.addFlag('print',
        help: r'Print the introspected Prisma schema to stdout');
    argParser.addOption(
      'schema',
      help: 'Custom path to your Prisma schema',
      valueHelp: 'path',
      defaultsTo: findPrismaSchemaFile().path,
    );
    argParser.addOption(
      'composite-type-depth',
      help:
          'Specify the depth for introspecting composite types (e.g. Embedded Documents in MongoDB) Number, default is -1 for infinite depth, 0 = off',
      defaultsTo: '-1',
    );
  }

  /// Get schema file.
  File? get schema {
    final File schema = File(argResults!['schema']);
    if (schema.existsSync() == false) {
      return null;
    }

    return schema;
  }

  // Get composite type depth.
  int get compositeTypeDepth =>
      int.tryParse(argResults?['composite-type-depth'] ?? '-1') ?? -1;

  // Get force flag.
  bool get force => argResults?['force'] ?? false;

  // Get print flag.
  bool get $print => argResults?['print'] ?? false;

  @override
  Future<void> run() async {
    // Validate schema file.
    if (schema == null) {
      return print('Missing schema file path.');
    }

    // Print loaded schema message.
    print('Prisma schema loaded from ${schema?.path}');

    // Create binary engine.
    final BinaryEngine engine = BinaryEngine(
      platform: getBinaryPlatform(),
      type: BinaryEngineType.introspection,
      version: binaryVersion,
    );

    // Download binary engine.
    if (!await engine.hasDownloaded) {
      await engine.download(
          AnsiProgress.createFutureHandler('Download introspection engine'));
      await Future.delayed(Duration(microseconds: 500));
    }

    // Create ansi progress.
    final AnsiProgress progress = AnsiProgress('Introspecting...');

    final IntrospectionEngine introspectionEngine =
        IntrospectionEngine(engine: engine);
    final IntrospectResponse response = await introspectionEngine.introspect(
      schema: schema!.readAsStringSync(),
      force: force,
      compositeTypeDepth: compositeTypeDepth,
    );
    introspectionEngine.stop();
    displayIntrospectionMessage(response);

    // If print flag is true, print the introspected schema.
    if ($print) {
      progress.cancel(showTime: true);
      await Future.delayed(Duration(microseconds: 200));

      print("");
      print(response.result?.datamodel);
      return;
    }

    // Replace the schema file with the introspected schema.
    schema!.writeAsStringSync(
        response.result?.datamodel ?? schema!.readAsStringSync());

    // Cancel ansi progress.
    progress.cancel(showTime: true);
  }

  /// Display introspection message.
  void displayIntrospectionMessage(IntrospectResponse response) {
    // If response.error is not null, print error message.
    // And stop engine.
    if (response.error != null) {
      final StringBuffer buffer = StringBuffer();
      if (response.error?.message.isNotEmpty == true) {
        buffer.writeln(response.error?.message);
      }

      if (response.error?.data.message.isNotEmpty == true) {
        buffer.writeln(response.error?.data.message);
      }

      throw Exception(buffer.toString());
    }

    // If result warnings is not empty, print warning message.
    if (response.result?.warnings.isNotEmpty == true) {
      for (final dynamic warning in response.result?.warnings ?? []) {
        print(warning);
      }
    }
  }
}
