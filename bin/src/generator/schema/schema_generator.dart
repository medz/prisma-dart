import 'package:orm/dmmf.dart' as dmmf;

import 'schema_enum_generator.dart';
import 'schema_input_object_generator.dart';
import 'schema_output_object_generator.dart';

/// Prisma Schema Generator
Future<String> schemaGenerator(dmmf.Schema schema) async {
  final StringBuffer code = StringBuffer();

  // Build schema enum types
  final String enumTypes = await schemaEnumGenerator(schema.enumTypes);
  if (enumTypes.isNotEmpty) code.writeln(enumTypes);

  // Build input object types
  final String inputObjectTypes =
      await schemaInputObjectTypesGenerator(schema.inputObjectTypes);
  if (inputObjectTypes.isNotEmpty) code.writeln(inputObjectTypes);

  // Build output object types
  final String outputObjectTypes =
      schemaOutputObjectTypesBuilder(schema.outputObjectTypes);
  if (outputObjectTypes.isNotEmpty) code.writeln(outputObjectTypes);

  return code.toString();
}
