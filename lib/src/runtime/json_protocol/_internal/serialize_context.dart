import 'package:orm/src/_internal/extension.dart';

import '../../errors/prisma_validation_error.dart';

const _rawActions = {
  'executeRaw',
  'queryRaw',
  'runCommandRaw',
  'findRaw',
  'aggregateRaw',
};

class SerializeContext {
  final Map datamodel;
  final String? modelName;
  final Iterable<String> selectionPath;
  final Iterable<String> argumentPath;
  final String action;

  const SerializeContext({
    required this.datamodel,
    this.modelName,
    this.selectionPath = const [],
    this.argumentPath = const [],
    required this.action,
  });

  /// Returns a new [SerializeContext] with the given [selectionPath] added.
  SerializeContext nestSelection(String selection) {
    final field = findField(selection);
    final String? modelName =
        field?['kind'] == 'object' ? field!['type'] : null;

    return SerializeContext(
      datamodel: datamodel,
      modelName: modelName,
      selectionPath: [...selectionPath, selection],
      argumentPath: argumentPath,
      action: action,
    );
  }

  /// Returns a new [SerializeContext] with the given [argumentPath] added.
  SerializeContext nestArgument(String argument) {
    return SerializeContext(
      datamodel: datamodel,
      modelName: modelName,
      selectionPath: selectionPath,
      argumentPath: [...argumentPath, argument],
      action: action,
    );
  }

  /// Throws a [PrismaValidationError] with the given [error].
  Never throwValidationError([String? message]) => throw PrismaValidationError(
        selectionPath: selectionPath.toList(),
        argumentPath: argumentPath.toList(),
        action: action,
      );

  Map<String, dynamic>? get model => datamodel['models']?[modelName];

  bool isRawAction() => _rawActions.contains(action);

  Map<String, dynamic>? findField(String name) {
    final Iterable<Map> fields = model?['fields'];

    return fields
        .firstWhereOrNull((element) => element['name'] == name)
        ?.cast();
  }
}
