// ignore_for_file: file_names

import 'action+from.dart';
import 'action.dart';
import 'action_options.dart';

extension Action$Pagination<U, T, O extends ActionPaginationOption>
    on Action<U, T, O> {
  Action<U, T, O> take(int value) {
    return from({
      ...arguments,
      'take': value,
    });
  }

  Action<U, T, O> skip(int value) {
    return from({
      ...arguments,
      'skip': value,
    });
  }
}
