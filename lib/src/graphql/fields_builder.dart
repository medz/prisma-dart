import '../dmmf/dmmf.dart' as dmmf;
import '../runtime/prisma_enum.dart';

class GraphQLFieldsBuilder {
  final dmmf.Document document;
  final Iterable<PrismaEnum> fields;

  const GraphQLFieldsBuilder({
    required this.document,
    required this.fields,
  });
}
