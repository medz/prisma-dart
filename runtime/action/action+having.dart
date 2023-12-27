// ignore_for_file: file_names

import '../input/input.dart';
import '../model_scalar.dart';
import '_internal/action_helpers.dart';
import 'action+from.dart';
import 'action.dart';
import 'action_options.dart';

extension Action$Having<I extends Input, By extends ModelScalar, U, T,
    O extends ActionHavingOption<I, By>> on Action<U, T, O> {
  Action<U, T, O> having(I input) => fromWith('having', input);

  Action<U, T, O> by(By value) {
    return switch (arguments['by']) {
      String previous => from({
          ...arguments,
          'by': [previous, value.name],
        }),
      Iterable<String> previous => from({
          ...arguments,
          'by': [...previous, value.name],
        }),
      _ => from({...arguments, 'by': value.name}),
    };
  }
}
