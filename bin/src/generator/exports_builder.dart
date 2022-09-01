final Map<String, List<String>> _exports = {
  'package:orm/orm.dart': [
    'PrismaUnion',
    'PrismaNull',
    'TransactionIsolationLevel',
    'Datasource',
  ],
};

// Exports builder.
String exportsBuilder() {
  final StringBuffer buffer = StringBuffer();
  for (final String package in _exports.keys) {
    final List<String>? types = _exports[package]?..sort();

    // If types is null, then package is not exported.
    if (types == null) {
      continue;
    }

    // If types is empty, then package is exported.
    if (types.isEmpty) {
      buffer.writeln('export \'$package\';');
      continue;
    }

    // If types is not empty, then package is exported with types.
    buffer.writeln('export \'$package\' show ${types.join(', ')};');
  }

  return buffer.toString();
}
