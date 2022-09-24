/// Header getter.
String? headerGetter(Map<String, String> headers, String key) {
  if (headers.keys.map((e) => e.toLowerCase()).contains(key.toLowerCase())) {
    return headers.entries
        .firstWhere((element) => element.key.toLowerCase() == key.toLowerCase())
        .value;
  }

  return null;
}
