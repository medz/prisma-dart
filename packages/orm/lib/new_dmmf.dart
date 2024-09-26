library prisma.dmmf;

extension type const Document(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  Datamodel get datamodel => Datamodel(_['datamodel']);
  Schema get schema => Schema(_['schema']);
  // Mappings get mappings => Mappings(_['mappings']);
}

extension type const Datamodel(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  Iterable<Model> get models => (_['models']).cast();
  Iterable<DatamodelEnum> get enums => (_['enums']).cast();
  Iterable<Model> get types => (_['types']).cast();
  Iterable<Index> get indexes => (_['indexes']).cast();
}

extension type const Model(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  String get name => _['name'];
  String? get dbName => _['dbName'];
  Iterable<Field> get fields => (_['fields']).cast();
  Iterable<String> get uniqueFields => (_['uniqueFields']).cast();
  Iterable<UniqueIndex> get uniqueIndexes => (_['uniqueIndexes']).cast();
  PrimaryKey? get primaryKey => _['primaryKey'];
  bool? get isGenerated => _['isGenerated'];
}

/// Represents a field in a database model
extension type const Field(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The kind of field (scalar, object, enum, or unsupported)
  FieldKind get kind => FieldKind.parse(_['kind']);

  /// The name of the field
  String get name => _['name'];

  /// Indicates whether the field is required
  bool get isRequired => _['isRequired'];

  /// Indicates whether the field is a list
  bool get isList => _['isList'];

  /// Indicates whether the field is unique
  bool get isUnique => _['isUnique'];

  /// Indicates whether the field is an ID field
  bool get isId => _['isId'];

  /// Indicates whether the field is read-only
  bool get isReadOnly => _['isReadOnly'];

  /// Indicates whether the field is generated (optional)
  bool? get isGenerated => _['isGenerated'];

  /// Indicates whether the field is automatically updated (optional)
  bool? get isUpdatedAt => _['isUpdatedAt'];

  /// The data type of the field
  String get type => _['type'];

  /// The database name of the field (optional)
  String? get dbName => _['dbName'];

  /// Indicates whether the field has a default value
  bool get hasDefaultValue => _['hasDefaultValue'];

  /// The default value of the field, with various possible types
  (
    FieldDefault?,
    String?,
    bool?,
    num?,
    Iterable<String>?,
    Iterable<bool>?,
    Iterable<num>?
  ) get defaultvalue {
    return switch (_['default']) {
      Map value => (
          FieldDefault(value.cast()),
          null,
          null,
          null,
          null,
          null,
          null
        ),
      String value => (null, value, null, null, null, null, null),
      bool value => (null, null, value, null, null, null, null),
      num value => (null, null, null, value, null, null, null),
      Iterable value when value.every((e) => e is String) => (
          null,
          null,
          null,
          null,
          value.cast(),
          null,
          null
        ),
      Iterable value when value.every((e) => e is bool) => (
          null,
          null,
          null,
          null,
          null,
          value.cast(),
          null
        ),
      Iterable value when value.every((e) => e is num) => (
          null,
          null,
          null,
          null,
          null,
          null,
          value.cast()
        ),
      _ => (null, null, null, null, null, null, null),
    };
  }

  /// The fields in the current model that refer to the related model (optional)
  Iterable<String>? get relationFromFields => _['relationFromFields'];

  /// The fields in the related model that are referred to by the current model (optional)
  Iterable<String>? get relationToFields => _['relationToFields'];

  /// The onDelete behavior for the relation (optional)
  String? get relationOnDelete => _['relationOnDelete'];

  /// The name of the relation (optional)
  String? get relationName => _['relationName'];

  /// Documentation or comments associated with the field (optional)
  String? get documentation => _['documentation'];
}

/// Represents the kind of field in a database model
enum FieldKind {
  /// Represents a scalar field type (e.g., String, Int, DateTime)
  scalar,

  /// Represents an object or relation field type
  object,

  /// Represents an enum field type
  enum_,

  /// Represents an unsupported or unknown field type
  unsupported;

  /// Parses a string value to return the corresponding FieldKind
  ///
  /// [value] The string representation of the field kind
  /// Returns the matching FieldKind or unsupported if no match is found
  factory FieldKind.parse(String value) {
    return switch (value) {
      'scalar' => scalar,
      'object' => object,
      'enum' => enum_,
      _ => unsupported,
    };
  }
}

/// Represents default values for fields in a database model
extension type const FieldDefault(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The name of the default value function or constant
  String get name => _['name'];

  /// Arguments passed to the default value function, if any
  Iterable get args => _['args'];
}

/// Represents a unique index in a database model
extension type const UniqueIndex(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The name of the unique index
  String get name => _['name'];

  /// The list of field names that make up this unique index
  Iterable<String> get fields => (_['fields']).cast();
}

/// Represents the primary key of a database model
extension type const PrimaryKey(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The name of the primary key (optional)
  String? get name => _['name'];

  /// The list of field names that make up the primary key
  Iterable<String> get fields => (_['fields']).cast();
}

/// Represents an enumeration in the data model
extension type const DatamodelEnum(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The name of the enumeration
  String get name => _['name'];

  /// The list of values in the enumeration
  Iterable<EnumValue> get values => (_['values']).cast();

  /// The database name of the enumeration, if different from the model name
  String? get dbName => _['dbName'];

  /// Documentation or comments associated with the enumeration
  String? get documentation => _['documentation'];
}

