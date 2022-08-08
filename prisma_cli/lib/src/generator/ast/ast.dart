import 'package:prisma_cli/src/utils/naming_fix.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart';

abstract class Ast {
  Ast(this.dmmf);
  final Document dmmf;
}

abstract class CodeableAst {
  final Ast ast;
  const CodeableAst(this.ast);

  String get codeString;

  /// Scalar resolve.
  String scalar(String value) {
    switch (value.toLowerCase()) {
      case 'decimal':
      case 'float':
        return 'double';
      case 'int':
        return 'int';
      case 'boolean':
        return 'bool';
      case "json":
        return 'Map<String,dynamic>';

      case "unsupported":
      case "bytes":
        return "dynamic"; //TODO
    }

    return value;
  }

  String addNullable( bool isNullable) {
    if (isNullable) return "? ";
    return " ";
  }

  String addRequired(bool isRequired) {
    if (isRequired) return "required ";
    return " ";
  }

  /// Field name resolver.
  String fieldName(String name) {
    return name.dartCase;
  }

  /// Class name resolver.
  String className(String name) {
    return name.dartClassCase;
  }

  /// Resolves the input type.
  String resolveInputType(List<SchemaType> inputTypes) {
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
}
