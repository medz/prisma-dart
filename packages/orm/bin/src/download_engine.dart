import 'dart:io';

// import 'package:yaml/yaml.dart';
import 'package:orm/generator_helper.dart';
// import 'package:orm/src/_internal/project_directory.dart';
import 'package:path/path.dart' as path;

import 'utils/is_flutter_engine_type.dart';

Future<void> downloadEngine(GeneratorOptions options) async {
  if (isFlutterEngineType(options.generator.config)) {
    return;
    // return downloadFlutterQueryEngine(options);
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

// Future<void> downloadFlutterQueryEngine(GeneratorOptions options) async {
//   final projectDir = findProjectDirectory(path.dirname(options.schemaPath));
//   if (projectDir == null) {
//     throw "⚠️[orm] Please generate a client in your project directory";
//   }

//   final pubspec = loadYaml(
//       await File(path.join(projectDir.path, 'pubspec.yaml')).readAsString());
//   if (pubspec case {"dependencies": {"orm_flutter": _}}) {
//     final process = await Process.run(
//       'dart',
//       ['run', 'orm_flutter:dl_engine'],
//       workingDirectory: projectDir.path,
//       includeParentEnvironment: true,
//     );
//     if (process.exitCode == 0) {
//       return;
//     }

//     print(process.stdout);
//     print(process.stderr);
//     return;
//   }

//   throw '''
// You are generating a Prisma client for Flutter
// It is detected that you do not have the `orm_flutter` integration package installed.

// **Please use the following command to install:**

//     flutter pub add orm_flutter

// After the installation is complete, please regenerate the client.
// ''';
// }
