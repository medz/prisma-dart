import 'package:prisma_cli/src/utils/dart_keyword.dart';

/// convert prisma naming into dart naming
/// handling if the name is a dart keyword
extension NamingFix on String {
  String get dartCase => _replaceDashWithDollar(_postfixDartKeyword(_camelCase(
      this))); // all keyword start with small letter so only camelCase need to handle keyword
  String get dartClassCase => _upperCamelCase(this);
}

String _camelCase(String str) {
  if (str.isEmpty) return str;
  return str[0].toLowerCase() + str.substring(1);
}

String _upperCamelCase(String str) {
  if (str.isEmpty) return str;
  return str[0].toUpperCase() + str.substring(1);
}

// _all => $all , prisma internal field start with _ , but _ means private in dart
String _replaceDashWithDollar(String str) {
  if (str.isEmpty || str[0] != "_") return str;
  return '\$${str.substring(1)}';
}

/// if => $if ,  postfix dart keyword with $
String _postfixDartKeyword(String str) {
  if (keywords.contains(str)) {
    return "$str\$";
  }
  return str;
}
