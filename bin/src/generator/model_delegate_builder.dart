import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/orm.dart' show languageKeywordEncode;

import 'schema/schema_input_object_generator.dart';
import 'utils/object_field_type.dart';

/// Delegate name builder.
String delegateNameBuilder(String name) {
  return '${languageKeywordEncode(name)}Delegate';
}

String modelDelegateBuilder(dmmf.Document document) {
  final StringBuffer code = StringBuffer();
  for (final dmmf.ModelMapping mapping in document.mappings.modelOperations) {
    final String modelname = languageKeywordEncode(mapping.model);
    final String classname = delegateNameBuilder(modelname);

    // Build class start.
    code.writeln('class $classname {');

    // Build constructor.
    code.writeln('const $classname({');
    code.writeln('  required runtime.Engine engine,');
    code.writeln('  runtime.QueryEngineRequestHeaders? headers,');
    code.writeln('}):');
    code.writeln('_engine = engine,');
    code.writeln('_headers = headers;');
    code.writeln();

    // Build engine field;
    code.writeln('final runtime.Engine _engine;');

    /// Build transaction ID field.
    code.writeln('final runtime.QueryEngineRequestHeaders? _headers;');

    // Build operations.
    code.writeln();
    for (final String operation in mapping.operations) {
      final String? gqlOperationName =
          _findGqlOperationName(mapping, operation);
      if (gqlOperationName == null) {
        continue;
      }

      // Build operation return type.
      final dmmf.SchemaField field = _findField(document, gqlOperationName);
      code.write(_buildDartType(field.outputType, field.isNullable ?? false));
      code.write(' ');

      // Build operation name.
      code.write(languageKeywordEncode(operation));

      // Build operation arguments.
      code.write('(');
      code.write(_buildArguments(document, gqlOperationName));

      // Build operation body.
      code.writeln(') async {');
      code.writeln(_buildBody(document, gqlOperationName, modelname));

      // Build operation end.
      code.writeln('}');
      code.writeln();
    }

    // Build class end.
    code.writeln('}');
  }

  return code.toString();
}

/// Build function body.
String _buildBody(
  dmmf.Document document,
  String gqlOperationName,
  String modelname,
) {
  final List<dmmf.SchemaArg> args =
      _findOperationArgs(document, gqlOperationName);
  final StringBuffer buffer = StringBuffer('''
  final String sdl = runtime.GraphQLField(
    '${_findLocation(document, gqlOperationName)}',
    fields: runtime.GraphQLFields([
      runtime.GraphQLField(
        '$gqlOperationName',
        args: ${_gqlArgsBuilder(args)},
        fields: ${_gqlFieldsBuilder(modelname)},
      ),
    ]),
  ).toSdl();

  final runtime.QueryEngineResult result = await _engine.request(
    query: sdl,
    headers: _headers
  );

''');

  final dmmf.SchemaField field = _findField(document, gqlOperationName);
  final dmmf.SchemaType outputType = field.outputType;

  if (field.isNullable == true) {
    buffer.writeln('''
  if (result.data['$gqlOperationName'] == null) {
    return null;
  }
''');
  }

  if (outputType.isList) {
    buffer.writeln('''
  return (result.data['$gqlOperationName'] as List<dynamic>)
    .map<${languageKeywordEncode(outputType.type)}>(
      (dynamic item) => ${languageKeywordEncode(outputType.type)}.fromJson(item as Map<String, dynamic>),
    ).toList();
''');
    return buffer.toString();
  }

  buffer.writeln('''
  return ${languageKeywordEncode(outputType.type)}.fromJson(result.data['$gqlOperationName'] as Map<String, dynamic>);
''');

  return buffer.toString();
}

/// GraphQL fields builder.
String _gqlFieldsBuilder(String modelname) {
  return '''
runtime.GraphQLFields(
  ${modelname}ScalarFieldEnum.values.map(
    (${modelname}ScalarFieldEnum element) => runtime.GraphQLField(element.name)
  ).toList()
)
''';
}

/// GraphQL args builder.
String _gqlArgsBuilder(List<dmmf.SchemaArg> args) {
  return '''
runtime.GraphQLArgs([
  ${args.map(_gqlArgsChildBuilder).join(',')}
])
''';
}

