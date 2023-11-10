import 'dart:convert';
import 'dart:typed_data';

import 'package:decimal/decimal.dart';

import '../runtime/prisma_null.dart';

abstract base class PrismaValue<T> {
  /// Create a new [PrismaValue] from deserialized value.
  const factory PrismaValue.deserialized(T value) = _DeserializedPrismaValue<T>;

  /// Create a new [PrismaValue] from serialized value.
  const factory PrismaValue.serialized(Object? value) =
      _SerializedPrismaValue<T>;

  /// Returns a serialized value.
  Object? get serialized;

  /// Returns a deserialized value.
  T get deserialized;
}

final class _SerializedPrismaValue<T> implements PrismaValue<T> {
  const _SerializedPrismaValue(this.serialized);

  @override
  final Object? serialized;

  @override
  T get deserialized {
    if (_typed == null) return serialized as T;

    final (type, value) = _typed!;
    final deserialized = switch (type) {
      'bigint' => BigInt.parse(value),
      'decimal' => Decimal.parse(value),
      'bytes' => base64.decode(value),
      'datetime' => DateTime.parse(value),
      'date' => DateTime.parse(value),
      'time' => DateTime.parse('1970-01-01T${value}Z'),
      _ => throw _throwUnsupported(),
    };

    return deserialized as T;
  }

  /// Get serialized type and value.
  (String, String)? get _typed {
    if (serialized
        case {
          'prisma__type': final String type,
          'prisma__value': final String value,
        }) {
      return (type, value);
    } else if (serialized is Map &&
        (serialized as Map).containsKey('prisma__type')) {
      throw _throwUnsupported();
    }

    return null;
  }

  /// Throws unsupported error.
  Never _throwUnsupported() {
    throw UnsupportedError('Unsupported serialized Prisma value: $serialized');
  }
}

final class _DeserializedPrismaValue<T> implements PrismaValue<T> {
  const _DeserializedPrismaValue(this.deserialized);

  @override
  final T deserialized;

  @override
  Object? get serialized {
    return switch (deserialized) {
      // Scalar
      bool() || int() || double() || num() || String() => deserialized,
      PrismaNull() => null,
      BigInt value => _typed('bigint', value.toString()),
      DateTime value => _typed('datetime', value.toUtc().toIso8601String()),
      Decimal value => _typed('decimal', value.toString()),
      Int8List value => _typed('bytes', base64.encode(value)),
      ByteBuffer(asUint8List: final buffer) =>
        PrismaValue.deserialized(buffer).deserialized,
      ByteData(buffer: final buffer) =>
        PrismaValue.deserialized(buffer).deserialized,

      // Iterable
      Iterable iterable =>
        iterable.map((e) => PrismaValue.deserialized(e).serialized),

      // Map
      Map(keys: final keys, values: final values) =>
        Map.fromIterables(keys, PrismaValue.deserialized(values).deserialized),

      // Else
      _ => throw UnsupportedError(
          'Unsupported type: ${deserialized.runtimeType}',
        ),
    };
  }

  /// Create typed Prisma value map.
  Map<String, String> _typed(String type, String value) => {
        'prisma__type': type,
        'prisma__value': value,
      };
}
