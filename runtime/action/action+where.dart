// ignore_for_file: file_names

import '../input/input.dart';
import '_internal/action_helpers.dart';
import 'action.dart';
import 'action_options.dart';

extension Action$Where<I extends Input, U, T, O extends ActionWhereOption<I>>
    on Action<U, T, O> {
  /// Returns a new [Action<Unserialized, Model, Where>] with the specified
  /// [I] into the [arguments].
  ///
  /// ```dart
  /// final action = prisma.user.findMany().where(
  ///   UserWhereInput.id(1)
  /// );
  /// ```
  Action<U, T, O> where(I input) => fromWith('where', input);
}
