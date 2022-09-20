import 'package:orm/src/runtime/language_keyword.dart';

/// Fix a dart class name.
///
/// Example:
/// a -> A
/// _a -> $A
/// a_ -> A$
String dartClassnameFixer(String name) {
  final String fixed = languageKeywordEncode(name);

  if (fixed.length == 1) return name.toUpperCase();

  return fixed[0].toUpperCase() + fixed.substring(1);
}
