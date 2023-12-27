// ignore_for_file: file_names

import 'input.dart';
import 'input_builder.dart';

extension InputBuilder$Call<T extends Object, R extends Input, N>
    on InputBuilder<T, R, N> {
  R call(T value) => factory(keys, value);
}
