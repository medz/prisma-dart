import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/orm.dart' show languageKeywordEncode;

import '../utils/object_field_type.dart';

/// Input field name.
String _fieldName(String name) {
  if (['AND', 'OR', 'NOT'].contains(name)) return name;

  return languageKeywordEncode(name);
}

Future<String> schemaInputObjectTypesGenerator(
    dmmf.InputObjectTypes types) async {
  final StringBuffer code = StringBuffer();

  // Build prisna namespace.
  final String prismaNamespace = _builder(types.prisma ?? []);
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

/// Builds the input object types.
String _builder(List<dmmf.InputType> inputs) {
  final StringBuffer code = StringBuffer();
  for (final dmmf.InputType input in inputs) {
    // Build class header.
    code.writeln('class ${languageKeywordEncode(input.name)} {');

    // Build constructor.
    code.writeln(_constructorBuilder(input));

    // Build fields.
    code.writeln(_fieldsBuilder(input.fields));

    // Build class end.
    code.writeln('}');
  }

  return code.toString();
}

/// Build input fields.
String _fieldsBuilder(List<dmmf.SchemaArg> fields) {
  final StringBuffer code = StringBuffer();
  for (final dmmf.SchemaArg field in fields) {
    code.write('  final ');
    code.write(fieldTypeBuilder(field.inputTypes));
    if (!field.isRequired) {
      code.write('?');
    }
    code.writeln(' ${_fieldName(field.name)};');
  }

  return code.toString();
}

/// Build input field type.
String fieldTypeBuilder(List<dmmf.SchemaType> types) {
  // If there is only one input type, return the type.
  if (types.length == 1) {
    return objectFieldType(types.first);
  }

  // Remove duplicates.
  final Set<dmmf.SchemaType> uniqueTypes = Set.from(types);
  if (uniqueTypes.length == 1) {
    return objectFieldType(uniqueTypes.first);
  }

  // If unique types length is greater than 2, take the first two.
  final List<dmmf.SchemaType> firstTwoTypes = uniqueTypes.take(2).toList();

  // If the first two types are the same, return `isList` is true type.
  if (firstTwoTypes.first.type == firstTwoTypes.last.type) {
    final Iterable<dmmf.SchemaType> listTypes =
        firstTwoTypes.where((element) => element.isList);
    if (listTypes.length == 1) {
      return objectFieldType(listTypes.first);
    }
  }

  // Build Zore type.
  final String zeroType = objectFieldType(firstTwoTypes.first);

  // Build One type.
  final String oneType = objectFieldType(firstTwoTypes.last);

  // Build union type.
  return 'runtime.PrismaUnion<$zeroType, $oneType>';
}

/// Builds the constructor.
String _constructorBuilder(dmmf.InputType input) {
  final StringBuffer code = StringBuffer();
  code.writeln('  const ${languageKeywordEncode(input.name)}({');
  for (final dmmf.SchemaArg field in input.fields) {
    code.write('    ');
    if (field.isRequired) code.write('required ');
    code.writeln('this.${_fieldName(field.name)},');
  }
  code.writeln('  });');
  return code.toString();
}
