// ignore_for_file: file_names

import '../input/input.dart';
import '_internal/action_helpers.dart';
import 'action.dart';

extension Action$Cursor<Unserialized, Model, Where, OrderBy,
        Cursor extends Input, Pagination, Distinct, Having, Create, Update>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
        Having, Create, Update> {
  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Create, Update> cursor(Cursor input) => fromWith('cursor', input);
}
