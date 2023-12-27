// ignore_for_file: file_names

import 'action.dart';

extension Action$From<U, T, O> on Action<U, T, O> {
  /// Returns a new [Action] from raw [arguments].
  ///
  /// ```dart
  /// final user = await prisma.user.findMany().from({...});
  /// ```
  Action<U, T, O> from(Map<String, dynamic> arguments) {
    return Action(
      factory: factory,
      arguments: arguments,
      datamodel: datamodel,
      action: action,
      model: model,
    );
  }
}
