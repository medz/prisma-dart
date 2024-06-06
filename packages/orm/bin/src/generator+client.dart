// ignore_for_file: file_names

import 'generator.dart';
import 'package:orm/generator_helper.dart' as gh;

import 'utils/is_flutter_engine_type.dart';

extension Generate$Client on Generator {
  String client() {
    return '''
    import 'package:orm/orm.dart';
    import '$enginePackageUrl' show $engineName;

    class PrismaClient extends BasePrismaClient {
      Engine? _engine;

      PrismaClient({
        super.datasourceUrl,
        super.datasources,
        super.errorFormat,
        super.log,
        Engine? engine,
      }) : _engine = engine;

      @override
      Engine get \$engine => _engine ??= createEngineInstance();
    }

    extension on PrismaClient {
      Engine createEngineInstance() {
        return $engineName(
          schema: '${options.schema.literal()}',
          datasources: $datasources,
          options: \$options,
        );
      }
    }
    ''';
  }

  String get datasources {
    final datasources = options.datasources.map((e) {
      final datasource = switch (e.url) {
        gh.EnvVar(name: final String name) =>
          'const Datasource(DatasourceType.enviroment, \'${name.literal()}\')',
        gh.EnvValue(value: final String url) =>
          'const Datasource(DatasourceType.url, \'${url.literal()}\')',
      };

      return '\'${e.name}\': $datasource';
    });

    return '{${datasources.join(',')}}';
  }

  String get enginePackageUrl {
    return switch (isFlutterEngineType(options.generator.config)) {
      true => 'package:orm_flutter/orm_flutter.dart',
      _ => 'package:orm/engines/binary.dart',
    };
  }

  String get engineName {
    return switch (isFlutterEngineType(options.generator.config)) {
      true => 'PrismaQueryEngine',
      _ => 'BinaryEngine',
    };
  }
}

extension on String {
  String literal() {
    return replaceAll('\'', '\\\'')
        .replaceAll('\n', '\\n')
        .replaceAll('\r\n', '\n');
  }
}