/// Represents a single value in an enumeration
extension type const EnumValue(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The name of the enum value
  String get name => _['name'];

  /// The database name of the enum value, if different from the model name
  String? get dbName => _['dbName'];
}

/// Represents an index in a database model.
extension type const Index(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The model to which this index belongs
  String get model => _['model'];

  /// The type of the index
  IndexType get type => IndexType.parse(_['type']);

  /// Indicates whether the index is defined on a field
  bool get isDefinedOnField => _['isDefinedOnField'];

  /// The name of the index (optional)
  String? get name => _['name'];

  /// The database name of the index (optional)
  String? get dbName => _['dbName'];

  /// The algorithm used for the index (optional)
  String? get algorithm => _['algorithm'];

  /// Indicates whether the index is clustered (optional)
  bool? get clustered => _['clustered'];

  /// The fields included in the index
  Iterable<IndexField> get fields => _['fields'].cast();
}

/// Represents the types of indexes available
enum IndexType {
  /// Primary key index
  id,

  /// Standard index
  normal,

  /// Unique index
  unique,

  /// Full-text search index
  fulltext;

  /// Parses a string value to return the corresponding IndexType
  factory IndexType.parse(String value) {
    return values.singleWhere((e) => e.name == value);
  }
}

/// Represents a field in an index
extension type const IndexField(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The name of the index field
  String get name => _['name'];

  /// The sort order of the index field
  SortOrder? get sortOrder => SortOrder.parse(_['sortOrder']);

  /// The size of the index field
  /// Renamed from 'length' to avoid confusion with Map length in Dart core
  int? get size => _['length'];

  /// The operator class of the index field
  String? get operatorClass => _['operatorClass'];
}

/// Represents the sort order for index fields
enum SortOrder {
  /// Ascending order
  asc,

  /// Descending order
  desc;

  /// Parses a string value to return the corresponding SortOrder
  factory SortOrder.parse(String value) {
    return values.singleWhere((e) => e.name == value);
  }
}

/// Represents the schema of the database
extension type const Schema(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  String? get rootQueryType => _['rootQueryType'];
  String? get rootMutationType => _['rootMutationType'];
  InputObjectTypes get inputObjectTypes =>
      InputObjectTypes(_['inputObjectTypes']);
  // OutputObjectTypes get outputObjectTypes =>
  //     OutputObjectTypes(_['outputObjectTypes']);
  // EnumTypes get enumTypes => EnumTypes(_['enumTypes']);
  // FieldRefTypes get fieldRefTypes => FieldRefTypes(_['fieldRefTypes']);
}

extension type const InputObjectTypes(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  Iterable<InputType>? get model => _['model']?.cast();
  Iterable<InputType> get prisma => _['prisma'].cast();
}

extension type const InputType(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  String get name => _['name'];
  Constraints get constraints => Constraints(_['constraints']);
  Meta? get meta => _['meta'] ? Meta(_['meta']) : null;
  Iterable<SchemaArg> get fields => _['fields'].cast();
}

extension type const Constraints(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  int? get maxNumFields => _['maxNumFields'];
  int? get minNumFields => _['minNumFields'];
  Iterable<String>? get fields => _['fields']?.cast();
}

extension type const Meta(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  String? get source => _['source'];
}

extension type const SchemaArg(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  String get name => _['name'];
  String? get comment => _['comment'];
  bool get isNullable => _['isNullable'];
  bool get isRequired => _['isRequired'];
  Iterable<InputTypeRef> get inputTypes => _['inputTypes'].cast();
  Deprecation? get deprecation =>
      _['deprecation'] ? Deprecation(_['deprecation']) : null;
}

/// Represents deprecation information for a schema element.
///
/// This extension type provides details about the deprecation of a schema element,
/// including when it was deprecated, why, and when it's planned to be removed.
extension type const Deprecation(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The version since which this schema element has been deprecated.
  ///
  /// This field indicates the version of the schema or API in which
  /// the deprecation was first introduced.
  String get sinceVersion => _['sinceVersion'];

  /// The reason for deprecating this schema element.
  ///
  /// This field provides an explanation of why the element has been deprecated,
  /// which can help users understand the motivation behind the deprecation
  /// and guide them towards alternative solutions.
  String get reason => _['reason'];

  /// The planned version for removing this deprecated schema element.
  ///
  /// This optional field specifies the future version in which the deprecated
  /// element is expected to be completely removed from the schema or API.
  /// If null, it means there's no specific plan for removal yet.
  String? get plannedRemovalVersion => _['plannedRemovalVersion'];
}

extension type const InputTypeRef(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  bool get isList => _['isList'];
  String get type => _['type'];
  InputTypeLocations get location => InputTypeLocations.parse(_['location']);
}

/// Represents the possible locations of input types in a schema.
enum InputTypeLocations {
  /// Represents a scalar input type (e.g., String, Int, Boolean).
  scalar,

  /// Represents an enum input type.
  /// Note: The underscore is used to avoid conflict with the 'enum' keyword.
  enum_,

  /// Represents an input object type, which is a complex input type
  /// composed of multiple fields.
  inputObject;

  /// Parses a string value to return the corresponding InputTypeLocations.
  ///
  /// This factory method is used to convert string representations of
  /// input type locations to their corresponding enum values.
  ///
  /// [value] The string representation of the input type location.
  ///
  /// Returns the matching InputTypeLocations.
  factory InputTypeLocations.parse(String value) {
    if (value == 'enum') return enum_;

    return values.singleWhere((e) => e.name == value);
  }
}
