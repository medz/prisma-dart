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
      inputObjectTypesCode.writeln(
          '@JsonSerializable(explicitToJson: true, createFactory: false, createToJson: true)');
      inputObjectTypesCode.writeln('class ${className(element.name)} {');
      inputObjectTypesCode.writeln(_buildConstructor(element));
      inputObjectTypesCode.writeln(_buildFields(element));
      inputObjectTypesCode.writeln(_buildToJson(element));
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
  String _buildToJson(InputType type) {
    final StringBuffer code = StringBuffer();
    code.write(
        '  Map<String, dynamic> toJson() => _\$${type.name}ToJson(this)');
    code.writeln('..addAll({');
    code.writeln(
        '    \'_\\\$maxNumFields\': ${type.constraints?.maxNumFields},');
    code.writeln(
        '    \'_\\\$minNumFields\': ${type.constraints?.minNumFields},');
    code.writeln('  });');
    return code.toString();
  }
}
