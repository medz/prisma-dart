import 'package:orm/dmmf.dart' as dmmf;

import '../utils/came_case.dart';

/// Input field name.
String _fieldName(String name) {
  if (['AND', 'OR', 'NOT'].contains(name)) return name;

  return lowerCamelCase(name);
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
  // for (final dmmf.InputType element in inputObjectTypes) {
  //   code.writeln('class ${className(element.name)} implements ToField  {');
  //   code.writeln(_buildConstructor(element));
  //   code.writeln(_buildFields(element));
  //   code.writeln(_buildInput(element.fields));
  //   code.writeln('}');
  // }

  for (final dmmf.InputType input in inputs) {
    // Build class header.
    code.write('class ${upperCamelCase(input.name)} implements');
    code.write(' runtime.JsonSerializable');
    code.writeln(' {');

    // Build constructor.
    code.writeln(_constructorBuilder(input));

    // Build fields.
    code.writeln(_fieldsBuilder(input.fields));

    // Build class end.
    code.writeln('}');
  }

  return code.toString();
}

// Find

/// Build input fields.
String _fieldsBuilder(List<dmmf.SchemaArg> fields) {
  final StringBuffer code = StringBuffer();
  for (final dmmf.SchemaArg field in fields) {
    code.writeln('  @JsonKey(name: \'${field.name}\' )');
    code.write('  final ');
    print(field.inputTypes.map((e) => e.toJson()));
  }

  return code.toString();
}

/// Builds the constructor.
String _constructorBuilder(dmmf.InputType input) {
  final StringBuffer code = StringBuffer();
  code.writeln('  const ${upperCamelCase(input.name)}({');
  for (final dmmf.SchemaArg field in input.fields) {
    code.write('    ');
    if (field.isRequired) code.write('required ');
    code.writeln('this.${_fieldName(field.name)},');
  }
  code.writeln('  });');
  return code.toString();
}
