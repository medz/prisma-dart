// ignore_for_file: file_names

import '../input/input.dart';
import 'action.dart';

extension Action$Where<Unserialized, Model, Where extends Input>
    on Action<Unserialized, Model, Where> {
  /// Returns a new [Action<Unserialized, Model, Where>] from raw [arguments].
  ///
  /// ```dart
  /// final user = await prisma.user.findMany().from({...});
  /// ```
  Action<Unserialized, Model, Where> from(Map<String, dynamic> arguments) {
    return Action<Unserialized, Model, Where>(
      factory: factory,
      arguments: arguments,
    );
  }
}
