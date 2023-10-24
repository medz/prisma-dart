import 'dart:typed_data';

import '../operation.dart';
import '../where_builder.dart';

extension BytesFilter<R, N> on WhereBuilder<R, ByteBuffer, N> {
  Operation<R, ByteBuffer, N> get equals => Operation.create('equals', factory);
  Operation<R, Iterable<ByteBuffer>, N> get $in =>
      Operation.create('in', factory);
  Operation<R, Iterable<ByteBuffer>, N> get notIn =>
      Operation.create('notIn', factory);
  WhereBuilder<R, ByteBuffer, N> get not => WhereBuilder.create('not', factory);
}
