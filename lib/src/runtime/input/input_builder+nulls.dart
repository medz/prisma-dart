// ignore_for_file: file_names

import '../prisma_null.dart';
import 'input.dart';
import 'input_builder.dart';

extension InputBuilder$Nulls<R extends Input, T extends Object, Ref, Filter>
    on InputBuilder<R, T, Ref, Filter, bool> {
  R get nulls => factory(keys, const PrismaNull());
}
