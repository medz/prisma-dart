import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/orm.dart' as orm;

import 'generate_helpers.dart';
import 'generate_include.dart';
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
  builder.type = refer('PrismaClient');
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
    final returns = TypeReference((type) {
      type.symbol = 'ActionClient';
      type.types.add(returnsType);
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

      if (allowInclude(field.outputType)) {
        method.optionalParameters.add(Parameter((builder) {
          builder.name = 'include';
          builder.named = true;
          builder.type = generateInclude(field.outputType).nullable(true);
        }));
      }

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
    final serialize =
        generateType(field.outputType, isList: false).property('fromJson');
    final orThrow = field.name.endsWith('OrThrow');

    if (field.outputType.isList) {
      return Method((builder) {
        builder.requiredParameters.add(Parameter((builder) {
          builder.name = 'values';
        }));

        final mapProperty = switch (field.isNullable) {
          true =>
            refer('values').asA(refer('Iterable?')).nullSafeProperty('map'),
          _ => refer('values').asA(refer('Iterable')).property('map'),
        };

        final fn = Method((builder) {
          builder.requiredParameters.add(Parameter((builder) {
            builder.name = 'e';
          }));

          builder.body = serialize.call([refer('e')]).code;
        });

        builder.body = mapProperty.call([fn.closure]).code;
      }).closure;
    }

    return Method((builder) {
      builder.requiredParameters.add(Parameter((builder) {
        builder.name = 'e';
      }));

      final thenTrue = serialize.call([refer('e')]);

      builder.body = thenTrue.code;
      if (field.isNullable && !orThrow) {
        builder.body = refer('e')
            .notEqualTo(literalNull)
            .conditional(thenTrue, literalNull)
            .code;
      }
    }).closure;
  }

  Code generateResult() {
    final request =
        refer('_client').property('\$engine').property('request').call([
      refer('query')
    ], {
      'headers': refer('_client').property('\$transaction').property('headers'),
      'transaction':
          refer('_client').property('\$transaction').property('transaction'),
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
      'datamodel': refer('PrismaClient').property('datamodel'),
    };
    final serialize =
        refer('serializeJsonQuery', 'package:orm/orm.dart').call([], args);

    return declareFinal('query').assign(serialize).statement;
  }

  Code generateArgs(dmmf.OutputField field, dmmf.ModelAction action) {
    final args = Map.fromEntries(field.args.map((e) {
      if (action == dmmf.ModelAction.groupBy && e.name == 'by') {
        return MapEntry(
          'by',
          refer('JsonQuery', 'package:orm/orm.dart')
              .property('groupBySerializer')
              .call([refer('by')]),
        );
      }

      return MapEntry(e.name, refer(e.name));
    }));

    final select = switch (action == dmmf.ModelAction.groupBy) {
      true => refer('select').ifNullThen(
          refer('JsonQuery', 'package:orm/orm.dart')
              .property('groupBySelectSerializer')
              .call([refer('by')])),
      _ => refer('select'),
    };

    return declareFinal('args')
        .assign(literalMap({
          ...args,
          if (allowSelect(action)) 'select': select,
          if (allowInclude(field.outputType)) 'include': refer('include'),
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
        .firstWhere(
          (element) => element.name == action,
          orElse: () => throw Exception('Not found action $action in schema'),
        );
  }
}
