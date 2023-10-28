import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:orm/generator_helper.dart';

import 'context.dart';
import 'enum_generator.dart';
import 'model_generator.dart';

class Generator {
  final Context context;

  Generator._(this.context);
  factory Generator(GeneratorOptions options) => Generator._(Context(options));

  Future<void> handle() async {
    final dmmf = context.options.dmmf;

    final enumGenerator = EnumGenerator(context);
    for (final schema in dmmf.schema.enumTypes.model ?? []) {
      await enumGenerator.handle(schema);
    }

    final modelGenerator = ModelGenerator(context);
    for (final model in dmmf.datamodel.models) {
      await modelGenerator.handle(model.name);
    }

    final formater = DartFormatter();
    final output = context.options.generator.output!.value!;
    for (final MapEntry(key: meta, value: library)
        in context.libraries.entries) {
      final emitter = DartEmitter.scoped(
        useNullSafetySyntax: true,
      );
      final code = formater.format(library.accept(emitter).toString());
      final file = File(meta.output(output));
      if (file.existsSync()) {
        file.deleteSync();
      }
      file.createSync(recursive: true);
      file.writeAsStringSync(code);
    }
  }
}
