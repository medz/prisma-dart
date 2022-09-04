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
    code.writeln('''
@json_annotation.JsonSerializable(
  createFactory: true,
  createToJson: true,
  explicitToJson: true
)
class ${languageKeywordEncode(type.name)} {
  ${_constructorBuilder(type)}

  factory ${languageKeywordEncode(type.name)}.fromJson(Map<String, dynamic> json) => _\$${languageKeywordEncode(type.name)}FromJson(json);

  ${_fieldsBuilder(type.fields)}

  Map<String, dynamic> toJson() => _\$${languageKeywordEncode(type.name)}ToJson(this);
}
''');
  }

  return code.toString();
}

/// Build fields.
String _fieldsBuilder(List<dmmf.SchemaField> fields) {
  final StringBuffer code = StringBuffer();
  for (final dmmf.SchemaField field in fields) {
    // TODO: 等待 Include 功能完成才允许添加进去
    if (field.name.toLowerCase() == '_count') {
      continue;
    }

    code.writeln('''
@json_annotation.JsonKey(name: '${field.name}')
final ${objectFieldType(field.outputType)}${field.isNullable == true ? '?' : ''}
  ${languageKeywordEncode(field.name)};
''');
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
