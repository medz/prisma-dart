// ignore_for_file: file_names

import '../prisma_null.dart';
import 'input.dart';
import 'input_builder.dart';

extension InputBuilder$Nulls<T extends Object, R extends Input>
    on InputBuilder<T, R, bool> {
  R get nulls => factory(keys, const PrismaNull());
}
