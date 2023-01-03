import 'dart:convert';

String serializeRawParameters(Iterable<dynamic> parameters) {
  return json.encode(parameters.map((e) => _encodeParameter(e)));
}

/// Encode a parameter to a JSON compatible value.
dynamic _encodeParameter(dynamic parameter) {
  if (parameter is BigInt) {
    return {
      "prisma__type": "bigint",
      "prisma__value": parameter.toString(),
    };
  } else if (parameter is DateTime) {
    return {
      "prisma__type": "date",
      "prisma__value": parameter.toIso8601String(),
    };
  } else if (parameter is double) {
    return {
      "prisma__type": "decimal",
      "prisma__value": parameter.toString(),
    };
  }

  return parameter;
}

dynamic deserializeRawResult(dynamic result) {
  if (result is Map) {
    return (_decodeParameter(result) as Map).map((key, value) => MapEntry(
          key,
          deserializeRawResult(value),
        ));
  } else if (result is Iterable) {
    return result.map((e) => deserializeRawResult(e));
  }

  return result;
}

/// Decode a JSON compatible value to a parameter.
dynamic _decodeParameter(dynamic parameter) {
  if (parameter is Map) {
    if (parameter.containsKey("prisma__type")) {
      final type = parameter["prisma__type"];
      final value = parameter["prisma__value"];

      if (type == "bigint") {
        return BigInt.parse(value);
      } else if (type == "date" || type == "datetime") {
        return DateTime.parse(value);
      } else if (type == "decimal") {
        return double.parse(value);
      } else if (type == 'int') {
        return int.parse(value);
      }

      return value;
    }
  }

  return parameter;
}
