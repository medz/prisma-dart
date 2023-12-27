// ignore_for_file: file_names

import 'action+from.dart';
import 'action.dart';

extension Action$Pagination<Unserialized, Model, Where, OrderBy, Cursor,
        Distinct, Having>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, bool, Distinct,
        Having> {
  Action<Unserialized, Model, Where, OrderBy, Cursor, bool, Distinct, Having>
      take(int value) {
    return from({
      ...arguments,
      'take': value,
    });
  }

  Action<Unserialized, Model, Where, OrderBy, Cursor, bool, Distinct, Having>
      skip(int value) {
    return from({
      ...arguments,
      'skip': value,
    });
  }
}
