/// This library contains definitions for the Prisma DMMF (Data Model Metadata Format).
library prisma.dmmf;

/// Represents a document in the Prisma DMMF (Data Model Metadata Format).
/// This extension type provides access to the main components of a Prisma schema:
/// the datamodel, schema, and mappings.
extension type const Document(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// Returns the datamodel of the document.
  /// The datamodel represents the structure of the database, including
  /// models, fields, and their relationships.
  ///
  /// Returns: A [Datamodel] object containing the datamodel information.
  Datamodel get datamodel => Datamodel(_['datamodel']);

  /// Returns the schema of the document.
  /// The schema defines the structure of the API, including queries,
  /// mutations, and the types they operate on.
  ///
  /// Returns: A [Schema] object containing the schema information.
  Schema get schema => Schema(_['schema']);

  /// Returns the mappings of the document.
  /// Mappings define how the Prisma models and their operations
  /// correspond to the underlying database operations.
  ///
  /// Returns: A [Mappings] object containing the mapping information.
  Mappings get mappings => Mappings(_['mappings']);
}

/// Represents the datamodel in the Prisma DMMF (Data Model Metadata Format).
/// This extension type provides access to the core components of a Prisma datamodel:
/// models, enums, types, and indexes.
extension type const Datamodel(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// Returns an iterable of all models in the datamodel.
  ///
  /// Models represent the main entities in your database schema, defining
  /// the structure and relationships of your data.
  ///
  /// Returns: An [Iterable] of [Model] objects representing all models in the datamodel.
  Iterable<Model> get models => (_['models'] as Iterable).map((e) => Model(e));

  /// Returns an iterable of all enums in the datamodel.
  ///
  /// Enums represent predefined sets of values that can be used as field types
  /// in your models, providing a way to constrain a field to a specific set of allowed values.
  ///
  /// Returns: An [Iterable] of [DatamodelEnum] objects representing all enums in the datamodel.
  Iterable<DatamodelEnum> get enums =>
      (_['enums'] as Iterable).map((e) => DatamodelEnum(e));

  /// Returns an iterable of all types in the datamodel.
  ///
  /// Types represent custom data types that can be used across your models.
  /// These can include composite types or other custom type definitions.
  ///
  /// Returns: An [Iterable] of [Model] objects representing all custom types in the datamodel.
  Iterable<Model> get types => (_['types'] as Iterable).map((e) => Model(e));

  /// Returns an iterable of all indexes in the datamodel.
  ///
  /// Indexes are database optimizations that can improve the speed of data retrieval
  /// operations on your models. They represent additional structures maintained by the
  /// database to enhance query performance.
  ///
  /// Returns: An [Iterable] of [Index] objects representing all indexes defined in the datamodel.
  Iterable<Index> get indexes =>
      (_['indexes'] as Iterable).map((e) => Index(e));
}

/// Represents a model in the Prisma datamodel.
extension type const Model(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The name of the model.
  String get name => _['name'];

  /// The database name of the model, if different from the model name.
  String? get dbName => _['dbName'];

  /// An iterable of all fields in the model.
  Iterable<Field> get fields => (_['fields']).cast();

  /// An iterable of unique field combinations in the model.
  Iterable<String> get uniqueFields => (_['uniqueFields']).cast();

  /// An iterable of unique indexes in the model.
  Iterable<UniqueIndex> get uniqueIndexes => (_['uniqueIndexes']).cast();

  /// The primary key of the model, if defined.
  PrimaryKey? get primaryKey => _['primaryKey'];

  /// Indicates if the model is generated.
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
  /// The root query type of the schema
  String? get rootQueryType => _['rootQueryType'];

  /// The root mutation type of the schema
  String? get rootMutationType => _['rootMutationType'];

  /// The input object types of the schema
  InputObjectTypes get inputObjectTypes =>
      InputObjectTypes(_['inputObjectTypes']);
  OutputObjectTypes get outputObjectTypes =>
      OutputObjectTypes(_['outputObjectTypes']);
  EnumTypes get enumTypes => EnumTypes(_['enumTypes']);
  FieldRefTypes get fieldRefTypes => FieldRefTypes(_['fieldRefTypes']);
}

