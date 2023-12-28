// ignore_for_file: file_names

import '../input/input.dart';
import 'action+from.dart';
import 'action.dart';
import 'action_options.dart';

extension Action$OrderBy<I extends Input, U, T,
    O extends ActionOrderByOption<I>> on Action<U, T, O> {
  /// Returns a new [Action] with the order by into the [arguments].
  Action<U, T, O> orderBy(I input) {
    final value = Input.deserialize(input);

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
