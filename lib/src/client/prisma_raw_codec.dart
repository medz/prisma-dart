import 'dart:convert';

/// Prisma Typed parameter
class PrismaTypedParameter {
  /// The parameter type.
  final String type;

  /// The parameter value.
  final String value;

  /// Create a new instance of [PrismaTypedParameter].
  const PrismaTypedParameter(this.type, this.value);

  /// Create a new instance of [PrismaTypedParameter] from a JSON map.
  factory PrismaTypedParameter.fromJson(Map<String, dynamic> json) {
    return PrismaTypedParameter(
      json['prisma__type'] as String,
      json['prisma__value'] as String,
    );
  }

  /// Create from a [BigInt].
  factory PrismaTypedParameter.fromBigInt(BigInt value) {
    return PrismaTypedParameter('bigint', value.toString());
  }

  /// Create from a [DateTime].
  factory PrismaTypedParameter.fromDateTime(DateTime value) {
    return PrismaTypedParameter('date', value.toIso8601String());
  }

  /// Create from a [double].
  factory PrismaTypedParameter.fromDouble(double value) {
    return PrismaTypedParameter('decimal', value.toString());
  }

  /// Convert the parameter to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'prisma__type': type,
      'prisma__value': value,
    };
  }

  /// Try parse the paramter value.
  static PrismaTypedParameter? tryParse(Map<String, String> json) {
    if (json.containsKey('prisma__type') && json.containsKey('prisma__value')) {
      return PrismaTypedParameter.fromJson(json);
    }
    return null;
  }
}

/// Create a new instance of [PrismaRawParameterCodec].
const prismaRawParameter = PrismaRawParameterCodec();

/// Prisma RAW parameter codec.
class PrismaRawParameterCodec extends Codec<Object?, Object?> {
  /// Create a new instance of [PrismaRawParameterCodec].
  const PrismaRawParameterCodec();

  @override
  Converter<Object?, Object?> get decoder => const PrismaRawParameterDecoder();

  @override
  Converter<Object?, Object?> get encoder => const PrismaRawParameterEncoder();
}

/// Prisma RAW encoder converter.
class PrismaRawParameterEncoder extends Converter<Object?, Object?> {
  /// Create a new instance of [PrismaRawParameterEncoder].
  const PrismaRawParameterEncoder();

  @override
  Object? convert(Object? input) {
    if (input is BigInt) {
      return PrismaTypedParameter.fromBigInt(input);
    } else if (input is DateTime) {
      return PrismaTypedParameter.fromDateTime(input);
    } else if (input is double) {
      return PrismaTypedParameter.fromDouble(input);
    } else if (input is Iterable) {
      return input.map((e) => convert(e)).toList();
    } else if (input is Map) {
      return input.map((key, value) => MapEntry(key, convert(value)));
    }

    return input;
  }
}

/// Prisma RAW parameter decoder.
class PrismaRawParameterDecoder extends Converter<Object?, Object?> {
  /// Create a new instance of [PrismaRawParameterDecoder].
  const PrismaRawParameterDecoder();

  @override
  Object? convert(Object? input) {
    if (input is Map) {
      final parameter = PrismaTypedParameter.tryParse(input.cast());
      if (parameter != null) {
        return _decodeParameter(parameter.type, parameter.value);
      }

      return input.map((key, value) => MapEntry(key, convert(value)));
    } else if (input is Iterable) {
      return input.map((e) => convert(e));
    }

    return input;
  }

  /// Decode a JSON compatible value to a parameter.
  Object _decodeParameter(String type, String value) {
    type = type.toLowerCase().trim();
    final parse = _typedParameterParsers[type];
    if (parse != null) {
      return parse(value);
    }

    return value;
  }

  /// Typed parameter to parses.
  static const _typedParameterParsers = {
    'bigint': BigInt.parse,
    'date': DateTime.parse,
    'datetime': DateTime.parse,
    'decimal': double.parse,
    'int': int.parse,
  };
}
