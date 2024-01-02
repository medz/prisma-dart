import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/orm.dart' as orm;

import 'generate_helpers.dart';
import 'generate_select.dart';
import 'generate_type.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/reference.dart';

extension GenerateDelegate on Generator {
  Reference generateDelegate(dmmf.ModelMapping mapping) {
    final name = '${mapping.plural.className}Delegate';
    if (generated.client.contains(name)) {
      return refer(name);
    }

    generated.client.add(name);
    libraries.client.body.add(Class((builder) {
      builder.name = name;
      builder.types.add(refer('T'));
      builder.fields.add(_clientField);
      builder.constructors.add(_defaultConstructor);

      for (final entry in mapping.actions.entries) {
        final action = (entry.key, entry.value);
        builder.methods.add(generateAction(action, mapping.model));
      }
    }));

    return refer(name);
  }
}

final _clientField = Field((builder) {
  builder.name = '_client';
  builder.type = TypeReference((type) {
    type.symbol = 'PrismaClient';
    type.url = 'package:orm/orm.dart';
    type.types.add(refer('T'));
  });
  builder.modifier = FieldModifier.final$;
});

final _defaultConstructor = Constructor((builder) {
  builder.name = '_';
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = _clientField.name;
    builder.toThis = true;
  }));
  builder.constant = true;
});

extension on Generator {
  Method generateAction((dmmf.ModelAction, String) action, String model) {
    final field = findActionDefinition(action.$2);
    final returnsType = generateType(field.outputType)
        .nullable(field.name.endsWith('OrThrow') ? false : field.isNullable);
    final rawType = (field.outputType.isList
            ? TypeReference((type) {
                type.symbol = 'Iterable';
                type.types.add(refer('Map'));
              })
            : refer('Map'))
        .nullable(field.name.endsWith('OrThrow') ? false : field.isNullable);

    final returns = TypeReference((type) {
      type.symbol = 'ActionClient';
      type.types.addAll([rawType, returnsType]);
      type.url = 'package:orm/orm.dart';
    });

    return Method((method) {
      method.name = action.$1.name.propertyName;
      method.returns = returns;

      for (final argument in field.args) {
        method.optionalParameters.add(generateArgument(argument));
      }

      if (allowSelect(action.$1)) {
        method.optionalParameters.add(Parameter((builder) {
          builder.name = 'select';
          builder.named = true;
          builder.type = generateSelect(field).nullable(true);
        }));
      }

      // TODO: implement include

      method.body = Block.of([
        generateArgs(field, action.$1),
        generateQuery(action, model),
        generateResult(),
        returns
            .newInstance([], {
              'action': literalString(action.$2),
              'result': refer('result'),
              'factory': generateFactory(field),
            })
            .returned
            .statement,
      ]);
    });
  }

  Expression generateFactory(dmmf.OutputField field) {
    final serialize = refer(field.outputType.type.className)
        .namespace(field.outputType.namespace)
        .property('fromJson');
    final orThrow = field.name.endsWith('OrThrow');

    if (field.outputType.isList) {
      return Method((builder) {
        builder.requiredParameters.add(Parameter((builder) {
          builder.name = 'values';
          builder.type = TypeReference((type) {
            type.symbol = 'Iterable';
            type.types.add(refer('Map'));
            type.isNullable = field.isNullable;
          });
        }));

        final mapProperty = switch (field.isNullable) {
          true => refer('values').nullSafeProperty('map'),
          _ => refer('values').property('map'),
        };

        builder.body = mapProperty.call([serialize]).code;
      }).closure;
    } else if (field.isNullable && !orThrow) {
      return Method((builder) {
        builder.requiredParameters.add(Parameter((builder) {
          builder.name = 'value';
          builder.type = TypeReference((type) {
            type.symbol = 'Map';
            type.isNullable = true;
          });
        }));
        final thenTrue = serialize.call([refer('value')]);

        builder.body = refer('value')
            .notEqualTo(literalNull)
            .conditional(thenTrue, literalNull)
            .code;
      }).closure;
    }

    return serialize;
  }

  Code generateResult() {
    final request =
        refer('_client').property('\$engine').property('request').call([
      refer('query')
    ], {
      'headers': refer('_client').property('\$headers'),
      'transaction': refer('_client').property('\$info'),
    });

    return declareFinal('result').assign(request).statement;
  }

  Code generateQuery((dmmf.ModelAction, String) action, String model) {
    final args = <String, Expression>{
      'args': refer('args'),
      'modelName': literalString(model),
      'action': refer('JsonQueryAction', 'package:orm/orm.dart').property(
        action.$1.toJsonQueryAction().name,
      ),
      'datamodel': refer('PrismaClient\$Extention').property('datamodel'),
    };
    final serialize =
        refer('serializeJsonQuery', 'package:orm/orm.dart').call([], args);

    return declareFinal('query').assign(serialize).statement;
  }

  Code generateArgs(dmmf.OutputField field, dmmf.ModelAction action) {
    return declareFinal('args')
        .assign(literalMap({
          ...Map.fromEntries(
              field.args.map((e) => MapEntry(e.name, refer(e.name)))),
          // TODO: select and include
          if (allowSelect(action)) 'select': refer('select'),
        }))
        .statement;
  }

  Parameter generateArgument(dmmf.InputField field) {
    final type = generateUnionType(field.inputTypes);

    return Parameter((builder) {
      builder.name = field.name.propertyName;
      builder.named = true;
      builder.required = field.isRequired;
      builder.type = type.nullable(!field.isRequired);
    });
  }

  dmmf.OutputField findActionDefinition(String action) {
    return options.dmmf.schema.outputTypes.prisma
        .where(
            (element) => element.name == 'Query' || element.name == 'Mutation')
        .map((e) => e.fields)
        .expand((element) => element)
        .firstWhere((element) => element.name == action);
  }
}
