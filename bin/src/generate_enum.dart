import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_model_scalar.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/reference.dart';

extension GenerateEnum on Generator {
  Reference generateEnum(
      String name, dmmf.TypeNamespace? namespace, bool isList) {
    if (name.endsWith('ScalarFieldEnum') &&
        namespace == dmmf.TypeNamespace.prisma) {
      return generateModelScalar(name).list(isList);
    }

    final types = getTypesWithNamespace(namespace);
    final className = name.className;
    if (types.contains(className)) {
      return refer(className).list(isList);
    }

    types.add(className);
    final builder = getLibraryByNamespace(namespace);

    builder.body.add(Enum((builder) {}));

    return refer(className).list(isList);
  }
}

extension on Generator {
  LibraryBuilder getLibraryByNamespace(dmmf.TypeNamespace? namespace) {
    return switch (namespace) {
      dmmf.TypeNamespace.model => libraries.model,
      dmmf.TypeNamespace.prisma => libraries.prisma,
      _ => libraries.client,
    };
  }

  Set<String> getTypesWithNamespace(dmmf.TypeNamespace? namespace) {
    return switch (namespace) {
      dmmf.TypeNamespace.model => generated.model,
      dmmf.TypeNamespace.prisma => generated.prisma,
      _ => generated.client,
    };
  }
}
