import '../ast.dart';

class UserEnumAst extends CodeableAst {
  UserEnumAst(super.ast);

  @override
  String get codeString {
    final StringBuffer enumCodes = StringBuffer();
    ast.dmmf.datamodel.enums;
    for (final element in ast.dmmf.datamodel.enums) {
      enumCodes.writeln('enum ${element.name} {');
      for (final value in element.values) {
        enumCodes.writeln('  ${value.name},');
      }

      enumCodes.writeln('}');
    }

    return enumCodes.toString();
  }
}
