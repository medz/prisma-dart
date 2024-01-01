// ignore_for_file: file_names

import '../input/input.dart';
import '_internal/action_helpers.dart';
import 'action.dart';
import 'action_options.dart';

extension Action$Cursor<U, R, T extends Input, O extends ActionCursorOption<T>>
    on Action<U, R, O> {
  /// Set the cursor argument.
  Action<U, R, O> cursor(T value) => fromWith('cursor', value);
}
