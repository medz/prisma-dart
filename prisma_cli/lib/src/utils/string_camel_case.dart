/// Format a string to lower camel case.
String firstLowerCamelCase(String str) {
  if (str.isEmpty) return str;
  return str[0].toLowerCase() + str.substring(1);
}
