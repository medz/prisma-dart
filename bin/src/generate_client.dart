// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/src/dmmf/mappings.dart';

import 'generate_delegate.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/reference.dart';

extension GenerateClient on Generator {
  Class generateClient() {
    return Class((builder) {
      builder.name = 'PrismaClient';

      builder.fields.add(generateDatamodel());
      builder.fields.addAll([_metricsField, _transactionField, _engineField]);

      builder.methods.add(_connectMethod);
      builder.methods.add(_disconnectMethod);

      builder.constructors.add(_defaultConstructor);
      builder.constructors.add(generatePublicFactory());

      for (final mapping in options.dmmf.mappings.modelOperations) {
        final method = generateModelOperation(mapping);
        builder.methods.add(method);
      }

      final allowRaw = options.dmmf.mappings.otherOperations.write
              .contains('queryRaw') &&
          options.dmmf.mappings.otherOperations.write.contains('executeRaw');
      if (allowRaw) {
        builder.methods.add(_rawClientGetter);
      }
    });
  }
}

extension on Generator {
  Constructor generatePublicFactory() {
    final datasource = Map.fromEntries(
      options.datasources
          .map((e) => {e.name: e.url.value})
          .expand((e) => e.entries),
    );

    options.datasources.first.name;

    return Constructor((builder) {
      builder.factory = true;

      builder.optionalParameters.add(Parameter((builder) {
        builder.name = 'datasourceUrl';
        builder.named = true;
        builder.type = refer('String').nullable(true);
      }));

      builder.optionalParameters.add(Parameter((builder) {
        builder.name = 'datasources';
        builder.named = true;
        builder.type = refer('Map<String, String>').nullable(true);
      }));

      builder.body = Block.of([
        refer('datasources').assignNullAware(literalMap(datasource)).statement,
        Code('if (datasourceUrl != null) {'),
        refer('datasources')
            .assign(refer('datasources').property('map').call([
              Method((builder) {
                builder.requiredParameters.add(Parameter((builder) {
                  builder.name = 'key';
                }));
                builder.requiredParameters.add(Parameter((builder) {
                  builder.name = 'value';
                }));
                builder.lambda = true;
                builder.body = refer('MapEntry')
                    .newInstance([refer('key'), refer('datasourceUrl')]).code;
              }).closure,
            ]))
            .statement,
        Code('}'),
        declareFinal('engine')
            .assign(
              refer('BinaryEngine', 'package:orm/engines/binary.dart')
                  .newInstance([], {
                'schema': literalString(options.schema),
                'datasources': refer('datasources'),
              }),
            )
            .statement,
        declareFinal('metrics')
            .assign(
              refer('MetricsClient', 'package:orm/orm.dart')
                  .newInstance([refer('engine')]),
            )
            .statement,
        Method((builder) {
          builder.name = 'createClientWithTransaction';
          builder.requiredParameters.add(Parameter((builder) {
            builder.name = 'transaction';
            builder.type = TypeReference((builder) {
              builder.symbol = 'TransactionClient';
              builder.url = 'package:orm/orm.dart';
              builder.types.add(refer('PrismaClient'));
            });
          }));
          builder.lambda = true;
          builder.returns = refer('PrismaClient');
          builder.body = refer('PrismaClient').newInstanceNamed('_', [
            refer('engine'),
            refer('transaction'),
            refer('metrics'),
          ]).statement;
        }).closure.code,
        declareFinal('transaction')
            .assign(TypeReference((builder) {
              builder.symbol = 'TransactionClient';
              builder.url = 'package:orm/orm.dart';
              builder.types.add(refer('PrismaClient'));
            }).newInstance([
              refer('engine'),
              refer('createClientWithTransaction'),
            ]))
            .statement,
        refer('createClientWithTransaction')
            .call([refer('transaction')])
            .returned
            .statement,
      ]);
    });
  }

  Field generateDatamodel() {
    return Field((builder) {
      builder.static = true;
      builder.modifier = FieldModifier.final$;
      builder.name = 'datamodel';
      builder.assignment = refer('DataModel', 'package:orm/dmmf.dart')
          .newInstanceNamed('fromJson', [
        literalMap(options.dmmf.source['datamodel']),
      ]).code;
    });
  }

  Method generateModelOperation(ModelMapping mapping) {
    final type = generateDelegate(mapping);

    return Method((method) {
      method.name = mapping.plural.propertyName;
      method.returns = type;
      method.type = MethodType.getter;
      method.lambda = true;
      method.body = type.newInstanceNamed('_', [refer('this')]).code;
    });
  }
}

final _defaultConstructor = Constructor((builder) {
  builder.name = '_';
  builder.constant = true;

  final parameters = [
    _engineField.name,
    _transactionField.name,
    _metricsField.name
  ];
  for (final parameter in parameters) {
    builder.requiredParameters.add(Parameter((builder) {
      builder.name = parameter;
      builder.toThis = true;
      builder.named = true;
    }));
  }
});

final _connectMethod = Method((builder) {
  builder.name = '\$connect';
  builder.returns = refer('Future<void>');
  builder.lambda = true;
  builder.body = refer(_engineField.name).property('start').call([]).code;
});

final _disconnectMethod = Method((builder) {
  builder.name = '\$disconnect';
  builder.returns = refer('Future<void>');
  builder.lambda = true;
  builder.body = refer(_engineField.name).property('stop').call([]).code;
});

final _engineField = Field((builder) {
  builder.name = '_engine';
  builder.modifier = FieldModifier.final$;
  builder.type = refer('Engine', 'package:orm/orm.dart');
});

final _transactionField = Field((builder) {
  builder.modifier = FieldModifier.final$;
  builder.name = '\$transaction';
  builder.type = TypeReference((builder) {
    builder.symbol = 'TransactionClient';
    builder.url = 'package:orm/orm.dart';
    builder.types.add(refer('PrismaClient'));
  });
});

final _rawClientGetter = Method((builder) {
  final client = TypeReference((builder) {
    builder.symbol = 'RawClient';
    builder.url = 'package:orm/orm.dart';
    builder.types.add(refer('PrismaClient'));
  });

  builder.name = '\$raw';
  builder.type = MethodType.getter;
  builder.returns = client;
  builder.lambda = true;
  builder.body = client.newInstance([
    refer(_engineField.name),
    refer('datamodel'),
    refer(_transactionField.name)
  ]).code;
});

final _metricsField = Field((builder) {
  builder.name = '\$metrics';
  builder.modifier = FieldModifier.final$;
  builder.type = refer('MetricsClient', 'package:orm/orm.dart');
});
