import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/orm.dart' show languageKeywordEncode;

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
    code.writeln('class ${languageKeywordEncode(type.name)} {');

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
    code.write(' ${languageKeywordEncode(field.name)}');

    // Line end.
    code.writeln(';');
  }

  return code.toString();
}

/// Build constructor.
String _constructorBuilder(dmmf.OutputType type) {
  final StringBuffer code = StringBuffer();
  code.writeln('const ${languageKeywordEncode(type.name)}({');

  for (final dmmf.SchemaField field in type.fields) {
    if (field.name == '_count') {
      continue;
    }
    if (field.isNullable == false) {
      code.write('required ');
    }
    code.writeln('this.${languageKeywordEncode(field.name)},');
  }
  code.writeln('});');
  return code.toString();
}
