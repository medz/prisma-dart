import 'package:prisma_cli/src/generator/ast/ast.dart';


class PrismaClientBuilder extends CodeableAst {
  PrismaClientBuilder(super.ast);

  @override
  String get codeString {
    final StringBuffer code = StringBuffer();
    //TODO init the right engine and inject it to the client
    code.writeln("""
class PrismaClient {

  final Engine engine;

  // final PrismaActions action;
  PrismaClient._(this.engine);
  factory PrismaClient()=>PrismaClient._(BinaryEngine(schema));
""");

    for (final model in ast.dmmf.datamodel.models) {
      code.writeln("final ${fieldName(model.name)} = ${className(model.name)}Model() ;");
    }

    code.writeln("}");

    // code.writeln(_buildPrismaAction());

    return code.toString();
  }

//   String _buildPrismaAction() {
//     return """
// class PrismaActions {
//   PrismaActions(this.lifecycle, this.raw, this.tx);

//   final Lifecycle lifecycle;

//   final Raw raw;

//   final TX tx;
// }
// """;
//   }
}
