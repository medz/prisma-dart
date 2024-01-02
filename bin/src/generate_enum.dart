import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_helpers.dart';
import 'generate_model_scalar.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/reference.dart';

extension GenerateEnum on Generator {
  Reference generateEnum(
      String name, dmmf.TypeNamespace? namespace, bool isList) {
    if (name.endsWith('ScalarFieldEnum') &&
        namespace == dmmf.TypeNamespace.prisma) {
      return generateModelScalar(name).namespace(namespace).list(isList);
    }

    final types = getTypesWithNamespace(namespace);
    final className = name.className;
    if (types.contains(className)) {
      return refer(className).namespace(namespace).list(isList);
    }

    final builder = getLibraryByNamespace(namespace);
    final enum$ = findEnum(name, namespace);

    types.add(className);
    builder.body.add(Enum((builder) {
      builder.name = className;
      builder.implements.add(TypeReference((type) {
        type.symbol = 'PrismaEnum';
        type.url = 'package:orm/orm.dart';
      }));
      builder.fields.add(_enumField);
      builder.constructors.add(_defaultConstructor);

      for (final value in enum$.values) {
        builder.values.add(EnumValue((builder) {
          builder.name = value.propertyName;
          builder.constructorName = _defaultConstructor.name;
          builder.arguments.add(literalString(value));
        }));
      }
    }));

    return refer(className).namespace(namespace).list(isList);
  }
}

final _enumField = Field((builder) {
  builder.name = 'name';
  builder.type = refer('String');
  builder.modifier = FieldModifier.final$;
  builder.annotations.add(refer('override'));
});

final _defaultConstructor = Constructor((builder) {
  builder.name = '_';
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = _enumField.name;
    builder.named = true;
    builder.toThis = true;
  }));
  builder.constant = true;
});

extension on Generator {
  dmmf.Enum findEnum(String name, dmmf.TypeNamespace? namespace) {
    final enums = switch (namespace) {
      dmmf.TypeNamespace.model => options.dmmf.schema.enumTypes.model,
      dmmf.TypeNamespace.prisma => options.dmmf.schema.enumTypes.prisma,
      _ => throw Exception('Unknown namespace'),
    };

    return enums.firstWhere((element) => element.name == name);
  }
}
