// ignore_for_file: file_names

import 'action+from.dart';
import 'action.dart';

extension Action$Pagination<Unserialized, Model, Where, OrderBy, Cursor,
        Distinct, Having, Create, Update, Many>
    on Action<Unserialized, Model, Where, OrderBy, Cursor, bool, Distinct,
        Having, Create, Update, Many> {
  Action<Unserialized, Model, Where, OrderBy, Cursor, bool, Distinct, Having,
      Create, Update, Many> take(int value) {
    return from({
      ...arguments,
      'take': value,
    });
  }

  Action<Unserialized, Model, Where, OrderBy, Cursor, bool, Distinct, Having,
      Create, Update, Many> skip(int value) {
    return from({
      ...arguments,
      'skip': value,
    });
  }
}
