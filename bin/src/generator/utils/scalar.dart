final Map<String, Type> _map = {
  'string': String,
  'float': double,
  'decimal': double,
  'boolean': bool,
  'json': dynamic,
  'unsupported': dynamic,
  'bytes': List<int>,
};

String scalar(String name) {
  if (_map.containsKey(name.toLowerCase())) {
    return _map[name.toLowerCase()].toString();
  }

  return name;
}
