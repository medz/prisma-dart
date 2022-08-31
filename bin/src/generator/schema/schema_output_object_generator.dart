import 'package:orm/dmmf.dart' as dmmf;

import '../utils/came_case.dart';
import '../utils/dart_style.dart';
import '../utils/object_field_type.dart';

String schemaOutputObjectTypesBuilder(dmmf.OutputObjectTypes types) {
  final StringBuffer code = StringBuffer();

  // Build prisma namespace.
  final String prismaNamespace = _builder(types.prisma);
  if (prismaNamespace.isNotEmpty) {
    code.writeln(prismaNamespace);
  }

  // Build model namespace.
  final String modelNamespace = _builder(types.model ?? []);
  if (modelNamespace.isNotEmpty) {
    code.writeln(modelNamespace);
  }

  return code.toString();
}

/// Build output object types.
String _builder(List<dmmf.OutputType> types) {
  final StringBuffer code = StringBuffer();
  for (final dmmf.OutputType type in types) {
    // Skip query and mutation types.
    if (['query', 'mutation'].contains(type.name.toLowerCase())) continue;

    // Build class header.
    code.writeln('class ${upperCamelCase(type.name)} {');

    // Build constructor.
    code.writeln(_constructorBuilder(type));

    // Build fields.
    code.writeln(_fieldsBuilder(type.fields));

    // Build class end.
    code.writeln('}');
  }

  return code.toString();
}

/// Build fields.
String _fieldsBuilder(List<dmmf.SchemaField> fields) {
  final StringBuffer code = StringBuffer();
  for (final dmmf.SchemaField field in fields) {
    if (field.name.toLowerCase() == '_count') {
      continue;
    }

    // Add final modifier.
    code.write('  final ');

    // Build field type.
    code.write(objectFieldType(field.outputType));

    // Nullable field.
    if (field.isNullable == true) code.write('?');

    // Build field name.
    code.write(' ${_resolveFieldName(field.name)}');

    // Line end.
    code.writeln(';');
  }

  return code.toString();
}

/// Build constructor.
String _constructorBuilder(dmmf.OutputType type) {
  final StringBuffer code = StringBuffer();
  code.writeln('const ${upperCamelCase(type.name)}({');

  for (final dmmf.SchemaField field in type.fields) {
    if (field.name.toLowerCase() == '_count') {
      continue;
    }
    if (field.isNullable == false) {
      code.write('required ');
    }
    code.writeln('this.${_resolveFieldName(field.name)},');
  }
  code.writeln('});');
  return code.toString();
}

/// Output field name resolver.
String _resolveFieldName(String name) {
  switch (name) {
    case '_count':
      return '\$count';
    case '_avg':
      return '\$avg';
    case '_sum':
      return '\$sum';
    case '_min':
      return '\$min';
    case '_max':
      return '\$max';
  }

  return dartStyleField(name);
}
