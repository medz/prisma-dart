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
      // outputObjectTypesCode.writeln(
      //     '@JsonSerializable(explicitToJson: true, createFactory: true, createToJson: false)');
      outputObjectTypesCode.writeln('class ${className(element.name)} {');
      outputObjectTypesCode.writeln(_buildConstructor(element));
      outputObjectTypesCode.writeln(_buildFields(element));
      // outputObjectTypesCode.writeln(_buildFromJson(element));//TODO
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
      code.writeln(
          'final ${_fieldTypeBuilder(field.outputType.type)} Function('); //TODO handle return type nullable
      if (field.args.isNotEmpty) code.write("{");
      for (var arg in field.args) {
        code.writeln(
            '    ${addRequired(!arg.isNullable)} ${resolveInputType(arg.inputTypes)} ${fieldName(arg.name)},');
      }
      if (field.args.isNotEmpty) code.write("}");

      code.writeln(
          ') ${addNullable(field.isNullable ?? false)} ${fieldName(field.name)}  ;');
    }

    return code.toString();
  }

  /// Class field type builder.
  String _fieldTypeBuilder(dynamic object) {
    if (object is String) {
      return scalar(object);
    } else if (object is InputType) {
      return className(object.name);
    } else if (object is SchemaEnum) {
      return className(object.name);
    }
    throw ArgumentError('Unknown type $object');
  }

  // /// Build fromJson factory .
  // String _buildFromJson(OutputType type) {
  //   final StringBuffer code = StringBuffer();
  //   code.writeln(
  //       '  factory ${className(type.name)}.fromJson(Map<String, dynamic> json) =>');
  //   code.writeln('    _\$${className(type.name)}FromJson(json);');
  //   return code.toString();
  // }
}
