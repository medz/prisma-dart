import 'package:prisma_dmmf/prisma_dmmf.dart';

import '../ast.dart';

class OutputObjectTypesBuilder extends CodeableAst {
  OutputObjectTypesBuilder(super.ast);

  @override
  String get codeString {
    final StringBuffer outputObjectTypes = StringBuffer();
    bool whereNotQueryMutation(OutputType type) {
      return type.name != "Query" && type.name != "Mutation";
    }

    outputObjectTypes.writeln(_outputObjectTypesBuilder(
        ast.dmmf.schema.outputObjectTypes.prisma.where(whereNotQueryMutation)));
    outputObjectTypes.writeln(_outputObjectTypesBuilder(
        ast.dmmf.schema.outputObjectTypes.model.where(whereNotQueryMutation)));

    return outputObjectTypes.toString();
  }

  /// Output object types builder.
  /// This is a helper method to generate output object types.
  String _outputObjectTypesBuilder(Iterable<OutputType> outputObjectTypes) {
    final StringBuffer outputObjectTypesCode = StringBuffer();
    for (final OutputType element in outputObjectTypes) {
      outputObjectTypesCode.writeln(
          '@JsonSerializable(explicitToJson: true, createFactory: true, createToJson: true)');
      outputObjectTypesCode.writeln('class ${className(element.name)} {');
      outputObjectTypesCode.writeln(_buildConstructor(element));
      outputObjectTypesCode.writeln(_buildFields(element));
      outputObjectTypesCode.writeln(_buildFromJson(element));
      outputObjectTypesCode.writeln(_buildToJson(element));
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
          '   ${addRequired(!(field.isNullable ?? false))} this.${fieldName(field.name)},');
    }
    code.writeln('  });');
    return code.toString();
  }

  /// Build model fields.
  String _buildFields(OutputType type) {
    final StringBuffer code = StringBuffer();
    for (final field in type.fields) {
      code.writeln('  @JsonKey(name: \'${field.name}\' )');
      code.writeln(
          '  final ${schemaTypeTypeBuilder(field.outputType)}${addNullable(field.isNullable ?? false)} ${fieldName(field.name)};');
    }

    return code.toString();
  }

  /// Build fromJson factory .
  String _buildFromJson(OutputType type) {
    final StringBuffer code = StringBuffer();
    code.writeln(
        '  factory ${className(type.name)}.fromJson(Map<String, dynamic> json) =>');
    code.writeln('    _\$${className(type.name)}FromJson(json);');
    return code.toString();
  }

  /// Build fromJson factory .
  String _buildToJson(OutputType type) {
    final StringBuffer code = StringBuffer();
    code.writeln(
        '      Map<String, dynamic> toJson() => _\$${className(type.name)}ToJson(this);');
    return code.toString();
  }
}
