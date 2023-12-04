import '../_internal/merge_action_args.dart';
import '../action.dart';
import '../json_convertible.dart';

abstract interface class Where<T> {}

extension WhereAction<T, W extends JsonConvertible> on Action<T, Where<W>> {
  Action<T, Where<W>> where(W where) => merge({'where': where});
}
