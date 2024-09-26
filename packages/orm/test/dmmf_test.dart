import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:orm/dmmf.dart';

void main() {
  late String jsonString;
  late Map<String, dynamic> jsonMap;
  late Document document;

  setUp(() {
    jsonString = File('test/fixtures/dmmf.json').readAsStringSync();
    jsonMap = json.decode(jsonString);
    document = Document(jsonMap);
  });

  group('Document', () {
    test('should parse correctly', () {
      expect(document, isA<Document>());
      expect(document.datamodel, isA<Datamodel>());
      expect(document.schema, isA<Schema>());
      expect(document.mappings, isA<Mappings>());
    });

    test('should parse datamodel correctly', () {
      expect(document.datamodel, isA<Datamodel>());
      expect(document.datamodel.models, isNotEmpty);
      expect(document.datamodel.enums, isA<Iterable<DatamodelEnum>>());
    });

    test('should parse schema correctly', () {
      expect(document.schema, isA<Schema>());
      expect(document.schema.inputObjectTypes, isA<InputObjectTypes>());
      expect(document.schema.outputObjectTypes, isA<OutputObjectTypes>());
      expect(document.schema.enumTypes, isA<EnumTypes>());
    });

    test('should parse mappings correctly', () {
      expect(document.mappings, isA<Mappings>());
      expect(document.mappings.modelOperations, isA<Iterable<ModelMapping>>());
      expect(document.mappings.otherOperations, isA<OtherOperations>());
    });
  });

  group('Datamodel', () {
    test('should parse models correctly', () {
      final datamodel = document.datamodel;
      expect(datamodel.models, hasLength(2));

      final userModel = datamodel.models.firstWhere((m) => m.name == 'User');
      expect(userModel.fields, hasLength(5));
      expect(userModel.fields.map((f) => f.name),
          containsAll(['id', 'email', 'name', 'posts', 'createdAt']));

      final postModel = datamodel.models.firstWhere((m) => m.name == 'Post');
      expect(postModel.fields, hasLength(6));
      expect(
          postModel.fields.map((f) => f.name),
          containsAll(
              ['id', 'title', 'content', 'published', 'author', 'authorId']));
    });

    test('should parse indexes correctly', () {
      final indexes = document.datamodel.indexes;
      expect(indexes, hasLength(3));
      expect(indexes.map((i) => i.name), containsAll([null, null, null]));
      expect(indexes.map((i) => i.fields.first.name),
          containsAll(['id', 'email', 'id']));
    });
  });

  group('Schema', () {
    test('should parse input object types correctly', () {
      final inputTypes = document.schema.inputObjectTypes.prisma;
      expect(inputTypes, isNotEmpty);

      final userWhereInput =
          inputTypes.firstWhere((t) => t.name == 'UserWhereInput');
      expect(userWhereInput.fields, isNotEmpty);
      expect(
          userWhereInput.fields.map((f) => f.name),
          containsAll([
            'AND',
            'OR',
            'NOT',
            'id',
            'email',
            'name',
            'posts',
            'createdAt'
          ]));
    });

    test('should parse output object types correctly', () {
      final modelOutputTypes = document.schema.outputObjectTypes.model;
      expect(modelOutputTypes, hasLength(2));

      final userOutputType =
          modelOutputTypes.firstWhere((t) => t.name == 'User');
      expect(userOutputType.fields.map((f) => f.name),
          containsAll(['id', 'email', 'name', 'posts', 'createdAt', '_count']));

      final prismaOutputTypes = document.schema.outputObjectTypes.prisma;
      expect(prismaOutputTypes, isNotEmpty);
      expect(prismaOutputTypes.map((t) => t.name), contains('AggregateUser'));
    });

    test('should parse enum types correctly', () {
      final enumTypes = document.schema.enumTypes.prisma;
      expect(enumTypes, isNotEmpty);
      expect(enumTypes.map((e) => e.name),
          containsAll(['UserScalarFieldEnum', 'SortOrder', 'QueryMode']));
    });
  });

  group('Mappings', () {
    test('should parse model operations correctly', () {
      final modelOps = document.mappings.modelOperations;
      expect(modelOps, hasLength(2));

      final userOps = modelOps.firstWhere((m) => m.model == 'User');
      expect(userOps.findMany, equals('findManyUser'));
      expect(userOps.createOne, equals('createOneUser'));

      final postOps = modelOps.firstWhere((m) => m.model == 'Post');
      expect(postOps.findMany, equals('findManyPost'));
      expect(postOps.createOne, equals('createOnePost'));
    });

    test('should parse other operations correctly', () {
      final otherOps = document.mappings.otherOperations;
      expect(otherOps.read, isEmpty);
      expect(otherOps.write, containsAll(['executeRaw', 'queryRaw']));
    });
  });
}
