import '../../dmmf/dmmf.dart';

abstract class Ast {
  Ast(this.dmmf);
  final DMMF dmmf;
}

abstract class CodeableAst {
  final Ast ast;
  const CodeableAst(this.ast);

  String get codeString;

  /// Scalar resolve.
  String scalar(String value) {
    switch (value.toLowerCase()) {
      case 'decimal':
        return 'double';
      case 'int':
        return 'int';
    }

    return value;
  }
}
