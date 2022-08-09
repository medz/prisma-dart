import 'package:prisma_cli/src/generator/ast/ast.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart';

class ModelBuilder extends CodeableAst {
  final Model model;
  late final Map<String, String> mapping;
  late final OutputType outputType;
  ModelBuilder(this.model, super.ast) {
    mapping = ast.dmmf.mappings.modelOperations
        .firstWhere((element) => element.model == model.name)
        .toJson()
        .cast<String, String>();
    outputType = outputTypeMap[model.name]!;
  }

  @override
  String get codeString {
    final StringBuffer modelCode = StringBuffer();
    modelCode.writeln('class ${className(model.name)}Model {');
    final fields = <SchemaFieldWithAction>[];
    for (var e in ModelAction.values) {
      final name = mapping[e.name];
      if (name == null) continue;
      final field = rootFieldMap[name];
      if (field == null) {
        throw Exception(
            "Oops this must not happen. Could not find field $fieldName on either Query or Mutation");
      }
      fields.add(SchemaFieldWithAction(e, field));
    }

    modelCode.writeln(_buildFields(fields));
    modelCode.write("}");
    return modelCode.toString();
  }

  String _buildFields(List<SchemaFieldWithAction> fields) {
    final StringBuffer code = StringBuffer();
    for (final item in fields) {
      final field = item.field;
      code.write(
          ' ${schemaTypeTypeBuilder(field.outputType)} ${item.action.name}('); //TODO handle return type nullable
      if (field.args.isNotEmpty) code.writeln("{");
      for (var arg in field.args) {
        code.writeln(
            '    ${addRequired(arg.isRequired)} ${fieldSchemaArgTypeBuilder(arg)}${addNullable(!arg.isRequired || arg.isNullable)} ${fieldName(arg.name)},');
      }
      if (field.args.isNotEmpty) code.writeln("}");

      code.write(')');
      code.writeln("{");
      code.writeln("throw UnimplementedError();");
      code.write("}");
    }

    return code.toString();
  }
}

class SchemaFieldWithAction {
  final SchemaField field;
  final ModelAction action;

  SchemaFieldWithAction(this.action, this.field);
}