/// Represents the input object types in the schema
extension type const InputObjectTypes(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The model input types
  Iterable<InputType>? get model => _['model']?.cast();

  /// The Prisma input types
  Iterable<InputType> get prisma =>
      (_['prisma'] as Iterable).map((e) => InputType(e));
}

/// Represents an input type in the schema
extension type const InputType(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The name of the input type
  String get name => _['name'];

  /// The constraints of the input type
  Constraints get constraints => Constraints(_['constraints']);

  /// The metadata of the input type
  Meta? get meta => _['meta'] ? Meta(_['meta']) : null;

  /// The fields of the input type
  Iterable<SchemaArg> get fields => _['fields'].cast();
}

/// Represents constraints for an input type
extension type const Constraints(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The maximum number of fields allowed
  int? get maxNumFields => _['maxNumFields'];

  /// The minimum number of fields required
  int? get minNumFields => _['minNumFields'];

  /// The fields that are constrained
  Iterable<String>? get fields => _['fields']?.cast();
}

/// Represents metadata for an input type
extension type const Meta(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The source of the metadata
  String? get source => _['source'];
}

/// Represents an argument in the [Schema]
extension type const SchemaArg(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The name of the argument
  String get name => _['name'];

  /// The comment associated with the argument
  String? get comment => _['comment'];

  /// Indicates if the argument is nullable
  bool get isNullable => _['isNullable'];

  /// Indicates if the argument is required
  bool get isRequired => _['isRequired'];

  /// The input types for this argument
  Iterable<InputTypeRef> get inputTypes => _['inputTypes'].cast();

  /// The deprecation information for this argument, if any
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

/// Represents a reference to an input type in the schema
extension type const InputTypeRef(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// Indicates if this input type is a list
  bool get isList => _['isList'];

  /// The type of the input
  String get type => _['type'];

  /// The location of the input type in the schema
  InputTypeLocations get location => InputTypeLocations.parse(_['location']);

  FieldNamespace? get namespace =>
      _['namespace'] ? FieldNamespace.parse(_['namespace']) : null;
}

/// Represents the possible locations of input types in a schema.
enum InputTypeLocations {
  /// Represents a scalar input type (e.g., String, Int, Boolean).
  scalar,

  /// Represents input types that are complex objects defined in the schema.
  inputObjectTypes,

  /// Represents input types that are enumerations defined in the schema.
  enumTypes,

  /// Represents input types that are field references, typically used for filtering or sorting.
  fieldRefTypes;

  /// Parses a string value to return the corresponding InputTypeLocations enum.
  ///
  /// This factory method takes a string [value] and returns the matching
  /// InputTypeLocations enum. If no match is found, it throws a StateError.
  ///
  /// [value] The string representation of the input type location.
  /// Returns the matching InputTypeLocations enum.
  /// Throws a StateError if no matching enum is found.
  factory InputTypeLocations.parse(String value) {
    return values.singleWhere((e) => e.name == value);
  }
}

/// Represents the namespace of a field in the Prisma schema.
///
/// This enum defines the possible namespaces for fields, which can be either
/// part of a user-defined model or part of Prisma's built-in types and operations.
enum FieldNamespace {
  /// Indicates that the field belongs to a user-defined model in the schema.
  model,

  /// Indicates that the field is part of Prisma's built-in types or operations.
  prisma;

  /// Parses a string value to return the corresponding FieldNamespace enum.
  ///
  /// This factory method takes a string [value] and returns the matching
  /// FieldNamespace enum. If no match is found, it throws a StateError.
  ///
  /// [value] The string representation of the field namespace.
  /// Returns the matching FieldNamespace enum.
  /// Throws a StateError if no matching enum is found.
  factory FieldNamespace.parse(String value) {
    return values.singleWhere((e) => e.name == value);
  }
}

/// Represents the output object types in the schema.
///
/// This extension type provides access to two categories of output types:
/// model types and Prisma types.
extension type const OutputObjectTypes(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// Returns an iterable of output types representing user-defined models.
  ///
  /// These types correspond to the models defined in the Prisma schema.
  Iterable<OutputType> get model =>
      (_['model'] as Iterable).map((e) => OutputType(e));

  /// Returns an iterable of output types representing Prisma's built-in types.
  ///
  /// These types are part of Prisma's core functionality and are not
  /// user-defined.
  Iterable<OutputType> get prisma => _['prisma'].cast();
}

/// Represents an output type in the schema.
///
/// This extension type encapsulates the structure of an output type,
/// which typically corresponds to a model or a Prisma-defined type in the schema.
extension type const OutputType(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The name of the output type.
  ///
  /// This uniquely identifies the output type within the schema.
  String get name => _['name'];

  /// An iterable of fields associated with this output type.
  ///
  /// Each field is represented by a [SchemaField] object, which contains
  /// detailed information about the field's properties and behavior.
  Iterable<SchemaField> get fields => _['fields'].cast();
}

/// Represents a field in the schema.
///
/// This extension type encapsulates the properties and behavior of a field
/// within a schema, including its name, nullability, output type, arguments,
/// deprecation status, and documentation.
extension type const SchemaField(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// The name of the field.
  ///
  /// This uniquely identifies the field within its parent type.
  String get name => _['name'];

  /// Indicates whether the field can be null.
  ///
  /// If true, the field is nullable; if false, it is required.
  /// This property is optional and may be null if not specified.
  bool? get isNullable => _['isNullable'];

  /// The output type of the field.
  ///
  /// This property defines the type of data that the field returns.
  OutputTypeRef get outputType => OutputTypeRef(_['outputType']);

  /// The arguments associated with the field.
  ///
  /// This iterable contains [SchemaArg] objects representing any arguments
  /// that can be passed to the field when querying.
  Iterable<SchemaArg> get args => _['args'].cast();

  /// The deprecation information for the field, if any.
  ///
  /// If the field is deprecated, this property will contain a [Deprecated]
  /// object with details about the deprecation. Otherwise, it will be null.
  Deprecated? get deprecation =>
      _['deprecation'] ? Deprecated(_['deprecation']) : null;

  /// The documentation or description of the field.
  ///
  /// This property may contain a string with additional information or
  /// explanation about the field's purpose or usage.
  String? get documentation => _['documentation'];
}

/// Represents a reference to an output type in the schema.
///
/// This extension type encapsulates information about an output type reference,
/// including whether it's a list, its type name, location in the schema, and namespace.
extension type const OutputTypeRef(Map<String, dynamic> _)
    implements Map<String, dynamic> {
  /// Indicates whether this output type is a list.
  ///
  /// Returns true if the output type is a list, false otherwise.
  bool get isList => _['isList'];

  /// The name or identifier of the output type.
  ///
  /// This string represents the specific type referenced by this output type.
  String get type => _['type'];

  /// The location of the output type in the schema.
  ///
  /// This property returns an [OutputTypeLocations] enum value indicating
  /// where in the schema structure this output type is defined.
  OutputTypeLocations get location => OutputTypeLocations.parse(_['location']);

  /// The namespace of the output type, if applicable.
  ///
  /// This property returns a [FieldNamespace] enum value if the output type
  /// belongs to a specific namespace (e.g., model or prisma), or null if no
  /// namespace is specified.
  FieldNamespace? get namespace =>
      _['namespace'] ? FieldNamespace.parse(_['namespace']) : null;
}

/// Represents the possible locations of output types in a schema.
enum OutputTypeLocations {
  /// Represents a scalar output type (e.g., String, Int, Boolean).
  scalar,

  /// Represents output types that are complex objects defined in the schema.
  outputObjectTypes,

  /// Represents output types that are enumerations defined in the schema.
  enumTypes;

  /// Parses a string value to return the corresponding OutputTypeLocations enum.
  ///
  /// This factory method takes a string [value] and returns the matching
  /// OutputTypeLocations enum. If no match is found, it throws a StateError.
  ///
  /// [value] The string representation of the output type location.
  /// Returns the matching OutputTypeLocations enum.
  /// Throws a StateError if no matching enum is found.
  factory OutputTypeLocations.parse(String value) {
    return values.singleWhere((e) => e.name == value);
  }
}

/// Represents the enum types in the schema.
///
/// This extension type provides access to two categories of enum types:
/// model enums (user-defined) and Prisma enums (built-in).
extension type const EnumTypes(Map _) implements Map {
  /// Returns an iterable of SchemaEnum objects representing the user-defined model enums,
  /// or null if no model enums are defined.
  Iterable<SchemaEnum>? get model => _['model']?.cast();

  /// Returns an iterable of SchemaEnum objects representing the built-in Prisma enums.
  Iterable<SchemaEnum> get prisma => _['prisma'].cast();
}

/// Represents an enumeration in the schema.
///
/// This extension type encapsulates the properties of an enum,
/// including its name and possible values.
extension type const SchemaEnum(Map _) implements Map {
  /// The name of the enum.
  ///
  /// This uniquely identifies the enum within the schema.
  String get name => _['name'];

  /// An iterable of strings representing the possible values of the enum.
  ///
  /// Each string in this iterable corresponds to one of the enum's variants.
  Iterable<String> get values => _['values'].cast();
}

/// Represents the field reference types in the schema.
///
/// This extension type provides access to field reference types defined in the Prisma namespace.
extension type FieldRefTypes(Map _) implements Map {
  /// Returns an iterable of FieldRefType objects representing the field reference types
  /// in the Prisma namespace, or null if not defined.
  Iterable<FieldRefType>? get prisma => _['prisma']?.cast();
}

/// Represents a field reference type in the schema.
///
/// This extension type encapsulates information about a field reference type,
/// including its name, allowed types, and associated fields.
extension type const FieldRefType(Map _) implements Map {
  /// The name of the field reference type.
  String get name => _['name'];

  /// An iterable of FieldRefAllowType objects representing the allowed types for this field reference.
  Iterable<FieldRefAllowType> get allowTypes => _['allowTypes'].cast();

  /// An iterable of SchemaArg objects representing the fields associated with this field reference type.
  Iterable<SchemaArg> get fields => _['fields'].cast();
}

/// Represents an allowed type for a field reference.
///
/// This extension type encapsulates information about an allowed type for a field reference,
/// including whether it's a list, its type name, location in the schema, and namespace.
extension type const FieldRefAllowType(Map _) implements Map {
  /// Indicates whether this allowed type is a list.
  bool get isList => _['isList'];

  /// The name or identifier of the allowed type.
  String get type => _['type'];

  /// The location of the allowed type in the schema.
  ///
  /// This property returns a FieldRefLocation enum value indicating
  /// where in the schema structure this allowed type is defined.
  FieldRefLocation get location => FieldRefLocation.parse(_['location']);

  /// The namespace of the allowed type, if applicable.
  ///
  /// This property returns a FieldNamespace enum value if the allowed type
  /// belongs to a specific namespace (e.g., model or prisma), or null if no
  /// namespace is specified.
  FieldNamespace? get namespace =>
      _['namespace'] ? FieldNamespace.parse(_['namespace']) : null;
}

/// Represents the possible locations of field references in the schema.
enum FieldRefLocation {
  /// Represents a scalar field reference (e.g., String, Int, Boolean).
  scalar,

  /// Represents a field reference to an enumeration type.
  enumTypes;

  /// Parses a string value to return the corresponding FieldRefLocation enum.
  ///
  /// This factory method takes a string [value] and returns the matching
  /// FieldRefLocation enum. If no match is found, it throws a StateError.
  ///
  /// [value] The string representation of the field reference location.
  /// Returns the matching FieldRefLocation enum.
  /// Throws a StateError if no matching enum is found.
  factory FieldRefLocation.parse(String value) {
    return values.singleWhere((e) => e.name == value);
  }
}

/// Represents the mappings between models and operations in the Prisma schema.
///
/// This extension type provides access to model operations and other operations
/// that are defined in the schema mappings.
extension type const Mappings(Map _) implements Map {
  /// Returns an iterable of ModelMapping objects representing the operations
  /// associated with each model in the schema.
  Iterable<ModelMapping> get modelOperations =>
      (_['modelOperations'] as Iterable).map((e) => ModelMapping(e));

  /// Returns an OtherOperations object representing operations that are not
  /// directly associated with specific models.
  OtherOperations get otherOperations => OtherOperations(_['otherOperations']);
}

/// Represents other operations in the Prisma schema that are not directly associated with models.
///
/// This extension type encapsulates read and write operations that are not tied to specific models
/// but are part of the overall schema functionality.
extension type const OtherOperations(Map _) implements Map {
  /// Returns an iterable of strings representing read operations.
  ///
  /// These operations typically include queries and other read-only actions
  /// that do not modify the database.
  Iterable<String> get read => (_['read'] as List?)?.cast<String>() ?? const [];

  /// Returns an iterable of strings representing write operations.
  ///
  /// These operations typically include mutations and other actions
  /// that modify the database state.
  Iterable<String> get write =>
      (_['write'] as List?)?.cast<String>() ?? const [];
}

/// Represents a mapping between a model and its associated operations in the Prisma schema.
extension type const ModelMapping(Map _) implements Map {
  /// Returns the name of the model this mapping is associated with.
  String get model => _['model'];

  /// Returns the name of the aggregate operation for this model, if available.
  String? get aggregate => _['aggregate'];

  /// Returns the name of the raw aggregate operation for this model, if available.
  String? get aggregateRaw => _['aggregateRaw'];

  /// Returns the name of the operation to create multiple records of this model, if available.
  String? get createMany => _['createMany'];

  /// Returns the name of the operation to create multiple records of this model and return them, if available.
  String? get createManyAndReturn => _['createManyAndReturn'];

  /// Returns the name of the operation to create a single record of this model, if available.
  String? get createOne => _['createOne'];

  /// Returns the name of the operation to delete multiple records of this model, if available.
  String? get deleteMany => _['deleteMany'];

  /// Returns the name of the operation to delete a single record of this model, if available.
  String? get deleteOne => _['deleteOne'];

  /// Returns the name of the operation to find the first record of this model that matches given criteria, if available.
  String? get findFirst => _['findFirst'];

  /// Returns the name of the operation to find the first record of this model that matches given criteria or throw an error, if available.
  String? get findFirstOrThrow => _['findFirstOrThrow'];

  /// Returns the name of the operation to find multiple records of this model, if available.
  String? get findMany => _['findMany'];

  /// Returns the name of the operation to find a unique record of this model, if available.
  String? get findUnique => _['findUnique'];

  /// Returns the name of the operation to find a unique record of this model or throw an error, if available.
  String? get findUniqueOrThrow => _['findUniqueOrThrow'];

  /// Returns the name of the operation to perform a raw find operation on this model, if available.
  String? get findRaw => _['findRaw'];

  /// Returns the name of the operation to group records of this model, if available.
  String? get groupBy => _['groupBy'];

  /// Returns the name of the operation to update multiple records of this model, if available.
  String? get updateMany => _['updateMany'];

  /// Returns the name of the operation to update a single record of this model, if available.
  String? get updateOne => _['updateOne'];

  /// Returns the name of the operation to upsert (update or insert) a single record of this model, if available.
  String? get upsertOne => _['upsertOne'];
}
