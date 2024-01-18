import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_helpers.dart';
import 'generate_type.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/reference.dart';

extension GenerateOutput on Generator {
  Reference generateOutput(
      String type, dmmf.TypeNamespace? namespace, bool isList) {
    final types = getTypesWithNamespace(namespace);
    final name = type.className;
    if (types.contains(name)) {
      return refer(name).namespace(namespace).list(isList);
    }

    final builder = getLibraryByNamespace(namespace);
    final output = findOutputByNamespace(type, namespace);

    types.add(name);
    builder.body.add(Class((builder) {
      builder.name = output.name.className;

      for (final field in output.fields) {
        builder.fields.add(generateField(field));
      }

      builder.constructors.add(generateDefaultConstructor(output));
      builder.constructors.add(generateFromJsonConstructor(output));
    }));

    return refer(name).namespace(namespace).list(isList);
  }
}

extension on Generator {
  Constructor generateFromJsonConstructor(dmmf.OutputType output) {
    return Constructor((builder) {
      builder.name = 'fromJson';
      builder.factory = true;
      builder.requiredParameters.add(Parameter((builder) {
        builder.name = 'json';
        builder.type = refer('Map');
      }));
      builder.lambda = true;
      builder.body = refer(output.name.className)
          .newInstance([], generateFromJsonFields(output)).code;
    });
  }

  Map<String, Expression> generateFromJsonFields(dmmf.OutputType output) {
    final fields = <String, Expression>{};

    for (final field in output.fields) {
      final value = switch (field.outputType.location) {
        dmmf.TypeLocation.enumTypes => generateFromJsonEnumField(field),
        dmmf.TypeLocation.outputObjectTypes =>
          generateFromJsonOutputField(field),
        _ => refer('json').index(literalString(field.name)),
      };

      fields[field.name.propertyName] = value;
    }

    return fields;
  }

  Expression generateFromJsonOutputField(dmmf.OutputField field) {
    if (field.outputType.isList) {
      return generateFromJsonOutputListField(field);
    }

    final value = refer('json').index(literalString(field.name));
    final deserialize = generateType(field.outputType).newInstanceNamed(
        'fromJson', [refer('json').index(literalString(field.name))]);

    return value.isA(refer('Map')).conditional(deserialize, literalNull);
  }

  Expression generateFromJsonOutputListField(dmmf.OutputField field) {
    final type = generateType(dmmf.TypeReference(
      isList: false,
      location: field.outputType.location,
      namespace: field.outputType.namespace,
      type: field.outputType.type,
    ));

    final fromJson = Method((builder) {
      builder.lambda = true;
      builder.requiredParameters.add(Parameter((builder) {
        builder.name = 'json';
      }));
      builder.body = type.property('fromJson').call([refer('json')]).code;
    });

    return refer('json')
        .index(literalString(field.name))
        .asA(TypeReference((type) {
          type.symbol = 'Iterable';
          type.isNullable = true;
        }))
        .nullSafeProperty('map')
        .call([fromJson.closure]);
  }

  Expression generateFromJsonEnumField(dmmf.OutputField field) {
    final value = refer('json').index(literalString(field.name));
    final method = Method((builder) {
      builder.lambda = true;
      builder.requiredParameters.add(Parameter((builder) {
        builder.name = 'e';
      }));
      builder.body = refer('e').property('name').equalTo(value).code;
    });
    final deserialize = generateType(field.outputType)
        .property('values')
        .property('firstWhere')
        .call([method.closure]);

    return value.notEqualTo(literalNull).conditional(deserialize, literalNull);
  }

  Constructor generateDefaultConstructor(dmmf.OutputType output) {
    return Constructor((builder) {
      builder.constant = true;

      for (final field in output.fields) {
        builder.optionalParameters.add(Parameter((builder) {
          builder.name = field.name.propertyName;
          builder.toThis = true;
          builder.named = true;
        }));
      }
    });
  }

  Field generateField(dmmf.OutputField field) {
    final type = generateType(field.outputType);

    return Field((builder) {
      builder.name = field.name.propertyName;
      builder.modifier = FieldModifier.final$;
      builder.type = type.nullable(true);
      if (field.outputType.type.toLowerCase() == 'json') {
        builder.type = refer('Object?');
      }
    });
  }

  dmmf.OutputType findOutputByNamespace(
      String name, dmmf.TypeNamespace? namespace) {
    final outputs = switch (namespace) {
      dmmf.TypeNamespace.model => options.dmmf.schema.outputTypes.model,
      dmmf.TypeNamespace.prisma => options.dmmf.schema.outputTypes.prisma,
      _ => throw Exception('Unknown namespace'),
    };

    return outputs.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ArgumentError(
          'OutputType $name not found in namespace ${namespace?.name}.', name),
    );
  }
}
