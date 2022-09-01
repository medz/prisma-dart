final Map<String, String> _map = {
  'string': 'String',
  'float': 'double',
  'decimal': 'double',
  'int': 'int',
  'bigint': 'BigInt',
  'boolean': 'bool',
  'json': 'dynamic',
  'bytes': 'List<int>',
  'unsupported': 'dynamic',
  'null': 'runtime.PrismaNull',
};

String scalar(String name) {
  if (_map.containsKey(name.toLowerCase())) {
    return _map[name.toLowerCase()].toString();
  }

  return name;
}
