// ignore_for_file: file_names

import '../input/input.dart';
import '_internal/action_helpers.dart';
import 'action.dart';

/// Specify the data of `create` or `update` action.
extension Action$Data<Unserialized, Model, Where, OrderBy, Cursor, Pagination,
        Distinct, Having, Create extends Input>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
        Having, Create, Null> {
  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Create, Null> data(Create input) => fromWith('data', input);
}
