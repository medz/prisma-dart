// ignore_for_file: file_names

import '../input/input.dart';
import '_internal/action_helpers.dart';
import 'action.dart';

extension Action$Upsert<Unserialized, Model, Where, OrderBy, Cursor, Pagination,
        Distinct, Having, Create extends Input, Update extends Input>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
        Having, Create, Update> {
  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Create, Update> create(Create input) => fromWith('create', input);

  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Create, Update> update(Create input) => fromWith('update', input);
}
