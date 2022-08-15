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
        'static const  _outputField = [${model.fields.where((element) => element.relationName == null).map((e) => 'Output("${e.name}",[],[])').join(',')}];');
    final fields = <SchemaFieldWithAction>[];
    for (var e in ModelAction.values) {
      final name = mapping[e.name];
      if (name == null) continue;
      final queryField = queryFieldMap[name];
      final mutationField = mutationFieldMap[name];
      final field = mutationField ?? queryField;
      if (field == null) {
        throw Exception(
            "Oops this must not happen. Could not find field $fieldName on either Query or Mutation");
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
          'Future<${addList(returnType, field.outputType.isList)}${addNullable(field.isNullable ?? false)}> ${item.action.name}('); //TODO handle return type nullable
      if (field.args.isNotEmpty) code.writeln("{");
      for (var arg in field.args) {
        code.writeln(
            '    ${addRequired(arg.isRequired)} ${fieldSchemaArgTypeBuilder(arg)}${addNullable(!arg.isRequired || arg.isNullable)} ${fieldName(arg.name)},');
      }
      if (field.args.isNotEmpty) code.writeln("}");

      code.write(')');
      code.writeln("{");
      code.writeln(_buildEntity(item.field.args));

      code.writeln(_buildQuertBuilder(item.action.name, item.operation,
          returnType, field.outputType.isList, field.isNullable ?? false));
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
      entity:entity,
      output: _outputField,
      name: ""
    );
    return query.exec().then((value) {
      ${fromJsonOutput(returnType, isOutputList, isNullable)}
   }
     );     
''';
  }

  String _buildEntity(List<SchemaArg> fields) {
    final StringBuffer code = StringBuffer();

    code.write("final entity=[");
    for (var field in fields) {
      final name = fieldName(field.name);

      final inputType = resolveSchemaType(field.inputTypes);
      final isList =
          field.inputTypes.where((element) => element.isList).isNotEmpty;
      if (!field.isRequired) {
        code.write("if($name !=null)");
      }
      code.write("Entity(");
      code.write(""""${field.name}",""");
      if (inputType.location.name == "scalar") {
        code.write("true,");
        code.write(name);
        code.write(',null');
      } else if (inputType.location.name == "enumTypes") {
        code.write("false,");
        if (isList) {
          code.write('''$name.map((e) =>e.value).toList()''');
          code.write(',null');
        } else {
          code.write("$name.value");
          code.write(',[]');
        }
      } else {
        code.write("false,null,");
        if (isList) {
          code.write(
              '''$name.map((e) => Entity("${field.name}", false, null, e.toEntity())).toList()''');
        } else {
          code.write("$name.toEntity()");
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
  final ModelAction action;
  final String operation;

  SchemaFieldWithAction(this.action, this.field, this.operation);
}
