import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_enum.dart';
import 'generate_helpers.dart';
import 'generate_type.dart';
import 'generator.dart';
import 'utils/scalars.dart';
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
      builder.methods.add(generateToJsonMethod(output));
    }));

    return refer(name).namespace(namespace).list(isList);
  }
}

extension on Generator {
  /// Generates a `toJson` method for the output type.
  Method generateToJsonMethod(dmmf.OutputType output) {
    Expression generateValueExpression(Expression value, dmmf.OutputField field,
        [bool nullable = true]) {
      if ((field.outputType.location == dmmf.TypeLocation.scalar &&
              field.outputType.type == 'Json') ||
          field.outputType.location == dmmf.TypeLocation.outputObjectTypes) {
        final call = nullable
            ? value.nullSafeProperty('toJson')
            : value.property('toJson');

        return call([]);
      }

      return value;
    }

    final entries = output.fields.map((e) {
      Expression expression = refer(e.name.propertyName);

      // If output type is a list, we need to map the list to a list of json
      // objects.
      if (e.outputType.isList) {
        expression = expression.nullSafeProperty('map').call([
          Method((builder) {
            builder.lambda = true;
            builder.requiredParameters.add(Parameter((builder) {
              builder.name = 'e';
            }));
            builder.body = generateValueExpression(refer('e'), e, false).code;
          }).closure
        ]);
      } else {
        expression = generateValueExpression(expression, e);
      }

      return MapEntry(literalString(e.name), expression);
    });

    return Method((builder) {
      builder.name = 'toJson';
      builder.returns = refer('Map<String, dynamic>');
      builder.lambda = true;
      builder.body = literalMap(Map.fromEntries(entries)).code;
    });
  }

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
        _ => generageOtherField(field),
      };

      fields[field.name.propertyName] = value;
    }

    return fields;
  }

  Expression generageOtherField(dmmf.OutputField field) {
    final type = refer('json').index(literalString(field.name));
    if (!field.outputType.isList) return type;

    final when = type
        .asA(refer('Iterable'))
        .property('whereType')
        .call([], {}, [field.outputType.type.scalar]);

    return type.isA(refer('Iterable')).conditional(when, literalNull);
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
    Method generateClosure(String parameterName, Expression value) {
      return Method((builder) {
        builder.lambda = true;
        builder.requiredParameters.add(Parameter((builder) {
          builder.name = parameterName;
        }));
        builder.body =
            refer(parameterName).property('name').equalTo(value).code;
      });
    }

    Expression firstWhereCall(Expression enum$, Expression closure) {
      return enum$.property('values').property('firstWhere').call([closure]);
    }

    Expression makeReurns(Expression value, Expression when) {
      return value.notEqualTo(literalNull).conditional(when, literalNull);
    }

    final enum$ =
        generateEnum(field.outputType.type, field.outputType.namespace, false);
    final value = refer('json').index(literalString(field.name));

    if (field.outputType.isList) {
      final wrapper = Method((builder) {
        builder.lambda = true;
        builder.requiredParameters.add(Parameter((builder) {
          builder.name = 'child';
        }));
        builder.body =
            firstWhereCall(enum$, generateClosure('e', refer('child')).closure)
                .code;
      });
      final deserialize =
          value.asA(refer('Iterable')).property('map').call([wrapper.closure]);

      return makeReurns(value, deserialize);
    }

    return makeReurns(
        value, firstWhereCall(enum$, generateClosure('e', value).closure));
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
