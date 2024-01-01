import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

Future<void> writeDartSpec({
  required DartFormatter formatter,
  required Spec spec,
  required String path,
}) async {
  final emitter = DartEmitter.scoped(
    useNullSafetySyntax: true,
    orderDirectives: true,
  );

  final file = File(path)..autoCreateSync();
  final dartSource = formatter.format('${spec.accept(emitter)}');

  await file.writeAsString(dartSource);
}

extension on File {
  void autoCreateSync() {
    if (existsSync()) return;

    createSync(recursive: true);
  }
}
