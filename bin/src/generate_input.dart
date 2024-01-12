import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_helpers.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/reference.dart';

extension GenerateInput on Generator {
  Reference generateInput(
      String name, dmmf.TypeNamespace? namespace, bool isList) {
    final input = findInputByNamespace(name, namespace);
    return generateInputByInput(input, namespace: namespace).list(isList);
  }

  Reference generateInputByInput(
    dmmf.InputType input, {
    dmmf.TypeNamespace? namespace,
  }) {
    final name = input.name.className;
    final types = getTypesWithNamespace(namespace);
    if (types.contains(name)) {
      return refer(name).namespace(namespace);
    }

    final builder = getLibraryByNamespace(namespace);

    types.add(name);
    builder.body.add(Class((builder) {
      builder.name = name;
      builder.constructors.add(generateDefaultConstructor(input));
      builder.implements.add(TypeReference((builder) {
        builder.symbol = 'JsonConvertible';
        builder.url = 'package:orm/orm.dart';
        builder.types.add(refer('Map<String, dynamic>'));
      }));

      for (final field in input.fields) {
        builder.fields.add(generateField(field, input));
      }

      builder.methods.add(generateToJson(input));
    }));

    return refer(name).namespace(namespace);
  }
}

extension on Generator {
  Method generateToJson(dmmf.InputType input) {
    final entries =
        input.fields.map((e) => MapEntry(e.name, refer(e.name.propertyName)));

    return Method((builder) {
      builder.name = 'toJson';
      builder.returns = refer('Map<String, dynamic>');
      builder.body = literalMap(Map.fromEntries(entries)).code;
      builder.annotations.add(refer('override'));
    });
  }

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

    return types.firstWhere(
      (e) => e.name == name,
      orElse: () => throw ArgumentError(
          'InputType $name not found in namespace ${namespace?.name}.', name),
    );
  }
}
