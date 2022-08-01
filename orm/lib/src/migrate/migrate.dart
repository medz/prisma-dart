import 'dart:io';

import 'package:path/path.dart';

import '../binary_engine.dart';
import '../json_rpc/schema_push.dart';
import 'migrate_engine.dart';

class Migrate {
  Migrate(
    BinaryEngine binaryEngine, {
    required this.schema,
    List<String>? enabledPreviewFeatures,
  }) {
    final String prismaDir = dirname(schema.path);
    migrationsPath = join(prismaDir, 'migrations');
    engine = MigrateEngine(
      binaryEngine: binaryEngine,
      schema: schema,
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
