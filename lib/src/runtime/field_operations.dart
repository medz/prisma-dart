import 'package:decimal/decimal.dart';

import '../core/null_types.dart';
import '../core/prisma_json.dart';
import '../core/prisma_null.dart';
import 'call.dart';

class FieldOperations<R, T, N, IsUpdate> extends Call<R, T, N> {
  const FieldOperations._(super.factory);

  factory FieldOperations(Factory<R> factory, [String? name]) {
    if (name == null || name.isNotEmpty) {
      return FieldOperations._(factory);
    }

    return FieldOperations._((value) => factory({name: value}));
  }
}

extension NullableFieldoperations<R, T, IsUpdate>
    on FieldOperations<R, T, PrismaNull, IsUpdate> {
  R get $null => factory(const PrismaNull());
}

class SetFieldUpdateOperation<R, T, N> extends Call<R, T, N> {
  const SetFieldUpdateOperation._(super.factory);

  factory SetFieldUpdateOperation(Factory<R> factory) =>
      SetFieldUpdateOperation._((value) => factory({'set': value}));
}

extension FieldUpdateOperations<R, T, N> on FieldOperations<R, T, N, bool> {
  SetFieldUpdateOperation<R, T, N> get set => SetFieldUpdateOperation(factory);
}

extension NullableJsonFieldOperations<R, IsUpdate>
    on FieldOperations<R, PrismaJson, PrismaNull, IsUpdate> {
  R get dbNull => factory(const DbNull());
  R get jsonNull => factory(const JsonNull());
}

/// Field operations for [num] types.
extension NumFieldOperations<R, T extends num, N>
    on FieldOperations<R, T, N, bool> {
  R increment(T value) => factory({'increment': value});
  R decrement(T value) => factory({'decrement': value});
  R multiply(T value) => factory({'multiply': value});
  R divide(T value) => factory({'divide': value});
}

/// Field operations for [BigInt] types.
extension BigIntFieldOperations<R, N> on FieldOperations<R, BigInt, N, bool> {
  R increment(BigInt value) => factory({'increment': value});
  R decrement(BigInt value) => factory({'decrement': value});
  R multiply(BigInt value) => factory({'multiply': value});
  R divide(BigInt value) => factory({'divide': value});
}

/// Field operations for [Decimal] types.
extension DecimalFieldOperations<R, N> on FieldOperations<R, Decimal, N, bool> {
  R increment(Decimal value) => factory({'increment': value});
  R decrement(Decimal value) => factory({'decrement': value});
  R multiply(Decimal value) => factory({'multiply': value});
  R divide(Decimal value) => factory({'divide': value});
}
