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
    }

    return value;
  }

  /// Field name resolver.
  String fieldName(String name) {
    return name.dartCase;
  }

  /// Class name resolver.
  String className(String name) {
    return name.dartClassCase;
  }
}
