// ignore_for_file: file_names

import '../input/input.dart';
import '../model_scalar.dart';
import '_internal/action_helpers.dart';
import 'action+from.dart';
import 'action.dart';

extension Action$Having<Unserialized, Model, Where, OrderBy, Cursor, Pagination,
        Distinct, Having extends Input, Create, Update>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
        Having, Create, Update> {
  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Create, Update> having(Having input) => fromWith('having', input);
}

extension Action$GroupBy<
        Unserialized,
        Model,
        Where,
        OrderBy,
        Cursor,
        Pagination,
        Distinct extends ModelScalar,
        Having extends Input,
        Create,
        Update>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
        Having, Create, Update> {
  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct,
      Having, Create, Update> by(Distinct input) {
    return switch (arguments['by']) {
      String previous => from({
          ...arguments,
          'by': [previous, input.name],
        }),
      Iterable<String> previous => from({
          ...arguments,
          'by': [...previous, input.name],
        }),
      _ => from({...arguments, 'by': input.name}),
    };
  }
}
