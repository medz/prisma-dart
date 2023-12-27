// ignore_for_file: file_names

import '../input/input.dart';
import '_internal/action_helpers.dart';
import 'action+from.dart';
import 'action.dart';

extension Action$OrderBy<OrderBy extends Input, Unserialized, Model, Where,
        Cursor, Pagination, Distinct>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination,
        Distinct> {
  /// Returns a new [Action] with the order by into the [arguments].
  Action<Unserialized, Model, Where, OrderBy, Cursor, Pagination, Distinct>
      orderBy(OrderBy input) {
    final value = deserializeInput(input);

    return switch (arguments['orderBy']) {
      Map previous => from({
          ...arguments,
          'orderBy': [previous, value],
        }),
      Iterable previous => from({
          ...arguments,
          'orderBy': [...previous, value],
        }),
      _ => from({...arguments, 'orderBy': value}),
    };
  }
}
