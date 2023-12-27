// ignore_for_file: file_names

import '../input/input.dart';
import '_internal/action_helpers.dart';
import 'action.dart';

extension Action$Where<Unserialized, Model, Where extends Input, OrderBy,
        Cursor, Pagination, Distinct, Having, Create, Update>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
        Having, Create, Update> {
  /// Returns a new [Action<Unserialized, Model, Where>] with the specified
  /// [Where] into the [arguments].
  ///
  /// ```dart
  /// final action = prisma.user.findMany().where(
  ///   UserWhereInput.id(1)
  /// );
  /// ```
  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Create, Update> where(Where where) => fromWith('where', where);
}
