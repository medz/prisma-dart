// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'client.dart';

extension Client$Common on Client {
  LibraryBuilder getNamespaceLibraryBuilder(dmmf.TypeNamespace? namespace) {
    return switch (namespace) {
      dmmf.TypeNamespace.model => model,
      _ => prisma,
    };
  }

  Reference getNamespaceRefer(String name, dmmf.TypeNamespace? namespace) {
    return refer(
      name,
      switch (namespace) {
        dmmf.TypeNamespace.prisma => 'prisma.dart',
        dmmf.TypeNamespace.model => 'model.dart',
        _ => null,
      },
    );
  }

  bool namespaceTypeExists(String className, dmmf.TypeNamespace? namespace) {
    return switch (namespace) {
      dmmf.TypeNamespace.prisma => types[prisma]?.contains(className) ?? false,
      dmmf.TypeNamespace.model => types[model]?.contains(className) ?? false,
      _ => false,
    };
  }
}
