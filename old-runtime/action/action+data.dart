// ignore_for_file: file_names

import '../input/input.dart';
import '_internal/action_helpers.dart';
import 'action+from.dart';
import 'action.dart';
import 'action_options.dart';

extension Action$Data<I extends Input, U, T,
    O extends ActionDataOption<I, Null>> on Action<U, T, O> {
  Action<U, T, O> data(I value) => fromWith('data', value);
}

extension Action$CreateMany<I extends Input, U, T,
    O extends ActionDataOption<I, bool>> on Action<U, T, O> {
  Action<U, T, O> data(Iterable<I> values) {
    return from({
      ...arguments,
      'data': values.map(Input.deserialize),
    });
  }

  Action<U, T, O> skipDuplicates(bool value) {
    return from({
      ...arguments,
      'skipDuplicates': value,
    });
  }
}
