import '../ast.dart';
import 'user_enum_ast.dart';
import 'usermodels_ast.dart';

class DatamodelAst extends CodeableAst {
  DatamodelAst(super.ast);

  @override
  String get codeString {
    final StringBuffer code = StringBuffer();
    code.writeln(UserEnumAst(ast).codeString);
    code.writeln(UsermodelsAst(ast).codeString);

    return code.toString();
  }
}
