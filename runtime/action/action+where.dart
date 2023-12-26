// ignore_for_file: file_names

import '../input/input.dart';
import 'action+from.dart';
import 'action.dart';

extension Action$Where<Unserialized, Model, Where extends Input>
    on Action<Unserialized, Model, Where> {
  /// Returns a new [Action<Unserialized, Model, Where>] with the specified
  /// [Where] into the [arguments].
  ///
  /// ```dart
  /// final action = prisma.user.findMany().where(
  ///   UserWhereInput.id(1)
  /// );
  /// ```
  Action<Unserialized, Model, Where> where(Where where) {
    final Where($_keys_: keys, $_value_: value) = where;
    final arguments = Map<String, dynamic>.from(this.arguments);

    Map<String, dynamic> current = arguments;
    for (final (index, key) in ['where', ...keys].indexed) {
      if (index == keys.length - 1) {
        current[key] = value;
        break;
      }

      current = current[key] = switch (current[key]) {
        Map<String, dynamic> value => value,
        _ => <String, dynamic>{},
      };
    }

    return from(arguments);
  }
}
