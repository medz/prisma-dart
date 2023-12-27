// ignore_for_file: file_names

import 'action.dart';

extension Action$From<U, T, O> on Action<U, T, O> {
  /// Returns a new [Action] from raw [arguments].
  ///
  /// ```dart
  /// final user = await prisma.user.findMany().from({...});
  /// ```
  Action<U, T, O> from(Map<String, dynamic> arguments) =>
      Action(factory: factory, arguments: arguments);
}
