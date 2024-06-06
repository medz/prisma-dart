// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/src/dmmf/mappings.dart';
import 'package:orm/generator_helper.dart' as gh;

import 'generate_delegate.dart';
import 'generator.dart';
import 'utils/is_flutter_engine_type.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/reference.dart';

extension GenerateClient on Generator {
  Class generateClient() {
    return Class((builder) {
      builder.name = 'PrismaClient';

      builder.extend = refer('BasePrismaClient', 'package:orm/orm.dart');

      builder.fields.add(generateDatamodel());
      builder.fields.add(_engineField);

      builder.constructors.add(_defaultConstructor);
      builder.methods.add(createEngineGetter());

      for (final mapping in options.dmmf.mappings.modelOperations) {
        final method = generateModelOperation(mapping);
        builder.methods.add(method);
      }

      final allowRaw = options.dmmf.mappings.otherOperations.write
              .contains('queryRaw') &&
          options.dmmf.mappings.otherOperations.write.contains('executeRaw');
      if (allowRaw) {
        // builder.methods.add(_rawClientGetter);
      }
    });
  }
}

extension on Generator {
  Method createEngineGetter() {
    final engine = switch (options.generator.config['engineType']) {
      'flutter' =>
        refer('PrismaFlutterEngine', 'package:orm_flutter/orm_flutter.dart'),
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

  const superPptionalParameters = [
    'datasourceUrl',
    'datasources',
    'errorFormat',
    'log'
  ];
  for (final parameter in superPptionalParameters) {
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
