class Config {
  final String? output;
  final String? schema;

  const Config({this.output, this.schema});
}

const config = Config(
  output: 'generated/from_config.g.dart',
  schema: 'schema/from_config.dart',
);
