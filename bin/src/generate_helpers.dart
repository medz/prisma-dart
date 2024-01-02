import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_type.dart';
import 'generator.dart';

extension GenerateHelpers on Generator {
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

  Reference generateUnionType(Iterable<dmmf.TypeReference> types) {
    if (types.length == 1) {
      return generateType(types.first);
    }

    return TypeReference((builder) {
      builder.symbol = 'PrismaUnion';
      builder.url = 'package:orm/orm.dart';
      builder.types.addAll([
        generateType(types.first),
        generateUnionType(types.skip(1)),
      ]);
    });
  }
}
