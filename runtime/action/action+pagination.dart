// ignore_for_file: file_names

import 'action+from.dart';
import 'action.dart';

extension Action$Pagination<Unserialized, Model, Where, OrderBy, Cursor,
        Distinct>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, bool, Distinct> {
  Action<Unserialized, Model, Where, OrderBy, Cursor, bool, Distinct> take(
      int value) {
    return from({
      ...arguments,
      'take': value,
    });
  }

  Action<Unserialized, Model, Where, OrderBy, Cursor, bool, Distinct> skip(
      int value) {
    return from({
      ...arguments,
      'skip': value,
    });
  }
}
