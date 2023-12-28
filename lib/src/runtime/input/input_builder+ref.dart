// ignore_for_file: file_names

import '../reference.dart';
import 'input.dart';
import 'input_builder.dart';

extension InputBuilder$Ref<R extends Input, T extends Object,
    Ref extends Reference<T>, Filter, N> on InputBuilder<R, T, Ref, Filter, N> {
  /// Create a where with [Ref] model field reference.
  R ref(Ref value) => factory(keys, value);
}
