import '../dmmf.dart' as dmmf;
import '../runtime/error_format.dart';
import 'model_action.dart';

class SerializeContext {
  final dmmf.Datamodel datamodel;
  final String originalMethod;
  final Map<String, dynamic>? rootArgs;
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

    return datamodel.models.firstWhere(
      (model) => model.name == modelName,
    );
  }
}
