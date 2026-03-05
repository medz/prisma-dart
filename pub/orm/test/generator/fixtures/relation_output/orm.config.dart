class Config {
  final String? output;
  final String? schema;

  const Config({this.output, this.schema});
}

const config = Config(output: 'generated/typed_client.g.dart');
