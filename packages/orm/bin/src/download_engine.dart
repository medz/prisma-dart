import 'dart:io';

import 'package:orm/generator_helper.dart';
import 'package:path/path.dart' as path;

import 'utils/is_flutter_engine_type.dart';

Future<void> downloadEngine(GeneratorOptions options) async {
  if (isFlutterEngineType(options.generator.config)) {
    return;
  }

  final sourcePath = options.binaryPaths.queryEngine?.values.firstOrNull;
  if (sourcePath == null) {
    print("⚠️[orm] Binary engine not found.");
    return;
  }

  final source = File(sourcePath);
  if (!await source.exists()) {
    print(
        '⚠️[orm] Prisma provided the engine path, but the file does not exist');
    return;
  }

  final target =
      File(path.join(path.dirname(options.schemaPath), 'prisma-query-engine'));
  if (await target.exists()) {
    await target.delete(recursive: true);
  }

  await source.copy(target.path);
}
