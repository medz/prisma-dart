import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

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
}
