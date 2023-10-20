import '../_internal/iterable_extension.dart';
import '../dmmf.dart' as dmmf;
import '../engines/common/errors/engine_validation_error.dart';
import '../runtime/error_format.dart';
import '../runtime/errors/validation_error.dart';
import 'model_action.dart';

class SerializeContext {
  final dmmf.Datamodel datamodel;
  final String originalMethod;
  final Map? rootArgs;
  final Iterable<String> selectionPath;
  final Iterable<String> argumentPath;
  final String? modelName;
  final ModelAction action;
  final ErrorFormat errorFormat;
  final String clientVersion;

  const SerializeContext({
    required this.datamodel,
    required this.originalMethod,
    this.rootArgs,
    required this.selectionPath,
    required this.argumentPath,
    this.modelName,
    required this.action,
    required this.errorFormat,
    required this.clientVersion,
  });

  /// Reurns current model by [modelName].
  dmmf.Model? get model {
    if (modelName == null) return null;

    return datamodel.models.firstWhereOrNull(
      (model) => model.name == modelName,
    );
  }

  Never throwValidationError(ValidationError error) {
    // TODO: implement throwValidationError
    throw UnimplementedError();
  }

  bool isRawAction() => const <ModelAction>[
        ModelAction.executeRaw,
        ModelAction.queryRaw,
        ModelAction.runCommandRaw,
        ModelAction.findRaw,
        ModelAction.aggregateRaw,
      ].contains(action);

  dmmf.Field? findField(String name) =>
      model?.fields.firstWhereOrNull((element) => element.name == name);

  OutputTypeDescription? getOutputTypeDescription() {
    if (model == null || modelName == null) return null;

    return OutputTypeDescription(
      name: modelName!,
      fields: model!.fields
          .map((field) => OutputTypeDescriptionField(
                name: field.name,
                typeName: 'bool',
                isRelation: field.kind == dmmf.FieldKind.object,
              ))
          .toList(),
    );
  }

  SerializeContext nestSelection(String fieldName) {
    final field = findField(fieldName);
    final modelName = field?.kind == dmmf.FieldKind.object ? field?.type : null;

    return SerializeContext(
      datamodel: datamodel,
      originalMethod: originalMethod,
      rootArgs: rootArgs,
      selectionPath: [...selectionPath, fieldName],
      argumentPath: argumentPath,
      modelName: modelName,
      action: action,
      errorFormat: errorFormat,
      clientVersion: clientVersion,
    );
  }

  SerializeContext nestArgument(String fieldName) => SerializeContext(
        datamodel: datamodel,
        originalMethod: originalMethod,
        rootArgs: rootArgs,
        selectionPath: selectionPath,
        argumentPath: [...argumentPath, fieldName],
        modelName: modelName,
        action: action,
        errorFormat: errorFormat,
        clientVersion: clientVersion,
      );

  List<String> getSelectionPath() => selectionPath.toList();
  List<String> getArgumentPath() => argumentPath.toList();

  String? getArgumentName() => argumentPath.firstOrNull;
}
