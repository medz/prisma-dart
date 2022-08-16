import 'package:prisma_cli/src/generator/ast/ast.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart';

class SchemaEnumTypesBuilder extends CodeableAst {
  SchemaEnumTypesBuilder(super.ast);

  @override
  String get codeString {
    final StringBuffer enumCodes = StringBuffer();
    enumCodes.writeln(_enumBuilder(ast.dmmf.schema.enumTypes.prisma));
    enumCodes.writeln(_enumBuilder(ast.dmmf.schema.enumTypes.model ?? []));

    return enumCodes.toString();
  }

  /// Enum builder.
  String _enumBuilder(List<SchemaEnum> enumTypes) {
    final StringBuffer enumCodes = StringBuffer();
    for (final element in enumTypes) {
      enumCodes.writeln('enum ${element.name} implements PrismaEnum {');
      for (final String value in element.values) {
        enumCodes
            .writeln('  ${fieldName(value)}(\'$value\'),');
      }
      enumCodes.writeln(';');
      enumCodes.writeln('  @override');
      enumCodes.writeln('  final String value;');
      enumCodes.writeln('  const ${className(element.name)}(this.value);');
      enumCodes.writeln('}');
    }

    return enumCodes.toString();
  }

  
}
