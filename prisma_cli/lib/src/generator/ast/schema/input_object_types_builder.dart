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
          '    ${field.isRequired ? 'required ' : ''}this.${fieldName(field.name)},');
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
          '  final ${_fieldTypeBuilder(field)}${!field.isRequired ? '?' : ''} ${fieldName(field.name)};');
    }

    return code.toString();
  }

  /// Class field type builder.
  String _fieldTypeBuilder(SchemaArg field) {
    final String inputType = _resolveInputType(field.inputTypes);
    final bool isList =
        field.inputTypes.where((element) => element.isList).isNotEmpty;
    if (isList) {
      return 'List<$inputType>';
    }

    return inputType;
  }

  /// Resolves the input type.
  String _resolveInputType(List<SchemaType> inputTypes) {
    if (inputTypes.length == 1) {
      return scalar(inputTypes.first.type);
    }

    // remove duplicates
    final List<SchemaType> uniqueInputTypes = inputTypes.toSet().toList();
    if (uniqueInputTypes.length == 1) {
      return scalar(uniqueInputTypes.first.type);
    }

    // remove scalar
    final List<SchemaType> nonScalarInputTypes =
        uniqueInputTypes.where((element) => element.type != 'scalar').toList();
    if (nonScalarInputTypes.length == 1) {
      return scalar(nonScalarInputTypes.first.type);
    }

    return scalar(inputTypes.first.type);
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
