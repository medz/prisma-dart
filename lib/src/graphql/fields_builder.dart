import '../dmmf/dmmf.dart' as dmmf;

class GraphQLFieldsBuilder {
  final dmmf.Document document;
  final Iterable<Enum> fields;

  const GraphQLFieldsBuilder({
    required this.document,
    required this.fields,
  });
}
