import 'package:prisma_dmmf/prisma_dmmf.dart';

import '../ast.dart';

class OutputObjectTypesBuilder extends CodeableAst {
  OutputObjectTypesBuilder(super.ast);

  @override
  String get codeString {
    final StringBuffer outputObjectTypes = StringBuffer();
    outputObjectTypes.writeln(
        _outputObjectTypesBuilder(ast.dmmf.schema.outputObjectTypes.prisma));
    outputObjectTypes.writeln(
        _outputObjectTypesBuilder(ast.dmmf.schema.outputObjectTypes.model));

    return outputObjectTypes.toString();
  }

  /// Output object types builder.
  /// This is a helper method to generate output object types.
  String _outputObjectTypesBuilder(List<OutputType> outputObjectTypes) {
    final StringBuffer outputObjectTypesCode = StringBuffer();
    for (final OutputType element in outputObjectTypes) {
      outputObjectTypesCode.writeln(
          '@JsonSerializable(explicitToJson: true, createFactory: true, createToJson: false)');
      outputObjectTypesCode.writeln('class ${element.name} {');
      outputObjectTypesCode.writeln(_buildConstructor(element));
      outputObjectTypesCode.writeln(_buildFields(element));
      outputObjectTypesCode.writeln(_buildFromJson(element));
      outputObjectTypesCode.writeln('}');
    }

    return outputObjectTypesCode.toString();
  }

  /// Builds the constructor for the model.
  String _buildConstructor(OutputType type) {
    final StringBuffer code = StringBuffer();
    code.writeln('  const ${type.name}({');
    for (final field in type.fields) {
      code.writeln(
          '    ${!(field.isNullable ?? false) ? 'required ' : ''}this.${this.field(field.name)},');
    }
    code.writeln('  });');
    return code.toString();
  }

  /// Build model fields.
  String _buildFields(OutputType type) {
    final StringBuffer code = StringBuffer();
    for (final field in type.fields) {
      code.writeln(
          '  final ${_fieldTypeBuilder(field)}${(field.isNullable ?? false) ? '?' : ''} ${this.field(field.name)};');
    }

    return code.toString();
  }

  /// Class field type builder.
  String _fieldTypeBuilder(SchemaField field) {
    final String type = scalar(field.outputType.type);
    final bool isList = field.outputType.isList;
    if (isList) {
      return 'List<$type>';
    }

    return type;
  }

  /// Build fromJson factory .
  String _buildFromJson(OutputType type) {
    final StringBuffer code = StringBuffer();
    code.writeln(
        '  factory ${type.name}.fromJson(Map<String, dynamic> json) =>');
    code.writeln('    _\$${type.name}FromJson(json);');
    return code.toString();
  }
}
