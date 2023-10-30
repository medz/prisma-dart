import 'package:code_builder/code_builder.dart';
import 'package:orm/generator_helper.dart' show GeneratorOptions;

import 'packages.dart';

void generateClient(
    Map<Reference, Library> libraries, GeneratorOptions options) {
  final reference = refer('PrismaClient');
  final generator = PrismaClientGenerator(options, libraries);

  libraries[reference] = generator.build();
}

class PrismaClientGenerator {
  final GeneratorOptions options;
  final Map<Reference, Library> libraries;
  final LibraryBuilder library;

  PrismaClientGenerator(this.options, this.libraries)
      : library = LibraryBuilder();

  Library build() {
    library.body.add(Class((builder) {
      builder.name = 'PrismaClient';

      builder.fields.add(Field(engineField));

      builder.methods.add(Method(clientVersion));
      builder.methods.add(Method(engineVersion));
    }));

    return library.build();
  }

  void engineField(FieldBuilder builder) {
    builder.name = r'$engine';
    builder.type = ormCoreRefer('Engine');
    builder.modifier = FieldModifier.final$;
  }

  void clientVersion(MethodBuilder builder) {
    builder.name = r'$clientVersion';
    builder.returns = refer('String');
    builder.body = ormVersion.code;
    builder.lambda = true;
    builder.type = MethodType.getter;
  }

  void engineVersion(MethodBuilder builder) {
    builder.name = r'$engineVersion';
    builder.returns = refer('String');
    builder.body = literalString(options.version).code;
    builder.lambda = true;
    builder.type = MethodType.getter;
  }
}
