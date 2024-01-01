// ignore_for_file: file_names

import 'input.dart';
import 'input_builder.dart';

extension InputBuilder$Call<R extends Input, T extends Object, Ref, Filter, N>
    on InputBuilder<R, T, Ref, Filter, N> {
  R call(T value) => factory(keys, value);
}
