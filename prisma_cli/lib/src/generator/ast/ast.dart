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
  String field(String name) {
    if (name.isEmpty) return name;
    if (name[0] == '_') return field('\$${name.substring(1)}');
    if (['in', 'default', 'is'].contains(name.toLowerCase())) {
      return '$name\$';
    }
    return name;
  }
}
