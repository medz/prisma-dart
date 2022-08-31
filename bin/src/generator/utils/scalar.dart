final Map<String, Type> _map = {
  'string': String,
  'float': double,
  'decimal': double,
  'int': int,
  'bigint': BigInt,
  'boolean': bool,
  'json': dynamic,
  'bytes': List<int>,
  'unsupported': dynamic,
};

String scalar(String name) {
  if (_map.containsKey(name.toLowerCase())) {
    return _map[name.toLowerCase()].toString();
  } else if (name.toLowerCase() == 'null') {
    return 'runtime.PrismaNull';
  }

  return name;
}
