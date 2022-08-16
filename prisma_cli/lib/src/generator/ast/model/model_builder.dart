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
    var classModelName = '${className(model.name)}Model';
    modelCode.writeln('class $classModelName {');
    modelCode.writeln('  static const String model = "${model.name}";');
    modelCode.writeln("final Engine engine;");
    modelCode.writeln('$classModelName(this.engine);');
    modelCode.writeln(
        'static const  _outputField = [${model.fields.where((element) => element.relationName == null).map((e) => 'Output("${e.name}")').join(',')}];');
    final fields = <SchemaFieldWithAction>[];
    for (var e in mapping.keys) {
      if (e == "model") continue;
      final name = mapping[e];
      if (name == null) continue;
      final queryField = queryFieldMap[name];
      final mutationField = mutationFieldMap[name];
      final field = mutationField ?? queryField;
      if (field == null) {
        throw Exception(
            "Oops this must not happen. Could not find field ${fieldName(name)} on either Query or Mutation");
      }
      fields.add(SchemaFieldWithAction(
          e, field, mutationField == null ? "query" : "mutation"));
    }

    modelCode.writeln(_buildFields(fields));
    modelCode.write("}");
    return modelCode.toString();
  }

  String _buildFields(List<SchemaFieldWithAction> fields) {
    final StringBuffer code = StringBuffer();
    for (final item in fields) {
      final field = item.field;
      final returnType = dynamicTypeBuilder(field.outputType);
      code.write(
          'Future<${addList(returnType, field.outputType.isList)}${addNullable(field.isNullable ?? false)}> ${item.action}('); //TODO handle return type nullable
      if (field.args.isNotEmpty) code.writeln("{");
      for (var arg in field.args) {
        code.writeln(
            '    ${addRequired(arg.isRequired)} ${fieldSchemaArgTypeBuilder(arg)}${addNullable(!arg.isRequired || arg.isNullable)} ${fieldName(arg.name)},');
      }
      if (field.args.isNotEmpty) code.writeln("}");

      code.write(')');
      code.writeln("{");
      code.writeln(_buildInput(item.field.args));

      code.writeln(_buildQuertBuilder(item.action, item.operation, returnType,
          field.outputType.isList, field.isNullable ?? false));
      code.write("}");
    }

    return code.toString();
  }

  String _buildQuertBuilder(String method, String operation, String returnType,
      bool isOutputList, bool isNullable) {
    return '''
    final Query query = Query(
      engine: engine,
      model: model,
      method: "$method",
      operation: "$operation",
      input:input,
      output: _outputField,
      name: ""
    );
    return query.exec().then((value) {
      ${fromJsonOutput(returnType, isOutputList, isNullable)}
   }
     );     
''';
  }

  String _buildInput(List<SchemaArg> fields) {
    final StringBuffer code = StringBuffer();
    code.write("final input=[");
    for (var field in fields) {
      final name = fieldName(field.name);
      final inputType = resolveSchemaType(field.inputTypes);
      final isList =
          field.inputTypes.where((element) => element.isList).isNotEmpty;
      if (!field.isRequired) {
        code.write("if($name !=null)");
      }
      code.write("Input(");
      code.write(""""${field.name}",""");
      code.write(isList);
      code.write(",");

      if (!isList) {
        if (inputType.location == FieldLocation.scalar) {
          code.write(name);
          code.write(',null');
        } else if (inputType.location == FieldLocation.enumTypes) {
          code.write("$name.value");
          code.write(',null');
        } else {
          code.write("null,");
          code.writeln("$name.toFields()");
        }
      } else {
        if (inputType.location == FieldLocation.scalar) {
          code.write("toScalerField($name)");
          code.write(',null');
        } else if (inputType.location == FieldLocation.enumTypes) {
          code.write("toEnumsField($name)");
          code.write(',null');
        } else {
          code.write("null,");
          code.write('''toObjectField($name)''');
        }
      }

      code.write(",");
      code.write("),");
    }
    code.write("];");
    return code.toString();
  }

  String fromJsonOutput(String type, bool isList, bool isNullable) {
    final code = StringBuffer();
    if (!isList) {
      if (isNullable) {
        code.write("if(value.data?.result==null){return null;}");
      }
      code.write(
          "return $type.fromJson(value.data!.result! as Map<String,dynamic>);");
    } else {
      code.write(
          "if(value.data?.result==null) return []; return (value.data!.result! as List).map((e) {${fromJsonOutput(type, false, false)}} ).toList();");
    }
    return code.toString();
  }
}

class SchemaFieldWithAction {
  final SchemaField field;
  final String action;
  final String operation;

  SchemaFieldWithAction(this.action, this.field, this.operation);
}
