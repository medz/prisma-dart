/// See https://dart.dev/guides/language/language-tour#keywords
const List<String> _languageKeywords = [
  "abstract",
  "else",
  "import",
  "show",
  "as",
  "enum",
  "in",
  "static",
  "assert",
  "export",
  "interface",
  "super",
  "async",
  "extends",
  "is",
  "switch",
  "await",
  "extension",
  "late",
  "sync",
  "break",
  "external",
  "library",
  "this",
  "case",
  "factory",
  "mixin",
  "throw",
  "catch",
  "false",
  "new",
  "true",
  "class",
  "final",
  "null",
  "try",
  "const",
  "finally",
  "on",
  "typedef",
  "continue",
  "for",
  "operator",
  "var",
  "covariant",
  "Function",
  "part",
  "void",
  "default",
  "get",
  "required",
  "while",
  "deferred",
  "hide",
  "rethrow",
  "with",
  "do",
  "if",
  "return",
  "yield",
  "dynamic",
  "implements",
  "set",
];

/// Dart language keyword encode
String languageKeywordEncode(String name) {
  // If name is language keyword, append `$`;
  if (_languageKeywords.contains(name)) {
    return '$name\$';
  }

  // If starts with `_`, replace `_` with `\$`;
  if (name.startsWith('_')) {
    return '\$${name.substring(1)}';
  }

  return name;
}

/// Dart language keyword decode
String languageKeywordDecode(String name) {
  // If name ends with `$`, remove `$`;
  if (name.endsWith('\$')) {
    return name.substring(0, name.length - 1);
  }

  // If starts with `$`, replace `$` with `_`;
  if (name.startsWith('\$')) {
    return '_${name.substring(1)}';
  }

  return name;
}
