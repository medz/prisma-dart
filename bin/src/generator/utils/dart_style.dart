import 'package:orm/src/runtime/language_keyword.dart';

/// Fix a dart class name.
///
/// Example:
/// a -> A
/// _a -> $A
/// a_ -> A_
String dartClassnameFixer(String name) {
  final String fixed = languageKeywordEncode(name);

  return _charToUpperCase(fixed, 0);
}

String _charToUpperCase(String name, int index) {
  if (name.length == 1) return name.toUpperCase();

  if (RegExp(r'[a-zA-Z]').hasMatch(name[index])) {
    return name[index].toUpperCase() + name.substring(index + 1);
  } else if ((index + 1) >= name.length) {
    return name;
  }

  return name[index] + _charToUpperCase(name, index + 1);
}
