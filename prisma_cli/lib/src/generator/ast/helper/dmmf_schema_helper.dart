import 'package:prisma_cli/src/generator/ast/ast.dart';
import 'package:prisma_cli/src/utils/by_key.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart';

typedef Dictionary<T> = Map<String, T>;

abstract class DMMFSchemaHelper {
  Ast get ast;
  Schema get schema=>ast.dmmf.schema;
  late final OutputType queryType;
  late final OutputType mutationType;
  late final Dictionary<OutputType> outputTypeMap;
  late final Dictionary<InputType> inputTypeMap;
  late final Dictionary<SchemaEnum> enumMap;
  late final Dictionary<SchemaField> rootFieldMap;
  DMMFSchemaHelper() {
    outputTypeMap = _getOutputTypeMap();

    queryType = outputTypeMap["Query"]!;
    mutationType = outputTypeMap["Mutation"]!;
    rootFieldMap = _getRootFieldMap();
    enumMap = _getEnumMap();
    inputTypeMap = _getInputTypeMap();
  }
  Dictionary<OutputType> _getOutputTypeMap() {
    return Map.fromEntries([
      ...keyBy(schema.outputObjectTypes.model, (_) => _.name),
      ...keyBy(schema.outputObjectTypes.prisma, (_) => _.name),
    ]);
  }

  Dictionary<InputType> _getInputTypeMap() {
    return Map.fromEntries([
      if (schema.inputObjectTypes.model != null)
        ...keyBy<InputType>(schema.inputObjectTypes.model!, (_) => _.name),
      ...keyBy<InputType>(schema.inputObjectTypes.prisma, (_) => _.name)
    ]);
  }

  Dictionary<SchemaEnum> _getEnumMap() {
    return Map.fromEntries([
      ...keyBy<SchemaEnum>(schema.enumTypes.prisma, (_) => _.name),
      if (schema.enumTypes.model != null)
        ...keyBy<SchemaEnum>(schema.enumTypes.model!, (_) => _.name),
    ]);
  }

  Map<String, SchemaField> _getRootFieldMap() {
    return Map.fromEntries(keyBy<SchemaField>(queryType.fields, (_) => _.name)
        .followedBy(keyBy<SchemaField>(mutationType.fields, (_) => _.name)));
  }
}
