import 'dart:io';

import 'package:path/path.dart';

import '../json_rpc/schema_push.dart';
import 'migrate_engine.dart';

class Migrate {
  Migrate({
    required this.schema,
    required String path,
    List<String>? enabledPreviewFeatures,
  }) {
    final String prismaDir = dirname(schema.path);
    migrationsPath = join(prismaDir, 'migrations');
    engine = MigrateEngine(
      enginePath: path,
      schemaPath: schema.path,
      enabledPreviewFeatures: enabledPreviewFeatures,
    );
  }

  /// Schema path.
  final File schema;

  /// Migrations directory path.
  late final String? migrationsPath;

  /// Migrate engine.
  late final MigrateEngine engine;

  /// Stop engine.
  void stop() => engine.stop();

  /// Push schema.
  Future<SchemaPushResponse> push({bool force = false}) async {
    return await engine.schemaPush(SchemaPushRequest(
      schema: schema.readAsStringSync(),
      force: force,
    ));
  }
}