/// GraphQL args child builder.
String _gqlArgsChildBuilder(dmmf.SchemaArg arg) {
  return '''
runtime.GraphQLArg(
  '${arg.name}',
  ${languageKeywordEncode(arg.name)},
  isRequired: ${arg.isRequired}
)
''';
}

/// Find GraphQL operation location.
String _findLocation(dmmf.Document document, String gqlOperationName) {
  final dmmf.OutputType? query = _findDmmfOutputType(document, 'query');
  for (final dmmf.SchemaField field in query?.fields ?? []) {
    if (field.name == gqlOperationName) {
      return 'query';
    }
  }

  final dmmf.OutputType? mutation = _findDmmfOutputType(document, 'mutation');
  for (final dmmf.SchemaField field in mutation?.fields ?? []) {
    if (field.name == gqlOperationName) {
      return 'mutation';
    }
  }

  throw Exception('Unable to find operation location.');
}

/// Build arguments for operation.
String _buildArguments(dmmf.Document document, String gqlOperationName) {
  final List<dmmf.SchemaArg> args =
      _findOperationArgs(document, gqlOperationName);

  // If no arguments, return empty string.
  if (args.isEmpty) return '';

  final StringBuffer code = StringBuffer('{');
  for (final dmmf.SchemaArg arg in args) {
    // Build required symbol.
    if (arg.isRequired) {
      code.write('required ');
    }

    // Build argument type.
    code.write(fieldTypeBuilder(arg.inputTypes));

    // Build argument is nullable.
    if (!arg.isRequired) {
      code.write('?');
    }

    // Build argument name.
    code.write(' ');
    code.write(languageKeywordEncode(arg.name));
    code.write(',');
  }
  code.write('}');

  return code.toString();
}

/// Find operation arguments.
List<dmmf.SchemaArg> _findOperationArgs(
    dmmf.Document document, String gqlOperationName) {
  final dmmf.OutputType? query = _findDmmfOutputType(document, 'query');

  // Find args in query.
  for (final dmmf.SchemaField field in query?.fields ?? []) {
    if (field.name.toLowerCase() == gqlOperationName.toLowerCase()) {
      return field.args;
    }
  }

  // Find args in mutation.
  final dmmf.OutputType? mutation = _findDmmfOutputType(document, 'mutation');
  for (final dmmf.SchemaField field in mutation?.fields ?? []) {
    if (field.name.toLowerCase() == gqlOperationName.toLowerCase()) {
      return field.args;
    }
  }

  // Default, return empty list.
  return [];
}

// Find GraphQL operation name.
String? _findGqlOperationName(dmmf.ModelMapping mapping, String operation) {
  final Map<String, dynamic> json = mapping.toJson()
    ..removeWhere((key, value) => key != operation);

  if (json.isEmpty) {
    return null;
  }

  return json[operation] as String?;
}

/// Find output field
dmmf.SchemaField _findField(dmmf.Document document, String gqlOperationName) {
  final dmmf.OutputType? query = _findDmmfOutputType(document, 'query');

  // Find output in query.
  for (final dmmf.SchemaField field in query?.fields ?? []) {
    if (field.name.toLowerCase() == gqlOperationName.toLowerCase()) {
      return field;
    }
  }

  // Find output in mutation.
  final dmmf.OutputType? mutation = _findDmmfOutputType(document, 'mutation');
  for (final dmmf.SchemaField field in mutation?.fields ?? []) {
    if (field.name.toLowerCase() == gqlOperationName.toLowerCase()) {
      return field;
    }
  }

  throw Exception('Could not find output type for operation $gqlOperationName');
}

/// Build Dart type.
String _buildDartType(dmmf.SchemaType type, bool isNullable) {
  String dartType = objectFieldType(type);
  if (isNullable) {
    dartType += '?';
  }

  return 'Future<$dartType>';
}

/// Find GraphQL output type
dmmf.OutputType? _findDmmfOutputType(dmmf.Document document, String name) {
  final dmmf.OutputObjectTypes types = document.schema.outputObjectTypes;

  // Find input type in model namespace.
  for (final dmmf.OutputType type in types.model ?? []) {
    if (type.name.toLowerCase() == name.toLowerCase()) {
      return type;
    }
  }

  // Find input type in prisma namespace.
  for (final dmmf.OutputType type in types.prisma) {
    if (type.name.toLowerCase() == name.toLowerCase()) {
      return type;
    }
  }

  return null;
}
