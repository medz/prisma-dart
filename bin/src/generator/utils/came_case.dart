import 'dart_keywords.dart';

/// Lower camel case.
String lowerCamelCase(String value) {
  // If value is empty, return empty.
  if (value.isEmpty) return value;

  final String result = upperCamelCase(value);
  return result[0].toLowerCase() + result.substring(1);
}

/// Upper camel case.
String upperCamelCase(String value) {
  if (value.isEmpty) return value;

  // Create split pattern.
  final Pattern pattern = RegExp(r'[^a-zA-Z0-9]+');

  // Split string, remove empty elements and join with upper case.
  final parts = value.split(pattern).map((String element) {
    if (element.isEmpty) return element;

    return element[0].toUpperCase() + element.substring(1);
  });

  return dartKeywordFix(parts.join());
}
