import 'package:prisma_cli/src/generator/ast/schema/output_object_types_builder.dart';
import '../ast.dart';
import 'enum_types_builder.dart';
import 'input_object_types_builder.dart';

class SchemaBuilder extends CodeableAst {
  SchemaBuilder(super.ast);

  @override
  String get codeString {
    final StringBuffer schemaCode = StringBuffer();
    schemaCode.writeln(SchemaEnumTypesBuilder(ast).codeString);
    schemaCode.writeln(InputObjectTypesBuilder(ast).codeString);
    schemaCode.writeln(OutputObjectTypesBuilder(ast).codeString);
    return schemaCode.toString();
  }
}
