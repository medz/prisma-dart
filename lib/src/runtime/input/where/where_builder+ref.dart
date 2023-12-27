// ignore_for_file: file_names

import '../../reference.dart';
import '../input.dart';
import 'where_builder.dart';

extension WhereBuilder$Ref<
    Where extends Input,
    Value extends Object,
    Ref extends Reference<Value>,
    Filter,
    Nullable> on WhereBuilder<Where, Value, Ref, Filter, Filter> {
  /// Create a where with [Ref] model field reference.
  Where ref(Ref value) => factory(keys, value);
}
