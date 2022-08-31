class GraphQLVeriable {
  final String key;
  final dynamic value;
  final bool isRequired;

  const GraphQLVeriable(this.key, this.value, {this.isRequired = false});
}
