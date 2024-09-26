import 'package:json/json.dart';

@JsonCodable()
class Document {
  final Datemodel datamodel;
}

@JsonCodable()
class Datemodel {
  final List<Model> models;
}

@JsonCodable()
class Model {
  final String name;
  final String? dbName;
  final List<Field> fields;
  final List<UniqueIndex> uniqueIndexes;
  final String? documentation;
  final PrimaryKey? primaryKey;
  final bool isGenerated;
}
