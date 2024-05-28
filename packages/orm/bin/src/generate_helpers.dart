import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_type.dart';
import 'generator.dart';
import 'utils/iterable.dart';

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

  bool allowSelect(dmmf.ModelAction action) =>
      !_disallowedSelectActions.contains(action);

  bool allowInclude(dmmf.TypeReference type) {
    final types = switch (type.namespace) {
      dmmf.TypeNamespace.model => options.dmmf.schema.outputTypes.model,
      dmmf.TypeNamespace.prisma => options.dmmf.schema.outputTypes.prisma,
      _ => const <dmmf.OutputType>[],
    };
    final models = options.dmmf.datamodel.models.map((e) => e.name);
    final output =
        types.firstWhereOrNull((element) => element.name == type.type);
    final modelRefs = output?.fields
        .where((element) => models.contains(element.outputType.type));

    return modelRefs?.isNotEmpty ?? false;
  }
}

final _disallowedSelectActions = <dmmf.ModelAction>[
  dmmf.ModelAction.createMany,
  dmmf.ModelAction.updateMany,
  dmmf.ModelAction.deleteMany,
  dmmf.ModelAction.findRaw,
  dmmf.ModelAction.aggregateRaw,
];
