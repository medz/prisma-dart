import 'came_case.dart';
import 'dart_keywords.dart';

/// Build Dart style field.
String dartStyleField(String value) {
  final String result = dartKeywordFix(value);

  return lowerCamelCase(result);
}
