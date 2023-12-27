// ignore_for_file: file_names

import '../input/input.dart';
import '_internal/action_helpers.dart';
import 'action+from.dart';
import 'action.dart';

/// Specify the data of `create` action
extension Action$Create<Unserialized, Model, Where, OrderBy, Cursor, Pagination,
        Distinct, Having, Create extends Input>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
        Having, Create, Null, Null> {
  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Create, Null, Null> data(Create input) => fromWith('data', input);
}

/// Specify the data of `createMany`
extension Action$CreateMany<Unserialized, Model, Where, OrderBy, Cursor,
        Pagination, Distinct, Having, Create extends Input>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
        Having, Create, Null, bool> {
  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Create, Null, bool> data(Iterable<Create> values) {
    return from({
      ...arguments,
      'data': values.map(deserializeInput),
    });
  }

  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Create, Null, bool> skipDuplicates(bool value) {
    return from({
      ...arguments,
      'skipDuplicates': value,
    });
  }
}

/// `update` or `updateMany` action
extension Action$Update<Unserialized, Model, Where, OrderBy, Cursor, Pagination,
        Distinct, Having, Update extends Input, Many>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
        Having, Null, Update, Many> {
  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Null, Update, Many> data(Update input) => fromWith('data', input);
}
