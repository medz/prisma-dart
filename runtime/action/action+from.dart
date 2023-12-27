// ignore_for_file: file_names

import 'action.dart';

extension Action$From<Where, Unserialized, Model, OrderBy, Cursor, Pagination,
        Distinct, Having, Create, Update, Many>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
        Having, Create, Update, Many> {
  /// Returns a new [Action] from raw [arguments].
  ///
  /// ```dart
  /// final user = await prisma.user.findMany().from({...});
  /// ```
  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Create, Update, Many> from(
    Map<String, dynamic> arguments,
  ) =>
      Action(factory: factory, arguments: arguments);
}