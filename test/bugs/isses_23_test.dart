import 'dart:convert';
import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart';
import 'package:orm/version.dart';
import 'package:test/test.dart';

import '../../bin/src/binary_engine/binary_engine.dart';
import '../../bin/src/binary_engine/binary_engine_platform.dart';
import '../../bin/src/binary_engine/binray_engine_type.dart';
import '../../bin/src/generator/utils/schema_type.dart';

void main() {
  final BinaryEngine engine = BinaryEngine(
    platform: BinaryEnginePlatform.current,
    type: BinaryEngineType.query,
    version: binaryVersion,
  );

  const String schema = r'''
model User {
  id    Int     @id @default(autoincrement())
  name  String?
}
''';

  late Reference reference;

  setUp(() async {
    // Download binary engine.
    if (!await engine.hasDownloaded) {
      await engine.download((done) => done);
    }

    // Get dmmf.
    final ProcessResult result = await engine.run(
      ['--enable-raw-queries', 'cli', 'dmmf'],
      environment: <String, String>{
        'PRISMA_DML': base64.encode(schema.codeUnits),
      },
    );

    // Create DMMF document.
    final Document document =
        Document.fromJson(jsonDecode(result.stdout) as Map<String, dynamic>);

    final List<InputType> inputTypes =
        (document.schema.inputObjectTypes.model ?? [])
          ..addAll(document.schema.inputObjectTypes.prisma ?? []);
    final InputType userWhereInput =
        inputTypes.firstWhere((element) => element.name == 'UserWhereInput');

    // Set `name` input types.
    final List<SchemaType> nameInputTypes = userWhereInput.fields
        .firstWhere((element) => element.name == 'name')
        .inputTypes;

    reference = schemaTypeResolver(nameInputTypes);
  });

  test('Issue #23 fixed test (https://github.com/odroe/prisma-dart/issues/23)',
      () {
    expect(reference, isA<TypeReference>());
    expect(reference.symbol, 'StringNullableFilter');

    final TypeReference typeReference = reference as TypeReference;
    expect(typeReference.types, hasLength(0));
  });
}
