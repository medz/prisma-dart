import '../dmmf/dmmf.dart' as dmmf;
import 'fields_builder.dart';
import 'veriable.dart';

class GraphQLSdl {
  final dmmf.Document document;
  final String operationName;
  final Iterable<GraphQLVeriable> variables;
  final GraphQLFieldsBuilder fields;
  final String location;

  const GraphQLSdl({
    required this.document,
    required this.operationName,
    required this.variables,
    required this.fields,
    required this.location,
  });

  /// Build GraphQL SDL.
  String build() {
    // TODO: implement build
    return '';
  }
}
