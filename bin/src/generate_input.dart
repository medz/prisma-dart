import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_helpers.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/reference.dart';

extension GenerateInput on Generator {
  Reference generateInput(
      String name, dmmf.TypeNamespace? namespace, bool isList) {
    final types = getTypesWithNamespace(namespace);
    final typeName = name.className;
    if (types.contains(typeName)) {
      return refer(typeName).namespace(namespace).list(isList);
    }

    final builder = getLibraryByNamespace(namespace);
    final input = findInputByNamespace(name, namespace);

    types.add(typeName);
    builder.body.add(Class((builder) {
      builder.name = typeName;

      for (final field in input.fields) {
        builder.fields.add(generateField(field, input));
      }

      builder.constructors.add(generateDefaultConstructor(input));
    }));

    return refer(typeName).namespace(namespace).list(isList);
  }
}

extension on Generator {
  Constructor generateDefaultConstructor(dmmf.InputType input) {
    return Constructor((builder) {
      builder.constant = true;
      for (final field in input.fields) {
        builder.optionalParameters.add(Parameter((builder) {
          builder.toThis = true;
          builder.named = true;
          builder.name = field.name.propertyName;
          builder.required =
              switch (input.constraints.fields?.contains(field.name)) {
            true => true,
            _ => field.isRequired,
          };
        }));
      }
    });
  }

  Field generateField(dmmf.InputField field, dmmf.InputType input) {
    final type = generateUnionType(field.inputTypes);

    return Field((builder) {
      builder.name = field.name.propertyName;
      builder.modifier = FieldModifier.final$;
      builder.type = switch (input.constraints.fields?.contains(field.name)) {
        true => type.nullable(false),
        _ => type.nullable(!field.isRequired),
      };
    });
  }

  dmmf.InputType findInputByNamespace(
      String name, dmmf.TypeNamespace? namespace) {
    final types = switch (namespace) {
      dmmf.TypeNamespace.model => options.dmmf.schema.inputTypes.model,
      dmmf.TypeNamespace.prisma => options.dmmf.schema.inputTypes.prisma,
      _ => const <dmmf.InputType>[],
    };

    return types.firstWhere((e) => e.name == name);
  }
}
