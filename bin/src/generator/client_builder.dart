import 'dart:convert';

import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/generator_helper.dart' as helper;
import 'package:orm/orm.dart' as runtime;

import 'generator_options.dart';
import 'model_delegate_builder.dart' show delegateNameBuilder;

String clientBuilder(GeneratorOptions options) {
  return '''
/// Prisma schema DMMF json string.
const String _dmmfStr = r'${json.encode(options.dmmf.toJson())}';

/// Prisma schema DMMF.
final dmmf.Document _dmmf = dmmf.Document.fromJson(convert.json.decode(_dmmfStr));

/// Prisma query engine executable.
const String _executable = '${options.executable}';

/// Prisma schema as string.
final String _schema = convert.json.decode(${json.encode(options.schema)});

${_datasourcesBuilder(options.datasources)}

/// Prisma client.
class PrismaClient {
  final runtime.Engine _engine;

  const PrismaClient._(this._engine);

  factory PrismaClient({
    Datasources? datasources,
  }) {

    final runtime.Engine engine = runtime.BinaryEngine(
      datasources: datasources?.toOverwrites() ?? const <String, runtime.Datasource> {},
      dmmf: _dmmf,
      schema: _schema,
      environment: configure.environment,
      executable: _executable,
    );

    return PrismaClient._(engine);
  }

  ${_modelDelegateGetters(options.dmmf.mappings.modelOperations)}
}
''';
}

/// Data sources builder.
String _datasourcesBuilder(List<helper.DataSource> datasources) {
  return '''
class Datasources {
  ${_datasourcesFieldsBuilder(datasources)}

  ${_datasourcesConstructorBuilder(datasources)}

  ${_datasourcesToOverwritesBuilder(datasources)}
}
''';
}

/// Data sources to overwrite builder.
String _datasourcesToOverwritesBuilder(List<helper.DataSource> datasources) {
  final StringBuffer buffer = StringBuffer();
  buffer.writeln('Map<String, runtime.Datasource> toOverwrites() {');
  buffer.writeln(
      'final Map<String, runtime.Datasource> overwrites\$ = <String, runtime.Datasource>{};');
  for (final helper.DataSource ds in datasources) {
    buffer.writeln('''
  if (${runtime.languageKeywordEncode(ds.name)} != null) {
    overwrites\$['${ds.name}'] = ${runtime.languageKeywordEncode(ds.name)}!;
  }
''');

    if (ds.url.fromEnvVar != null && ds.url.fromEnvVar?.isNotEmpty == true) {
      buffer.writeln('''
  else {
    overwrites\$['${ds.name}'] = runtime.Datasource(
      url: 'env("${ds.url.fromEnvVar}")'
    );
  }
''');
    }
  }

  buffer.writeln('return overwrites\$;');
  buffer.writeln('}');

  return buffer.toString();
}

/// Data sources constructor builder.
String _datasourcesConstructorBuilder(List<helper.DataSource> datasources) {
  return '''
  const Datasources({
    ${datasources.map((ds) => 'this.${runtime.languageKeywordEncode(ds.name)}').join(',\n')}
  });
''';
}

/// Data sources fields builder.
String _datasourcesFieldsBuilder(List<helper.DataSource> datasources) {
  final StringBuffer buffer = StringBuffer();
  for (final helper.DataSource datasource in datasources) {
    runtime.languageKeywordEncode(datasource.name);
    buffer.writeln(
        'final runtime.Datasource? ${runtime.languageKeywordEncode(datasource.name)};');
    buffer.writeln();
  }

  return buffer.toString();
}

/// Returns model delegate getters.
String _modelDelegateGetters(List<dmmf.ModelMapping> mappings) {
  final StringBuffer buffer = StringBuffer();
  for (final dmmf.ModelMapping mapping in mappings) {
    final String name = runtime.languageKeywordEncode(mapping.model);
    final String delegateName = delegateNameBuilder(name);
    buffer.writeln('/// $name model delegate.');
    buffer.writeln(
        '$delegateName get ${_firstLetterLowercase(name)} => $delegateName(engine: _engine, document: _dmmf);');
    buffer.writeln();
  }
  return buffer.toString();
}

/// First letter of [name] is lowercased.
String _firstLetterLowercase(String name) {
  return '${name[0].toLowerCase()}${name.substring(1)}';
}
