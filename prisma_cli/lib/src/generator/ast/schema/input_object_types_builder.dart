import 'package:prisma_dmmf/prisma_dmmf.dart';

import '../ast.dart';

class InputObjectTypesBuilder extends CodeableAst {
  InputObjectTypesBuilder(super.ast);

  @override
  String get codeString {
    final StringBuffer inputObjectTypes = StringBuffer();
    inputObjectTypes.writeln(
        _inputObjectTypesBuilder(ast.dmmf.schema.inputObjectTypes.prisma));
    inputObjectTypes.writeln(
        _inputObjectTypesBuilder(ast.dmmf.schema.inputObjectTypes.model ?? []));

    return inputObjectTypes.toString();
  }

  /// Input object types builder.
  /// This is a helper method to generate input object types.
  String _inputObjectTypesBuilder(List<InputType> inputObjectTypes) {
    final StringBuffer inputObjectTypesCode = StringBuffer();
    for (final InputType element in inputObjectTypes) {
      inputObjectTypesCode.writeln('class ${className(element.name)} {');
      inputObjectTypesCode.writeln(_buildConstructor(element));
      inputObjectTypesCode.writeln(_buildFields(element));
      inputObjectTypesCode.writeln(_buildEntity(element.fields));
      inputObjectTypesCode.writeln('}');
    }

    return inputObjectTypesCode.toString();
  }

  /// Builds the constructor for the model.
  String _buildConstructor(InputType type) {
    final StringBuffer code = StringBuffer();
    code.writeln('  const ${type.name}({');
    for (final field in type.fields) {
      code.writeln(
          ' ${addRequired(field.isRequired)}this.${fieldName(field.name)},');
    }
    code.writeln('  });');
    return code.toString();
  }

  /// Build model fields.
  String _buildFields(InputType type) {
    final StringBuffer code = StringBuffer();
    for (final SchemaArg field in type.fields) {
      code.writeln('  @JsonKey(name: \'${field.name}\' )');
      code.writeln(
          '  final ${fieldSchemaArgTypeBuilder(field)}${addNullable(!field.isRequired)} ${fieldName(field.name)};');
    }

    return code.toString();
  }

  /// Build toJson method.
  String addListAtNull(bool isNullable) {
    return isNullable ? "??[]" : "";
  }

  String _buildEntity(List<SchemaArg> fields) {
    final StringBuffer code = StringBuffer();

    code.write("List<Entity> toEntity()=>[");
    for (var field in fields) {
      final name = fieldName(field.name);

      final inputType = resolveSchemaType(field.inputTypes);
      final isList =
          field.inputTypes.where((element) => element.isList).isNotEmpty;
      if (!field.isRequired) {
        code.write("if($name !=null)");
      }
      final usedName = "$name${addNoNull(field.isRequired)}";
      if (inputType.location.name == "enumTypes") {
        code.write("$usedName.toEntity(),");
        continue;
      }
      code.write("Entity(");
      code.write(""""${field.name}",""");
      if (inputType.location.name == "scalar") {
        code.write("true,");
        code.write(usedName);
        code.write(',null');
      } else if (inputType.location.name == "enumTypes") {
        code.write("false,");
        if (isList) {
          code.write('''$usedName.map((e) =>e.value).toList()''');
          code.write(',null');
        } else {
          code.write("$usedName.value");
          code.write(',[]');
        }
      } else {
        code.write("false,null,");
        if (isList) {
          code.write(
              '''$usedName.map((e) => Entity("${field.name}", false, null, e.toEntity())).toList()''');
        } else {
          code.write("$usedName.toEntity()");
        }
      }
      code.write(",");
      code.write("),");
    }
    code.write("];");
    return code.toString();
  }
}
