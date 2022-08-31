import 'package:orm/dmmf.dart' as dmmf;

import '../utils/came_case.dart';
import '../utils/dart_style.dart';

const List<String> _ignores = ['TransactionIsolationLevel'];

String _enumBuilder(List<dmmf.SchemaEnum> schemaEnum) {
  final StringBuffer enumCodes = StringBuffer();
  for (final dmmf.SchemaEnum element in schemaEnum) {
    // If enum is ignored, then skip.
    if (_ignores.contains(element.name)) {
      continue;
    }

    enumCodes.writeln('enum ${element.name} implements runtime.PrismaEnum {');
    for (final String value in element.values) {
      enumCodes.writeln('  ${dartStyleField(value)}(\'$value\'),');
    }
    enumCodes.writeln(';');
    enumCodes.writeln('  @override');
    enumCodes.writeln('  final String value;');
    enumCodes.writeln('  const ${upperCamelCase(element.name)}(this.value);');
    enumCodes.writeln('}');
  }

  return enumCodes.toString();
}

Future<String> schemaEnumGenerator(dmmf.EnumTypes enumTypes) async {
  final StringBuffer code = StringBuffer();

  // Generate enum of prisma namespace.
  final String prismaEnum = _enumBuilder(enumTypes.prisma);
  if (prismaEnum.isNotEmpty) {
    code.writeln(prismaEnum);
  }

  // Generate enum of model namespace.
  final String modelEnum = _enumBuilder(enumTypes.model ?? []);
  if (modelEnum.isNotEmpty) {
    code.writeln(modelEnum);
  }

  return code.toString();
}
