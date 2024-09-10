// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/src/dmmf/mappings.dart';
import 'package:orm/generator_helper.dart' as gh;

import 'generate_delegate.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';

extension GenerateClient on Generator {
  Class generateClient() {
    return Class((builder) {
      builder.name = 'PrismaClient';

      builder.extend = TypeReference((builder) {
        builder.symbol = 'BasePrismaClient';
        builder.url = 'package:orm/orm.dart';
        builder.types.add(refer('PrismaClient'));
      });

      builder.constructors.add(_defaultConstructor);

      builder.fields.add(generateDatamodel());
      builder.fields.add(_engineField);
      builder.fields.add(Field((builder) {
        builder.name = '_transaction';
        builder.type =
            refer('TransactionClient<PrismaClient>?', 'package:orm/orm.dart');
      }));

      builder.methods.add(createTransactionGetter());
      builder.methods.add(createEngineGetter());
      builder.methods.add(Method((getter) {
        getter.name = '\$datamodel';
        getter.annotations.add(refer('override'));
        getter.lambda = true;
        getter.type = MethodType.getter;
        getter.body = Code('datamodel');
      }));

      for (final mapping in options.dmmf.mappings.modelOperations) {
        final method = generateModelOperation(mapping);
        builder.methods.add(method);
      }
    });
  }
}

extension on Generator {
  Method createTransactionGetter() {
    return Method((getter) {
      getter.type = MethodType.getter;
      getter.name = '\$transaction';
      getter.annotations.add(refer('override'));
      getter.body = Block.of([
        Code('if (_transaction != null) return _transaction!;'),
        Code('PrismaClient factory('),
        refer('TransactionClient<PrismaClient>', 'package:orm/orm.dart').code,
        Code('transaction) {'),
        Code('''
        final client = PrismaClient(
          engine: \$engine,
          datasources: \$options.datasources,
          datasourceUrl: \$options.datasourceUrl,
          errorFormat: \$options.errorFormat,
          log: \$options.logEmitter.definition,
        );
        client.\$options.logEmitter = \$options.logEmitter;
        client._transaction = transaction;

        return client;
        '''),
        Code('}'),
        Code('return _transaction ='),
        refer('TransactionClient<PrismaClient>', 'package:orm/orm.dart').code,
        Code('(\$engine, factory);'),
      ]);
    });
  }

  Method createEngineGetter() {
    final engine = switch (options.generator.config['engineType']) {
      'flutter' =>
        refer('LibraryEngine', 'package:orm_flutter/orm_flutter.dart'),
      _ => refer('BinaryEngine', 'package:orm/engines/binary.dart'),
    };

    final datasources = options.datasources.map((e) {
      final (value, type) = switch (e.url) {
        gh.EnvVar(name: final String name) => (
            name,
            'DatasourceType.environment'
          ),
        gh.EnvValue(value: final String url) => (url, 'DatasourceType.url')
      };

      return MapEntry(
          e.name,
          refer('Datasource', 'package:orm/orm.dart').newInstance([
            refer(type, 'package:orm/orm.dart'),
            literalString(value),
          ]));
    });

    return Method((builder) {
      builder.name = '\$engine';
      builder.lambda = true;
      builder.annotations.add(refer('override'));
      builder.type = MethodType.getter;
      builder.body = refer('_engine')
          .assignNullAware(
            engine.newInstance([], {
              // TODO: https://github.com/dart-lang/code_builder/issues/452
              'schema': literalString(options.schema.replaceAll('\r\n', '\n')),
              'datasources': literalConstMap(Map.fromEntries(datasources)),
              'options': refer('\$options'),
            }),
          )
          .code;
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
  builder.constant = false;

  const superOptionalParameters = [
    'datasourceUrl',
    'datasources',
    'errorFormat',
    'log'
  ];
  for (final parameter in superOptionalParameters) {
    builder.optionalParameters.add(Parameter((builder) {
      builder.name = parameter;
      builder.named = true;
      builder.toSuper = true;
    }));
  }

  // engine parameter
  builder.optionalParameters.add(Parameter((builder) {
    builder.name = 'engine';
    builder.named = true;
    builder.type = Reference('Engine?', 'package:orm/orm.dart');
  }));

  builder.initializers.add(Code('_engine = engine'));
});

final _engineField = Field((builder) {
  builder.name = '_engine';
  builder.type = refer('Engine?', 'package:orm/orm.dart');
});
