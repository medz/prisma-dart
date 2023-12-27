// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../src/dart_style_fixer.dart';
import '../src/reference.dart';
import '../src/scalars.dart';
import '../src/utils/dmmf_schema_types.dart';
import 'client.dart';

extension Client$Output on Client {
  Reference generateOutput(dmmf.TypeReference type) {
    final name = type.type.toDartClassNameString();
    if (exists(name, type.namespace)) {
      return generateRef(name, type.namespace);
    }

    final output = findOutput(type);
    final value = Class((builder) {
      builder.name = name;

      // Fields
      for (final field in output.fields) {
        builder.fields.add(generateField(field));
      }
    });

    final builder = getLibraryBuilder(type.namespace)..body.add(value);
    types[builder] = [...?types[builder], name];

    return generateRef(name, type.namespace);
  }
}

extension on Client {
  LibraryBuilder getLibraryBuilder(dmmf.TypeNamespace? namespace) {
    return switch (namespace) {
      dmmf.TypeNamespace.model => model,
      _ => prisma,
    };
  }

  Reference generateRef(String name, dmmf.TypeNamespace? namespace) {
    return refer(
      name,
      switch (namespace) {
        dmmf.TypeNamespace.prisma => 'prisma.dart',
        dmmf.TypeNamespace.model => 'model.dart',
        _ => null,
      },
    );
  }

  bool exists(String className, dmmf.TypeNamespace? namespace) {
    return switch (namespace) {
      dmmf.TypeNamespace.prisma => types[prisma]?.contains(className) ?? false,
      dmmf.TypeNamespace.model => types[model]?.contains(className) ?? false,
      _ => false,
    };
  }

  dmmf.OutputType findOutput(dmmf.TypeReference type) {
    return options.dmmf.schema.outputTypes.pattern
        .firstWhere((element) => element.name == type.type);
  }

  Field generateField(dmmf.OutputField field) {
    return Field((builder) {
      builder.name = field.name.toDartPropertyNameString();
      builder.type = field.outputType
          .toDartReference(options.dmmf, innerTypes: true)
          .toNullable();
      if (field.outputType.type == 'Json') {
        builder.type = refer('dynamic');
      }

      builder.modifier = FieldModifier.final$;
    });
  }
}
