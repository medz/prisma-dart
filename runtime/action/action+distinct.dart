// ignore_for_file: file_names

import '../model_scalar.dart';
import 'action+from.dart';
import 'action.dart';
import 'action_options.dart';

extension Action$Distinct<I extends ModelScalar, U, T,
    O extends ActionDistinctOption<I>> on Action<U, T, O> {
  Action<U, T, O> distinct(I value) {
    return switch (arguments['distinct']) {
      String previous => from({
          ...arguments,
          'distinct': [previous, value.name],
        }),
      Iterable<String> previous => from({
          ...arguments,
          'distinct': [...previous, value.name],
        }),
      _ => from({...arguments, 'distinct': value.name}),
    };
  }
}
