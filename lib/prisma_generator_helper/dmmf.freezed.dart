// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dmmf.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return _Document.fromJson(json);
}

/// @nodoc
mixin _$Document {
  Datamodel get datamodel => throw _privateConstructorUsedError;
  Schema get schema => throw _privateConstructorUsedError;
  Mappings get mappings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentCopyWith<Document> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentCopyWith<$Res> {
  factory $DocumentCopyWith(Document value, $Res Function(Document) then) =
      _$DocumentCopyWithImpl<$Res, Document>;
  @useResult
  $Res call({Datamodel datamodel, Schema schema, Mappings mappings});

  $DatamodelCopyWith<$Res> get datamodel;
  $SchemaCopyWith<$Res> get schema;
  $MappingsCopyWith<$Res> get mappings;
}

/// @nodoc
class _$DocumentCopyWithImpl<$Res, $Val extends Document>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datamodel = null,
    Object? schema = null,
    Object? mappings = null,
  }) {
    return _then(_value.copyWith(
      datamodel: null == datamodel
          ? _value.datamodel
          : datamodel // ignore: cast_nullable_to_non_nullable
              as Datamodel,
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as Schema,
      mappings: null == mappings
          ? _value.mappings
          : mappings // ignore: cast_nullable_to_non_nullable
              as Mappings,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DatamodelCopyWith<$Res> get datamodel {
    return $DatamodelCopyWith<$Res>(_value.datamodel, (value) {
      return _then(_value.copyWith(datamodel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SchemaCopyWith<$Res> get schema {
    return $SchemaCopyWith<$Res>(_value.schema, (value) {
      return _then(_value.copyWith(schema: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MappingsCopyWith<$Res> get mappings {
    return $MappingsCopyWith<$Res>(_value.mappings, (value) {
      return _then(_value.copyWith(mappings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DocumentImplCopyWith<$Res>
    implements $DocumentCopyWith<$Res> {
  factory _$$DocumentImplCopyWith(
          _$DocumentImpl value, $Res Function(_$DocumentImpl) then) =
      __$$DocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Datamodel datamodel, Schema schema, Mappings mappings});

  @override
  $DatamodelCopyWith<$Res> get datamodel;
  @override
  $SchemaCopyWith<$Res> get schema;
  @override
  $MappingsCopyWith<$Res> get mappings;
}

/// @nodoc
class __$$DocumentImplCopyWithImpl<$Res>
    extends _$DocumentCopyWithImpl<$Res, _$DocumentImpl>
    implements _$$DocumentImplCopyWith<$Res> {
  __$$DocumentImplCopyWithImpl(
      _$DocumentImpl _value, $Res Function(_$DocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datamodel = null,
    Object? schema = null,
    Object? mappings = null,
  }) {
    return _then(_$DocumentImpl(
      datamodel: null == datamodel
          ? _value.datamodel
          : datamodel // ignore: cast_nullable_to_non_nullable
              as Datamodel,
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as Schema,
      mappings: null == mappings
          ? _value.mappings
          : mappings // ignore: cast_nullable_to_non_nullable
              as Mappings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentImpl implements _Document {
  const _$DocumentImpl(
      {required this.datamodel, required this.schema, required this.mappings});

  factory _$DocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentImplFromJson(json);

  @override
  final Datamodel datamodel;
  @override
  final Schema schema;
  @override
  final Mappings mappings;

  @override
  String toString() {
    return 'Document(datamodel: $datamodel, schema: $schema, mappings: $mappings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentImpl &&
            (identical(other.datamodel, datamodel) ||
                other.datamodel == datamodel) &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.mappings, mappings) ||
                other.mappings == mappings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, datamodel, schema, mappings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      __$$DocumentImplCopyWithImpl<_$DocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentImplToJson(
      this,
    );
  }
}

abstract class _Document implements Document {
  const factory _Document(
      {required final Datamodel datamodel,
      required final Schema schema,
      required final Mappings mappings}) = _$DocumentImpl;

  factory _Document.fromJson(Map<String, dynamic> json) =
      _$DocumentImpl.fromJson;

  @override
  Datamodel get datamodel;
  @override
  Schema get schema;
  @override
  Mappings get mappings;
  @override
  @JsonKey(ignore: true)
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Datamodel _$DatamodelFromJson(Map<String, dynamic> json) {
  return _Datamodel.fromJson(json);
}

/// @nodoc
mixin _$Datamodel {
  List<Model> get models => throw _privateConstructorUsedError;
  List<DatamodelEnum> get enums => throw _privateConstructorUsedError;
  List<Model> get types => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DatamodelCopyWith<Datamodel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatamodelCopyWith<$Res> {
  factory $DatamodelCopyWith(Datamodel value, $Res Function(Datamodel) then) =
      _$DatamodelCopyWithImpl<$Res, Datamodel>;
  @useResult
  $Res call({List<Model> models, List<DatamodelEnum> enums, List<Model> types});
}

/// @nodoc
class _$DatamodelCopyWithImpl<$Res, $Val extends Datamodel>
    implements $DatamodelCopyWith<$Res> {
  _$DatamodelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? models = null,
    Object? enums = null,
    Object? types = null,
  }) {
    return _then(_value.copyWith(
      models: null == models
          ? _value.models
          : models // ignore: cast_nullable_to_non_nullable
              as List<Model>,
      enums: null == enums
          ? _value.enums
          : enums // ignore: cast_nullable_to_non_nullable
              as List<DatamodelEnum>,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<Model>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DatamodelImplCopyWith<$Res>
    implements $DatamodelCopyWith<$Res> {
  factory _$$DatamodelImplCopyWith(
          _$DatamodelImpl value, $Res Function(_$DatamodelImpl) then) =
      __$$DatamodelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Model> models, List<DatamodelEnum> enums, List<Model> types});
}

/// @nodoc
class __$$DatamodelImplCopyWithImpl<$Res>
    extends _$DatamodelCopyWithImpl<$Res, _$DatamodelImpl>
    implements _$$DatamodelImplCopyWith<$Res> {
  __$$DatamodelImplCopyWithImpl(
      _$DatamodelImpl _value, $Res Function(_$DatamodelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? models = null,
    Object? enums = null,
    Object? types = null,
  }) {
    return _then(_$DatamodelImpl(
      models: null == models
          ? _value._models
          : models // ignore: cast_nullable_to_non_nullable
              as List<Model>,
      enums: null == enums
          ? _value._enums
          : enums // ignore: cast_nullable_to_non_nullable
              as List<DatamodelEnum>,
      types: null == types
          ? _value._types
          : types // ignore: cast_nullable_to_non_nullable
              as List<Model>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DatamodelImpl implements _Datamodel {
  const _$DatamodelImpl(
      {required final List<Model> models,
      required final List<DatamodelEnum> enums,
      required final List<Model> types})
      : _models = models,
        _enums = enums,
        _types = types;

  factory _$DatamodelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DatamodelImplFromJson(json);

  final List<Model> _models;
  @override
  List<Model> get models {
    if (_models is EqualUnmodifiableListView) return _models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_models);
  }

  final List<DatamodelEnum> _enums;
  @override
  List<DatamodelEnum> get enums {
    if (_enums is EqualUnmodifiableListView) return _enums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_enums);
  }

  final List<Model> _types;
  @override
  List<Model> get types {
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_types);
  }

  @override
  String toString() {
    return 'Datamodel(models: $models, enums: $enums, types: $types)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatamodelImpl &&
            const DeepCollectionEquality().equals(other._models, _models) &&
            const DeepCollectionEquality().equals(other._enums, _enums) &&
            const DeepCollectionEquality().equals(other._types, _types));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_models),
      const DeepCollectionEquality().hash(_enums),
      const DeepCollectionEquality().hash(_types));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DatamodelImplCopyWith<_$DatamodelImpl> get copyWith =>
      __$$DatamodelImplCopyWithImpl<_$DatamodelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DatamodelImplToJson(
      this,
    );
  }
}

abstract class _Datamodel implements Datamodel {
  const factory _Datamodel(
      {required final List<Model> models,
      required final List<DatamodelEnum> enums,
      required final List<Model> types}) = _$DatamodelImpl;

  factory _Datamodel.fromJson(Map<String, dynamic> json) =
      _$DatamodelImpl.fromJson;

  @override
  List<Model> get models;
  @override
  List<DatamodelEnum> get enums;
  @override
  List<Model> get types;
  @override
  @JsonKey(ignore: true)
  _$$DatamodelImplCopyWith<_$DatamodelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Model _$ModelFromJson(Map<String, dynamic> json) {
  return _Model.fromJson(json);
}

/// @nodoc
mixin _$Model {
  String get name => throw _privateConstructorUsedError;
  String? get dbName => throw _privateConstructorUsedError;
  List<Field> get fields => throw _privateConstructorUsedError;
  List<List<String>> get uniqueFields => throw _privateConstructorUsedError;
  List<UniqueIndex> get uniqueIndexes => throw _privateConstructorUsedError;
  String? get documentation => throw _privateConstructorUsedError;
  PrimaryKey? get primaryKey => throw _privateConstructorUsedError;
  bool? get isGenerated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ModelCopyWith<Model> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelCopyWith<$Res> {
  factory $ModelCopyWith(Model value, $Res Function(Model) then) =
      _$ModelCopyWithImpl<$Res, Model>;
  @useResult
  $Res call(
      {String name,
      String? dbName,
      List<Field> fields,
      List<List<String>> uniqueFields,
      List<UniqueIndex> uniqueIndexes,
      String? documentation,
      PrimaryKey? primaryKey,
      bool? isGenerated});

  $PrimaryKeyCopyWith<$Res>? get primaryKey;
}

/// @nodoc
class _$ModelCopyWithImpl<$Res, $Val extends Model>
    implements $ModelCopyWith<$Res> {
  _$ModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dbName = freezed,
    Object? fields = null,
    Object? uniqueFields = null,
    Object? uniqueIndexes = null,
    Object? documentation = freezed,
    Object? primaryKey = freezed,
    Object? isGenerated = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dbName: freezed == dbName
          ? _value.dbName
          : dbName // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<Field>,
      uniqueFields: null == uniqueFields
          ? _value.uniqueFields
          : uniqueFields // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      uniqueIndexes: null == uniqueIndexes
          ? _value.uniqueIndexes
          : uniqueIndexes // ignore: cast_nullable_to_non_nullable
              as List<UniqueIndex>,
      documentation: freezed == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryKey: freezed == primaryKey
          ? _value.primaryKey
          : primaryKey // ignore: cast_nullable_to_non_nullable
              as PrimaryKey?,
      isGenerated: freezed == isGenerated
          ? _value.isGenerated
          : isGenerated // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PrimaryKeyCopyWith<$Res>? get primaryKey {
    if (_value.primaryKey == null) {
      return null;
    }

    return $PrimaryKeyCopyWith<$Res>(_value.primaryKey!, (value) {
      return _then(_value.copyWith(primaryKey: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ModelImplCopyWith<$Res> implements $ModelCopyWith<$Res> {
  factory _$$ModelImplCopyWith(
          _$ModelImpl value, $Res Function(_$ModelImpl) then) =
      __$$ModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? dbName,
      List<Field> fields,
      List<List<String>> uniqueFields,
      List<UniqueIndex> uniqueIndexes,
      String? documentation,
      PrimaryKey? primaryKey,
      bool? isGenerated});

  @override
  $PrimaryKeyCopyWith<$Res>? get primaryKey;
}

/// @nodoc
class __$$ModelImplCopyWithImpl<$Res>
    extends _$ModelCopyWithImpl<$Res, _$ModelImpl>
    implements _$$ModelImplCopyWith<$Res> {
  __$$ModelImplCopyWithImpl(
      _$ModelImpl _value, $Res Function(_$ModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dbName = freezed,
    Object? fields = null,
    Object? uniqueFields = null,
    Object? uniqueIndexes = null,
    Object? documentation = freezed,
    Object? primaryKey = freezed,
    Object? isGenerated = freezed,
  }) {
    return _then(_$ModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dbName: freezed == dbName
          ? _value.dbName
          : dbName // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<Field>,
      uniqueFields: null == uniqueFields
          ? _value._uniqueFields
          : uniqueFields // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      uniqueIndexes: null == uniqueIndexes
          ? _value._uniqueIndexes
          : uniqueIndexes // ignore: cast_nullable_to_non_nullable
              as List<UniqueIndex>,
      documentation: freezed == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryKey: freezed == primaryKey
          ? _value.primaryKey
          : primaryKey // ignore: cast_nullable_to_non_nullable
              as PrimaryKey?,
      isGenerated: freezed == isGenerated
          ? _value.isGenerated
          : isGenerated // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModelImpl implements _Model {
  const _$ModelImpl(
      {required this.name,
      this.dbName,
      required final List<Field> fields,
      required final List<List<String>> uniqueFields,
      required final List<UniqueIndex> uniqueIndexes,
      this.documentation,
      this.primaryKey,
      this.isGenerated})
      : _fields = fields,
        _uniqueFields = uniqueFields,
        _uniqueIndexes = uniqueIndexes;

  factory _$ModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModelImplFromJson(json);

  @override
  final String name;
  @override
  final String? dbName;
  final List<Field> _fields;
  @override
  List<Field> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  final List<List<String>> _uniqueFields;
  @override
  List<List<String>> get uniqueFields {
    if (_uniqueFields is EqualUnmodifiableListView) return _uniqueFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uniqueFields);
  }

  final List<UniqueIndex> _uniqueIndexes;
  @override
  List<UniqueIndex> get uniqueIndexes {
    if (_uniqueIndexes is EqualUnmodifiableListView) return _uniqueIndexes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uniqueIndexes);
  }

  @override
  final String? documentation;
  @override
  final PrimaryKey? primaryKey;
  @override
  final bool? isGenerated;

  @override
  String toString() {
    return 'Model(name: $name, dbName: $dbName, fields: $fields, uniqueFields: $uniqueFields, uniqueIndexes: $uniqueIndexes, documentation: $documentation, primaryKey: $primaryKey, isGenerated: $isGenerated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dbName, dbName) || other.dbName == dbName) &&
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            const DeepCollectionEquality()
                .equals(other._uniqueFields, _uniqueFields) &&
            const DeepCollectionEquality()
                .equals(other._uniqueIndexes, _uniqueIndexes) &&
            (identical(other.documentation, documentation) ||
                other.documentation == documentation) &&
            (identical(other.primaryKey, primaryKey) ||
                other.primaryKey == primaryKey) &&
            (identical(other.isGenerated, isGenerated) ||
                other.isGenerated == isGenerated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      dbName,
      const DeepCollectionEquality().hash(_fields),
      const DeepCollectionEquality().hash(_uniqueFields),
      const DeepCollectionEquality().hash(_uniqueIndexes),
      documentation,
      primaryKey,
      isGenerated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelImplCopyWith<_$ModelImpl> get copyWith =>
      __$$ModelImplCopyWithImpl<_$ModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModelImplToJson(
      this,
    );
  }
}

abstract class _Model implements Model {
  const factory _Model(
      {required final String name,
      final String? dbName,
      required final List<Field> fields,
      required final List<List<String>> uniqueFields,
      required final List<UniqueIndex> uniqueIndexes,
      final String? documentation,
      final PrimaryKey? primaryKey,
      final bool? isGenerated}) = _$ModelImpl;

  factory _Model.fromJson(Map<String, dynamic> json) = _$ModelImpl.fromJson;

  @override
  String get name;
  @override
  String? get dbName;
  @override
  List<Field> get fields;
  @override
  List<List<String>> get uniqueFields;
  @override
  List<UniqueIndex> get uniqueIndexes;
  @override
  String? get documentation;
  @override
  PrimaryKey? get primaryKey;
  @override
  bool? get isGenerated;
  @override
  @JsonKey(ignore: true)
  _$$ModelImplCopyWith<_$ModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Field _$FieldFromJson(Map<String, dynamic> json) {
  return _Field.fromJson(json);
}

/// @nodoc
mixin _$Field {
  FieldKind get kind => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  bool get isList => throw _privateConstructorUsedError;
  bool get isUnique => throw _privateConstructorUsedError;
  bool get isId => throw _privateConstructorUsedError;
  bool get isReadOnly => throw _privateConstructorUsedError;
  bool? get isGenerated => throw _privateConstructorUsedError;
  bool? get isUpdatedAt => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get dbName => throw _privateConstructorUsedError;
  bool get hasDefaultValue => throw _privateConstructorUsedError;
  Object? get default$ => throw _privateConstructorUsedError;
  List<String>? get relationFromFields => throw _privateConstructorUsedError;
  List<dynamic>? get relationToFields => throw _privateConstructorUsedError;
  String? get relationOnDelete => throw _privateConstructorUsedError;
  String? get relationName => throw _privateConstructorUsedError;
  String? get documentation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldCopyWith<Field> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldCopyWith<$Res> {
  factory $FieldCopyWith(Field value, $Res Function(Field) then) =
      _$FieldCopyWithImpl<$Res, Field>;
  @useResult
  $Res call(
      {FieldKind kind,
      String name,
      bool isRequired,
      bool isList,
      bool isUnique,
      bool isId,
      bool isReadOnly,
      bool? isGenerated,
      bool? isUpdatedAt,
      String type,
      String? dbName,
      bool hasDefaultValue,
      Object? default$,
      List<String>? relationFromFields,
      List<dynamic>? relationToFields,
      String? relationOnDelete,
      String? relationName,
      String? documentation});
}

/// @nodoc
class _$FieldCopyWithImpl<$Res, $Val extends Field>
    implements $FieldCopyWith<$Res> {
  _$FieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = null,
    Object? name = null,
    Object? isRequired = null,
    Object? isList = null,
    Object? isUnique = null,
    Object? isId = null,
    Object? isReadOnly = null,
    Object? isGenerated = freezed,
    Object? isUpdatedAt = freezed,
    Object? type = null,
    Object? dbName = freezed,
    Object? hasDefaultValue = null,
    Object? default$ = freezed,
    Object? relationFromFields = freezed,
    Object? relationToFields = freezed,
    Object? relationOnDelete = freezed,
    Object? relationName = freezed,
    Object? documentation = freezed,
  }) {
    return _then(_value.copyWith(
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as FieldKind,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      isList: null == isList
          ? _value.isList
          : isList // ignore: cast_nullable_to_non_nullable
              as bool,
      isUnique: null == isUnique
          ? _value.isUnique
          : isUnique // ignore: cast_nullable_to_non_nullable
              as bool,
      isId: null == isId
          ? _value.isId
          : isId // ignore: cast_nullable_to_non_nullable
              as bool,
      isReadOnly: null == isReadOnly
          ? _value.isReadOnly
          : isReadOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      isGenerated: freezed == isGenerated
          ? _value.isGenerated
          : isGenerated // ignore: cast_nullable_to_non_nullable
              as bool?,
      isUpdatedAt: freezed == isUpdatedAt
          ? _value.isUpdatedAt
          : isUpdatedAt // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      dbName: freezed == dbName
          ? _value.dbName
          : dbName // ignore: cast_nullable_to_non_nullable
              as String?,
      hasDefaultValue: null == hasDefaultValue
          ? _value.hasDefaultValue
          : hasDefaultValue // ignore: cast_nullable_to_non_nullable
              as bool,
      default$: freezed == default$ ? _value.default$ : default$,
      relationFromFields: freezed == relationFromFields
          ? _value.relationFromFields
          : relationFromFields // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      relationToFields: freezed == relationToFields
          ? _value.relationToFields
          : relationToFields // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      relationOnDelete: freezed == relationOnDelete
          ? _value.relationOnDelete
          : relationOnDelete // ignore: cast_nullable_to_non_nullable
              as String?,
      relationName: freezed == relationName
          ? _value.relationName
          : relationName // ignore: cast_nullable_to_non_nullable
              as String?,
      documentation: freezed == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldImplCopyWith<$Res> implements $FieldCopyWith<$Res> {
  factory _$$FieldImplCopyWith(
          _$FieldImpl value, $Res Function(_$FieldImpl) then) =
      __$$FieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FieldKind kind,
      String name,
      bool isRequired,
      bool isList,
      bool isUnique,
      bool isId,
      bool isReadOnly,
      bool? isGenerated,
      bool? isUpdatedAt,
      String type,
      String? dbName,
      bool hasDefaultValue,
      Object? default$,
      List<String>? relationFromFields,
      List<dynamic>? relationToFields,
      String? relationOnDelete,
      String? relationName,
      String? documentation});
}

/// @nodoc
class __$$FieldImplCopyWithImpl<$Res>
    extends _$FieldCopyWithImpl<$Res, _$FieldImpl>
    implements _$$FieldImplCopyWith<$Res> {
  __$$FieldImplCopyWithImpl(
      _$FieldImpl _value, $Res Function(_$FieldImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = null,
    Object? name = null,
    Object? isRequired = null,
    Object? isList = null,
    Object? isUnique = null,
    Object? isId = null,
    Object? isReadOnly = null,
    Object? isGenerated = freezed,
    Object? isUpdatedAt = freezed,
    Object? type = null,
    Object? dbName = freezed,
    Object? hasDefaultValue = null,
    Object? default$ = freezed,
    Object? relationFromFields = freezed,
    Object? relationToFields = freezed,
    Object? relationOnDelete = freezed,
    Object? relationName = freezed,
    Object? documentation = freezed,
  }) {
    return _then(_$FieldImpl(
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as FieldKind,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      isList: null == isList
          ? _value.isList
          : isList // ignore: cast_nullable_to_non_nullable
              as bool,
      isUnique: null == isUnique
          ? _value.isUnique
          : isUnique // ignore: cast_nullable_to_non_nullable
              as bool,
      isId: null == isId
          ? _value.isId
          : isId // ignore: cast_nullable_to_non_nullable
              as bool,
      isReadOnly: null == isReadOnly
          ? _value.isReadOnly
          : isReadOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      isGenerated: freezed == isGenerated
          ? _value.isGenerated
          : isGenerated // ignore: cast_nullable_to_non_nullable
              as bool?,
      isUpdatedAt: freezed == isUpdatedAt
          ? _value.isUpdatedAt
          : isUpdatedAt // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      dbName: freezed == dbName
          ? _value.dbName
          : dbName // ignore: cast_nullable_to_non_nullable
              as String?,
      hasDefaultValue: null == hasDefaultValue
          ? _value.hasDefaultValue
          : hasDefaultValue // ignore: cast_nullable_to_non_nullable
              as bool,
      default$: freezed == default$ ? _value.default$ : default$,
      relationFromFields: freezed == relationFromFields
          ? _value._relationFromFields
          : relationFromFields // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      relationToFields: freezed == relationToFields
          ? _value._relationToFields
          : relationToFields // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      relationOnDelete: freezed == relationOnDelete
          ? _value.relationOnDelete
          : relationOnDelete // ignore: cast_nullable_to_non_nullable
              as String?,
      relationName: freezed == relationName
          ? _value.relationName
          : relationName // ignore: cast_nullable_to_non_nullable
              as String?,
      documentation: freezed == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldImpl implements _Field {
  const _$FieldImpl(
      {required this.kind,
      required this.name,
      required this.isRequired,
      required this.isList,
      required this.isUnique,
      required this.isId,
      required this.isReadOnly,
      this.isGenerated,
      this.isUpdatedAt,
      required this.type,
      this.dbName,
      required this.hasDefaultValue,
      this.default$,
      final List<String>? relationFromFields,
      final List<dynamic>? relationToFields,
      this.relationOnDelete,
      this.relationName,
      this.documentation})
      : _relationFromFields = relationFromFields,
        _relationToFields = relationToFields;

  factory _$FieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldImplFromJson(json);

  @override
  final FieldKind kind;
  @override
  final String name;
  @override
  final bool isRequired;
  @override
  final bool isList;
  @override
  final bool isUnique;
  @override
  final bool isId;
  @override
  final bool isReadOnly;
  @override
  final bool? isGenerated;
  @override
  final bool? isUpdatedAt;
  @override
  final String type;
  @override
  final String? dbName;
  @override
  final bool hasDefaultValue;
  @override
  final Object? default$;
  final List<String>? _relationFromFields;
  @override
  List<String>? get relationFromFields {
    final value = _relationFromFields;
    if (value == null) return null;
    if (_relationFromFields is EqualUnmodifiableListView)
      return _relationFromFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _relationToFields;
  @override
  List<dynamic>? get relationToFields {
    final value = _relationToFields;
    if (value == null) return null;
    if (_relationToFields is EqualUnmodifiableListView)
      return _relationToFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? relationOnDelete;
  @override
  final String? relationName;
  @override
  final String? documentation;

  @override
  String toString() {
    return 'Field(kind: $kind, name: $name, isRequired: $isRequired, isList: $isList, isUnique: $isUnique, isId: $isId, isReadOnly: $isReadOnly, isGenerated: $isGenerated, isUpdatedAt: $isUpdatedAt, type: $type, dbName: $dbName, hasDefaultValue: $hasDefaultValue, default\$: ${default$}, relationFromFields: $relationFromFields, relationToFields: $relationToFields, relationOnDelete: $relationOnDelete, relationName: $relationName, documentation: $documentation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldImpl &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.isList, isList) || other.isList == isList) &&
            (identical(other.isUnique, isUnique) ||
                other.isUnique == isUnique) &&
            (identical(other.isId, isId) || other.isId == isId) &&
            (identical(other.isReadOnly, isReadOnly) ||
                other.isReadOnly == isReadOnly) &&
            (identical(other.isGenerated, isGenerated) ||
                other.isGenerated == isGenerated) &&
            (identical(other.isUpdatedAt, isUpdatedAt) ||
                other.isUpdatedAt == isUpdatedAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.dbName, dbName) || other.dbName == dbName) &&
            (identical(other.hasDefaultValue, hasDefaultValue) ||
                other.hasDefaultValue == hasDefaultValue) &&
            const DeepCollectionEquality().equals(other.default$, default$) &&
            const DeepCollectionEquality()
                .equals(other._relationFromFields, _relationFromFields) &&
            const DeepCollectionEquality()
                .equals(other._relationToFields, _relationToFields) &&
            (identical(other.relationOnDelete, relationOnDelete) ||
                other.relationOnDelete == relationOnDelete) &&
            (identical(other.relationName, relationName) ||
                other.relationName == relationName) &&
            (identical(other.documentation, documentation) ||
                other.documentation == documentation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      kind,
      name,
      isRequired,
      isList,
      isUnique,
      isId,
      isReadOnly,
      isGenerated,
      isUpdatedAt,
      type,
      dbName,
      hasDefaultValue,
      const DeepCollectionEquality().hash(default$),
      const DeepCollectionEquality().hash(_relationFromFields),
      const DeepCollectionEquality().hash(_relationToFields),
      relationOnDelete,
      relationName,
      documentation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldImplCopyWith<_$FieldImpl> get copyWith =>
      __$$FieldImplCopyWithImpl<_$FieldImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldImplToJson(
      this,
    );
  }
}

abstract class _Field implements Field {
  const factory _Field(
      {required final FieldKind kind,
      required final String name,
      required final bool isRequired,
      required final bool isList,
      required final bool isUnique,
      required final bool isId,
      required final bool isReadOnly,
      final bool? isGenerated,
      final bool? isUpdatedAt,
      required final String type,
      final String? dbName,
      required final bool hasDefaultValue,
      final Object? default$,
      final List<String>? relationFromFields,
      final List<dynamic>? relationToFields,
      final String? relationOnDelete,
      final String? relationName,
      final String? documentation}) = _$FieldImpl;

  factory _Field.fromJson(Map<String, dynamic> json) = _$FieldImpl.fromJson;

  @override
  FieldKind get kind;
  @override
  String get name;
  @override
  bool get isRequired;
  @override
  bool get isList;
  @override
  bool get isUnique;
  @override
  bool get isId;
  @override
  bool get isReadOnly;
  @override
  bool? get isGenerated;
  @override
  bool? get isUpdatedAt;
  @override
  String get type;
  @override
  String? get dbName;
  @override
  bool get hasDefaultValue;
  @override
  Object? get default$;
  @override
  List<String>? get relationFromFields;
  @override
  List<dynamic>? get relationToFields;
  @override
  String? get relationOnDelete;
  @override
  String? get relationName;
  @override
  String? get documentation;
  @override
  @JsonKey(ignore: true)
  _$$FieldImplCopyWith<_$FieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UniqueIndex _$UniqueIndexFromJson(Map<String, dynamic> json) {
  return _UniqueIndex.fromJson(json);
}

/// @nodoc
mixin _$UniqueIndex {
  String? get name => throw _privateConstructorUsedError;
  List<String> get fields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UniqueIndexCopyWith<UniqueIndex> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UniqueIndexCopyWith<$Res> {
  factory $UniqueIndexCopyWith(
          UniqueIndex value, $Res Function(UniqueIndex) then) =
      _$UniqueIndexCopyWithImpl<$Res, UniqueIndex>;
  @useResult
  $Res call({String? name, List<String> fields});
}

/// @nodoc
class _$UniqueIndexCopyWithImpl<$Res, $Val extends UniqueIndex>
    implements $UniqueIndexCopyWith<$Res> {
  _$UniqueIndexCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? fields = null,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UniqueIndexImplCopyWith<$Res>
    implements $UniqueIndexCopyWith<$Res> {
  factory _$$UniqueIndexImplCopyWith(
          _$UniqueIndexImpl value, $Res Function(_$UniqueIndexImpl) then) =
      __$$UniqueIndexImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, List<String> fields});
}

/// @nodoc
class __$$UniqueIndexImplCopyWithImpl<$Res>
    extends _$UniqueIndexCopyWithImpl<$Res, _$UniqueIndexImpl>
    implements _$$UniqueIndexImplCopyWith<$Res> {
  __$$UniqueIndexImplCopyWithImpl(
      _$UniqueIndexImpl _value, $Res Function(_$UniqueIndexImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? fields = null,
  }) {
    return _then(_$UniqueIndexImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UniqueIndexImpl implements _UniqueIndex {
  const _$UniqueIndexImpl({this.name, required final List<String> fields})
      : _fields = fields;

  factory _$UniqueIndexImpl.fromJson(Map<String, dynamic> json) =>
      _$$UniqueIndexImplFromJson(json);

  @override
  final String? name;
  final List<String> _fields;
  @override
  List<String> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  String toString() {
    return 'UniqueIndex(name: $name, fields: $fields)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UniqueIndexImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UniqueIndexImplCopyWith<_$UniqueIndexImpl> get copyWith =>
      __$$UniqueIndexImplCopyWithImpl<_$UniqueIndexImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UniqueIndexImplToJson(
      this,
    );
  }
}

abstract class _UniqueIndex implements UniqueIndex {
  const factory _UniqueIndex(
      {final String? name,
      required final List<String> fields}) = _$UniqueIndexImpl;

  factory _UniqueIndex.fromJson(Map<String, dynamic> json) =
      _$UniqueIndexImpl.fromJson;

  @override
  String? get name;
  @override
  List<String> get fields;
  @override
  @JsonKey(ignore: true)
  _$$UniqueIndexImplCopyWith<_$UniqueIndexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PrimaryKey _$PrimaryKeyFromJson(Map<String, dynamic> json) {
  return _PrimaryKey.fromJson(json);
}

/// @nodoc
mixin _$PrimaryKey {
  String? get name => throw _privateConstructorUsedError;
  List<String> get fields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrimaryKeyCopyWith<PrimaryKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrimaryKeyCopyWith<$Res> {
  factory $PrimaryKeyCopyWith(
          PrimaryKey value, $Res Function(PrimaryKey) then) =
      _$PrimaryKeyCopyWithImpl<$Res, PrimaryKey>;
  @useResult
  $Res call({String? name, List<String> fields});
}

/// @nodoc
class _$PrimaryKeyCopyWithImpl<$Res, $Val extends PrimaryKey>
    implements $PrimaryKeyCopyWith<$Res> {
  _$PrimaryKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? fields = null,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrimaryKeyImplCopyWith<$Res>
    implements $PrimaryKeyCopyWith<$Res> {
  factory _$$PrimaryKeyImplCopyWith(
          _$PrimaryKeyImpl value, $Res Function(_$PrimaryKeyImpl) then) =
      __$$PrimaryKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, List<String> fields});
}

/// @nodoc
class __$$PrimaryKeyImplCopyWithImpl<$Res>
    extends _$PrimaryKeyCopyWithImpl<$Res, _$PrimaryKeyImpl>
    implements _$$PrimaryKeyImplCopyWith<$Res> {
  __$$PrimaryKeyImplCopyWithImpl(
      _$PrimaryKeyImpl _value, $Res Function(_$PrimaryKeyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? fields = null,
  }) {
    return _then(_$PrimaryKeyImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrimaryKeyImpl implements _PrimaryKey {
  const _$PrimaryKeyImpl({this.name, required final List<String> fields})
      : _fields = fields;

  factory _$PrimaryKeyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrimaryKeyImplFromJson(json);

  @override
  final String? name;
  final List<String> _fields;
  @override
  List<String> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  String toString() {
    return 'PrimaryKey(name: $name, fields: $fields)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrimaryKeyImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrimaryKeyImplCopyWith<_$PrimaryKeyImpl> get copyWith =>
      __$$PrimaryKeyImplCopyWithImpl<_$PrimaryKeyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrimaryKeyImplToJson(
      this,
    );
  }
}

abstract class _PrimaryKey implements PrimaryKey {
  const factory _PrimaryKey(
      {final String? name,
      required final List<String> fields}) = _$PrimaryKeyImpl;

  factory _PrimaryKey.fromJson(Map<String, dynamic> json) =
      _$PrimaryKeyImpl.fromJson;

  @override
  String? get name;
  @override
  List<String> get fields;
  @override
  @JsonKey(ignore: true)
  _$$PrimaryKeyImplCopyWith<_$PrimaryKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DatamodelEnum _$DatamodelEnumFromJson(Map<String, dynamic> json) {
  return _DatamodelEnum.fromJson(json);
}

/// @nodoc
mixin _$DatamodelEnum {
  String get name => throw _privateConstructorUsedError;
  List<EnumValue> get values => throw _privateConstructorUsedError;
  String? get dbName => throw _privateConstructorUsedError;
  String? get documentation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DatamodelEnumCopyWith<DatamodelEnum> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatamodelEnumCopyWith<$Res> {
  factory $DatamodelEnumCopyWith(
          DatamodelEnum value, $Res Function(DatamodelEnum) then) =
      _$DatamodelEnumCopyWithImpl<$Res, DatamodelEnum>;
  @useResult
  $Res call(
      {String name,
      List<EnumValue> values,
      String? dbName,
      String? documentation});
}

/// @nodoc
class _$DatamodelEnumCopyWithImpl<$Res, $Val extends DatamodelEnum>
    implements $DatamodelEnumCopyWith<$Res> {
  _$DatamodelEnumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? values = null,
    Object? dbName = freezed,
    Object? documentation = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<EnumValue>,
      dbName: freezed == dbName
          ? _value.dbName
          : dbName // ignore: cast_nullable_to_non_nullable
              as String?,
      documentation: freezed == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DatamodelEnumImplCopyWith<$Res>
    implements $DatamodelEnumCopyWith<$Res> {
  factory _$$DatamodelEnumImplCopyWith(
          _$DatamodelEnumImpl value, $Res Function(_$DatamodelEnumImpl) then) =
      __$$DatamodelEnumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      List<EnumValue> values,
      String? dbName,
      String? documentation});
}

/// @nodoc
class __$$DatamodelEnumImplCopyWithImpl<$Res>
    extends _$DatamodelEnumCopyWithImpl<$Res, _$DatamodelEnumImpl>
    implements _$$DatamodelEnumImplCopyWith<$Res> {
  __$$DatamodelEnumImplCopyWithImpl(
      _$DatamodelEnumImpl _value, $Res Function(_$DatamodelEnumImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? values = null,
    Object? dbName = freezed,
    Object? documentation = freezed,
  }) {
    return _then(_$DatamodelEnumImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<EnumValue>,
      dbName: freezed == dbName
          ? _value.dbName
          : dbName // ignore: cast_nullable_to_non_nullable
              as String?,
      documentation: freezed == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DatamodelEnumImpl implements _DatamodelEnum {
  const _$DatamodelEnumImpl(
      {required this.name,
      required final List<EnumValue> values,
      this.dbName,
      this.documentation})
      : _values = values;

  factory _$DatamodelEnumImpl.fromJson(Map<String, dynamic> json) =>
      _$$DatamodelEnumImplFromJson(json);

  @override
  final String name;
  final List<EnumValue> _values;
  @override
  List<EnumValue> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  final String? dbName;
  @override
  final String? documentation;

  @override
  String toString() {
    return 'DatamodelEnum(name: $name, values: $values, dbName: $dbName, documentation: $documentation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatamodelEnumImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            (identical(other.dbName, dbName) || other.dbName == dbName) &&
            (identical(other.documentation, documentation) ||
                other.documentation == documentation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name,
      const DeepCollectionEquality().hash(_values), dbName, documentation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DatamodelEnumImplCopyWith<_$DatamodelEnumImpl> get copyWith =>
      __$$DatamodelEnumImplCopyWithImpl<_$DatamodelEnumImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DatamodelEnumImplToJson(
      this,
    );
  }
}

abstract class _DatamodelEnum implements DatamodelEnum {
  const factory _DatamodelEnum(
      {required final String name,
      required final List<EnumValue> values,
      final String? dbName,
      final String? documentation}) = _$DatamodelEnumImpl;

  factory _DatamodelEnum.fromJson(Map<String, dynamic> json) =
      _$DatamodelEnumImpl.fromJson;

  @override
  String get name;
  @override
  List<EnumValue> get values;
  @override
  String? get dbName;
  @override
  String? get documentation;
  @override
  @JsonKey(ignore: true)
  _$$DatamodelEnumImplCopyWith<_$DatamodelEnumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EnumValue _$EnumValueFromJson(Map<String, dynamic> json) {
  return _EnumValue.fromJson(json);
}

/// @nodoc
mixin _$EnumValue {
  String get name => throw _privateConstructorUsedError;
  String? get dbName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EnumValueCopyWith<EnumValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnumValueCopyWith<$Res> {
  factory $EnumValueCopyWith(EnumValue value, $Res Function(EnumValue) then) =
      _$EnumValueCopyWithImpl<$Res, EnumValue>;
  @useResult
  $Res call({String name, String? dbName});
}

/// @nodoc
class _$EnumValueCopyWithImpl<$Res, $Val extends EnumValue>
    implements $EnumValueCopyWith<$Res> {
  _$EnumValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dbName = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dbName: freezed == dbName
          ? _value.dbName
          : dbName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnumValueImplCopyWith<$Res>
    implements $EnumValueCopyWith<$Res> {
  factory _$$EnumValueImplCopyWith(
          _$EnumValueImpl value, $Res Function(_$EnumValueImpl) then) =
      __$$EnumValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? dbName});
}

/// @nodoc
class __$$EnumValueImplCopyWithImpl<$Res>
    extends _$EnumValueCopyWithImpl<$Res, _$EnumValueImpl>
    implements _$$EnumValueImplCopyWith<$Res> {
  __$$EnumValueImplCopyWithImpl(
      _$EnumValueImpl _value, $Res Function(_$EnumValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dbName = freezed,
  }) {
    return _then(_$EnumValueImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dbName: freezed == dbName
          ? _value.dbName
          : dbName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnumValueImpl implements _EnumValue {
  const _$EnumValueImpl({required this.name, this.dbName});

  factory _$EnumValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnumValueImplFromJson(json);

  @override
  final String name;
  @override
  final String? dbName;

  @override
  String toString() {
    return 'EnumValue(name: $name, dbName: $dbName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnumValueImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dbName, dbName) || other.dbName == dbName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, dbName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EnumValueImplCopyWith<_$EnumValueImpl> get copyWith =>
      __$$EnumValueImplCopyWithImpl<_$EnumValueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnumValueImplToJson(
      this,
    );
  }
}

abstract class _EnumValue implements EnumValue {
  const factory _EnumValue({required final String name, final String? dbName}) =
      _$EnumValueImpl;

  factory _EnumValue.fromJson(Map<String, dynamic> json) =
      _$EnumValueImpl.fromJson;

  @override
  String get name;
  @override
  String? get dbName;
  @override
  @JsonKey(ignore: true)
  _$$EnumValueImplCopyWith<_$EnumValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Mappings _$MappingsFromJson(Map<String, dynamic> json) {
  return _Mappings.fromJson(json);
}

/// @nodoc
mixin _$Mappings {
  List<ModelMapping> get modelOperations => throw _privateConstructorUsedError;
  OtherOperations get otherOperations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MappingsCopyWith<Mappings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MappingsCopyWith<$Res> {
  factory $MappingsCopyWith(Mappings value, $Res Function(Mappings) then) =
      _$MappingsCopyWithImpl<$Res, Mappings>;
  @useResult
  $Res call(
      {List<ModelMapping> modelOperations, OtherOperations otherOperations});

  $OtherOperationsCopyWith<$Res> get otherOperations;
}

/// @nodoc
class _$MappingsCopyWithImpl<$Res, $Val extends Mappings>
    implements $MappingsCopyWith<$Res> {
  _$MappingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelOperations = null,
    Object? otherOperations = null,
  }) {
    return _then(_value.copyWith(
      modelOperations: null == modelOperations
          ? _value.modelOperations
          : modelOperations // ignore: cast_nullable_to_non_nullable
              as List<ModelMapping>,
      otherOperations: null == otherOperations
          ? _value.otherOperations
          : otherOperations // ignore: cast_nullable_to_non_nullable
              as OtherOperations,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OtherOperationsCopyWith<$Res> get otherOperations {
    return $OtherOperationsCopyWith<$Res>(_value.otherOperations, (value) {
      return _then(_value.copyWith(otherOperations: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MappingsImplCopyWith<$Res>
    implements $MappingsCopyWith<$Res> {
  factory _$$MappingsImplCopyWith(
          _$MappingsImpl value, $Res Function(_$MappingsImpl) then) =
      __$$MappingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ModelMapping> modelOperations, OtherOperations otherOperations});

  @override
  $OtherOperationsCopyWith<$Res> get otherOperations;
}

/// @nodoc
class __$$MappingsImplCopyWithImpl<$Res>
    extends _$MappingsCopyWithImpl<$Res, _$MappingsImpl>
    implements _$$MappingsImplCopyWith<$Res> {
  __$$MappingsImplCopyWithImpl(
      _$MappingsImpl _value, $Res Function(_$MappingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelOperations = null,
    Object? otherOperations = null,
  }) {
    return _then(_$MappingsImpl(
      modelOperations: null == modelOperations
          ? _value._modelOperations
          : modelOperations // ignore: cast_nullable_to_non_nullable
              as List<ModelMapping>,
      otherOperations: null == otherOperations
          ? _value.otherOperations
          : otherOperations // ignore: cast_nullable_to_non_nullable
              as OtherOperations,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MappingsImpl implements _Mappings {
  const _$MappingsImpl(
      {required final List<ModelMapping> modelOperations,
      required this.otherOperations})
      : _modelOperations = modelOperations;

  factory _$MappingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MappingsImplFromJson(json);

  final List<ModelMapping> _modelOperations;
  @override
  List<ModelMapping> get modelOperations {
    if (_modelOperations is EqualUnmodifiableListView) return _modelOperations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modelOperations);
  }

  @override
  final OtherOperations otherOperations;

  @override
  String toString() {
    return 'Mappings(modelOperations: $modelOperations, otherOperations: $otherOperations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MappingsImpl &&
            const DeepCollectionEquality()
                .equals(other._modelOperations, _modelOperations) &&
            (identical(other.otherOperations, otherOperations) ||
                other.otherOperations == otherOperations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_modelOperations), otherOperations);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MappingsImplCopyWith<_$MappingsImpl> get copyWith =>
      __$$MappingsImplCopyWithImpl<_$MappingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MappingsImplToJson(
      this,
    );
  }
}

abstract class _Mappings implements Mappings {
  const factory _Mappings(
      {required final List<ModelMapping> modelOperations,
      required final OtherOperations otherOperations}) = _$MappingsImpl;

  factory _Mappings.fromJson(Map<String, dynamic> json) =
      _$MappingsImpl.fromJson;

  @override
  List<ModelMapping> get modelOperations;
  @override
  OtherOperations get otherOperations;
  @override
  @JsonKey(ignore: true)
  _$$MappingsImplCopyWith<_$MappingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtherOperations _$OtherOperationsFromJson(Map<String, dynamic> json) {
  return _OtherOperations.fromJson(json);
}

/// @nodoc
mixin _$OtherOperations {
  List<String> get read => throw _privateConstructorUsedError;
  List<String> get write => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OtherOperationsCopyWith<OtherOperations> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtherOperationsCopyWith<$Res> {
  factory $OtherOperationsCopyWith(
          OtherOperations value, $Res Function(OtherOperations) then) =
      _$OtherOperationsCopyWithImpl<$Res, OtherOperations>;
  @useResult
  $Res call({List<String> read, List<String> write});
}

/// @nodoc
class _$OtherOperationsCopyWithImpl<$Res, $Val extends OtherOperations>
    implements $OtherOperationsCopyWith<$Res> {
  _$OtherOperationsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? read = null,
    Object? write = null,
  }) {
    return _then(_value.copyWith(
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as List<String>,
      write: null == write
          ? _value.write
          : write // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtherOperationsImplCopyWith<$Res>
    implements $OtherOperationsCopyWith<$Res> {
  factory _$$OtherOperationsImplCopyWith(_$OtherOperationsImpl value,
          $Res Function(_$OtherOperationsImpl) then) =
      __$$OtherOperationsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> read, List<String> write});
}

/// @nodoc
class __$$OtherOperationsImplCopyWithImpl<$Res>
    extends _$OtherOperationsCopyWithImpl<$Res, _$OtherOperationsImpl>
    implements _$$OtherOperationsImplCopyWith<$Res> {
  __$$OtherOperationsImplCopyWithImpl(
      _$OtherOperationsImpl _value, $Res Function(_$OtherOperationsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? read = null,
    Object? write = null,
  }) {
    return _then(_$OtherOperationsImpl(
      read: null == read
          ? _value._read
          : read // ignore: cast_nullable_to_non_nullable
              as List<String>,
      write: null == write
          ? _value._write
          : write // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtherOperationsImpl implements _OtherOperations {
  const _$OtherOperationsImpl(
      {required final List<String> read, required final List<String> write})
      : _read = read,
        _write = write;

  factory _$OtherOperationsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtherOperationsImplFromJson(json);

  final List<String> _read;
  @override
  List<String> get read {
    if (_read is EqualUnmodifiableListView) return _read;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_read);
  }

  final List<String> _write;
  @override
  List<String> get write {
    if (_write is EqualUnmodifiableListView) return _write;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_write);
  }

  @override
  String toString() {
    return 'OtherOperations(read: $read, write: $write)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtherOperationsImpl &&
            const DeepCollectionEquality().equals(other._read, _read) &&
            const DeepCollectionEquality().equals(other._write, _write));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_read),
      const DeepCollectionEquality().hash(_write));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtherOperationsImplCopyWith<_$OtherOperationsImpl> get copyWith =>
      __$$OtherOperationsImplCopyWithImpl<_$OtherOperationsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtherOperationsImplToJson(
      this,
    );
  }
}

abstract class _OtherOperations implements OtherOperations {
  const factory _OtherOperations(
      {required final List<String> read,
      required final List<String> write}) = _$OtherOperationsImpl;

  factory _OtherOperations.fromJson(Map<String, dynamic> json) =
      _$OtherOperationsImpl.fromJson;

  @override
  List<String> get read;
  @override
  List<String> get write;
  @override
  @JsonKey(ignore: true)
  _$$OtherOperationsImplCopyWith<_$OtherOperationsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Schema _$SchemaFromJson(Map<String, dynamic> json) {
  return _Schema.fromJson(json);
}

/// @nodoc
mixin _$Schema {
  String? get rootQueryType => throw _privateConstructorUsedError;
  String? get rootMutationType => throw _privateConstructorUsedError;
  InputObjectTypes get inputObjectTypes => throw _privateConstructorUsedError;
  OutputObjectTypes get outputObjectTypes => throw _privateConstructorUsedError;
  EnumTypes get enumTypes => throw _privateConstructorUsedError;
  FieldRefTypes get fieldRefTypes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SchemaCopyWith<Schema> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchemaCopyWith<$Res> {
  factory $SchemaCopyWith(Schema value, $Res Function(Schema) then) =
      _$SchemaCopyWithImpl<$Res, Schema>;
  @useResult
  $Res call(
      {String? rootQueryType,
      String? rootMutationType,
      InputObjectTypes inputObjectTypes,
      OutputObjectTypes outputObjectTypes,
      EnumTypes enumTypes,
      FieldRefTypes fieldRefTypes});

  $InputObjectTypesCopyWith<$Res> get inputObjectTypes;
  $OutputObjectTypesCopyWith<$Res> get outputObjectTypes;
  $EnumTypesCopyWith<$Res> get enumTypes;
  $FieldRefTypesCopyWith<$Res> get fieldRefTypes;
}

/// @nodoc
class _$SchemaCopyWithImpl<$Res, $Val extends Schema>
    implements $SchemaCopyWith<$Res> {
  _$SchemaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rootQueryType = freezed,
    Object? rootMutationType = freezed,
    Object? inputObjectTypes = null,
    Object? outputObjectTypes = null,
    Object? enumTypes = null,
    Object? fieldRefTypes = null,
  }) {
    return _then(_value.copyWith(
      rootQueryType: freezed == rootQueryType
          ? _value.rootQueryType
          : rootQueryType // ignore: cast_nullable_to_non_nullable
              as String?,
      rootMutationType: freezed == rootMutationType
          ? _value.rootMutationType
          : rootMutationType // ignore: cast_nullable_to_non_nullable
              as String?,
      inputObjectTypes: null == inputObjectTypes
          ? _value.inputObjectTypes
          : inputObjectTypes // ignore: cast_nullable_to_non_nullable
              as InputObjectTypes,
      outputObjectTypes: null == outputObjectTypes
          ? _value.outputObjectTypes
          : outputObjectTypes // ignore: cast_nullable_to_non_nullable
              as OutputObjectTypes,
      enumTypes: null == enumTypes
          ? _value.enumTypes
          : enumTypes // ignore: cast_nullable_to_non_nullable
              as EnumTypes,
      fieldRefTypes: null == fieldRefTypes
          ? _value.fieldRefTypes
          : fieldRefTypes // ignore: cast_nullable_to_non_nullable
              as FieldRefTypes,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InputObjectTypesCopyWith<$Res> get inputObjectTypes {
    return $InputObjectTypesCopyWith<$Res>(_value.inputObjectTypes, (value) {
      return _then(_value.copyWith(inputObjectTypes: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OutputObjectTypesCopyWith<$Res> get outputObjectTypes {
    return $OutputObjectTypesCopyWith<$Res>(_value.outputObjectTypes, (value) {
      return _then(_value.copyWith(outputObjectTypes: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EnumTypesCopyWith<$Res> get enumTypes {
    return $EnumTypesCopyWith<$Res>(_value.enumTypes, (value) {
      return _then(_value.copyWith(enumTypes: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FieldRefTypesCopyWith<$Res> get fieldRefTypes {
    return $FieldRefTypesCopyWith<$Res>(_value.fieldRefTypes, (value) {
      return _then(_value.copyWith(fieldRefTypes: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SchemaImplCopyWith<$Res> implements $SchemaCopyWith<$Res> {
  factory _$$SchemaImplCopyWith(
          _$SchemaImpl value, $Res Function(_$SchemaImpl) then) =
      __$$SchemaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? rootQueryType,
      String? rootMutationType,
      InputObjectTypes inputObjectTypes,
      OutputObjectTypes outputObjectTypes,
      EnumTypes enumTypes,
      FieldRefTypes fieldRefTypes});

  @override
  $InputObjectTypesCopyWith<$Res> get inputObjectTypes;
  @override
  $OutputObjectTypesCopyWith<$Res> get outputObjectTypes;
  @override
  $EnumTypesCopyWith<$Res> get enumTypes;
  @override
  $FieldRefTypesCopyWith<$Res> get fieldRefTypes;
}

/// @nodoc
class __$$SchemaImplCopyWithImpl<$Res>
    extends _$SchemaCopyWithImpl<$Res, _$SchemaImpl>
    implements _$$SchemaImplCopyWith<$Res> {
  __$$SchemaImplCopyWithImpl(
      _$SchemaImpl _value, $Res Function(_$SchemaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rootQueryType = freezed,
    Object? rootMutationType = freezed,
    Object? inputObjectTypes = null,
    Object? outputObjectTypes = null,
    Object? enumTypes = null,
    Object? fieldRefTypes = null,
  }) {
    return _then(_$SchemaImpl(
      rootQueryType: freezed == rootQueryType
          ? _value.rootQueryType
          : rootQueryType // ignore: cast_nullable_to_non_nullable
              as String?,
      rootMutationType: freezed == rootMutationType
          ? _value.rootMutationType
          : rootMutationType // ignore: cast_nullable_to_non_nullable
              as String?,
      inputObjectTypes: null == inputObjectTypes
          ? _value.inputObjectTypes
          : inputObjectTypes // ignore: cast_nullable_to_non_nullable
              as InputObjectTypes,
      outputObjectTypes: null == outputObjectTypes
          ? _value.outputObjectTypes
          : outputObjectTypes // ignore: cast_nullable_to_non_nullable
              as OutputObjectTypes,
      enumTypes: null == enumTypes
          ? _value.enumTypes
          : enumTypes // ignore: cast_nullable_to_non_nullable
              as EnumTypes,
      fieldRefTypes: null == fieldRefTypes
          ? _value.fieldRefTypes
          : fieldRefTypes // ignore: cast_nullable_to_non_nullable
              as FieldRefTypes,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SchemaImpl implements _Schema {
  const _$SchemaImpl(
      {this.rootQueryType,
      this.rootMutationType,
      required this.inputObjectTypes,
      required this.outputObjectTypes,
      required this.enumTypes,
      required this.fieldRefTypes});

  factory _$SchemaImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchemaImplFromJson(json);

  @override
  final String? rootQueryType;
  @override
  final String? rootMutationType;
  @override
  final InputObjectTypes inputObjectTypes;
  @override
  final OutputObjectTypes outputObjectTypes;
  @override
  final EnumTypes enumTypes;
  @override
  final FieldRefTypes fieldRefTypes;

  @override
  String toString() {
    return 'Schema(rootQueryType: $rootQueryType, rootMutationType: $rootMutationType, inputObjectTypes: $inputObjectTypes, outputObjectTypes: $outputObjectTypes, enumTypes: $enumTypes, fieldRefTypes: $fieldRefTypes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchemaImpl &&
            (identical(other.rootQueryType, rootQueryType) ||
                other.rootQueryType == rootQueryType) &&
            (identical(other.rootMutationType, rootMutationType) ||
                other.rootMutationType == rootMutationType) &&
            (identical(other.inputObjectTypes, inputObjectTypes) ||
                other.inputObjectTypes == inputObjectTypes) &&
            (identical(other.outputObjectTypes, outputObjectTypes) ||
                other.outputObjectTypes == outputObjectTypes) &&
            (identical(other.enumTypes, enumTypes) ||
                other.enumTypes == enumTypes) &&
            (identical(other.fieldRefTypes, fieldRefTypes) ||
                other.fieldRefTypes == fieldRefTypes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, rootQueryType, rootMutationType,
      inputObjectTypes, outputObjectTypes, enumTypes, fieldRefTypes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SchemaImplCopyWith<_$SchemaImpl> get copyWith =>
      __$$SchemaImplCopyWithImpl<_$SchemaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchemaImplToJson(
      this,
    );
  }
}

abstract class _Schema implements Schema {
  const factory _Schema(
      {final String? rootQueryType,
      final String? rootMutationType,
      required final InputObjectTypes inputObjectTypes,
      required final OutputObjectTypes outputObjectTypes,
      required final EnumTypes enumTypes,
      required final FieldRefTypes fieldRefTypes}) = _$SchemaImpl;

  factory _Schema.fromJson(Map<String, dynamic> json) = _$SchemaImpl.fromJson;

  @override
  String? get rootQueryType;
  @override
  String? get rootMutationType;
  @override
  InputObjectTypes get inputObjectTypes;
  @override
  OutputObjectTypes get outputObjectTypes;
  @override
  EnumTypes get enumTypes;
  @override
  FieldRefTypes get fieldRefTypes;
  @override
  @JsonKey(ignore: true)
  _$$SchemaImplCopyWith<_$SchemaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InputObjectTypes _$InputObjectTypesFromJson(Map<String, dynamic> json) {
  return _InputObjectTypes.fromJson(json);
}

/// @nodoc
mixin _$InputObjectTypes {
  List<InputType>? get model => throw _privateConstructorUsedError;
  List<InputType> get prisma => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InputObjectTypesCopyWith<InputObjectTypes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputObjectTypesCopyWith<$Res> {
  factory $InputObjectTypesCopyWith(
          InputObjectTypes value, $Res Function(InputObjectTypes) then) =
      _$InputObjectTypesCopyWithImpl<$Res, InputObjectTypes>;
  @useResult
  $Res call({List<InputType>? model, List<InputType> prisma});
}

/// @nodoc
class _$InputObjectTypesCopyWithImpl<$Res, $Val extends InputObjectTypes>
    implements $InputObjectTypesCopyWith<$Res> {
  _$InputObjectTypesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = freezed,
    Object? prisma = null,
  }) {
    return _then(_value.copyWith(
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as List<InputType>?,
      prisma: null == prisma
          ? _value.prisma
          : prisma // ignore: cast_nullable_to_non_nullable
              as List<InputType>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InputObjectTypesImplCopyWith<$Res>
    implements $InputObjectTypesCopyWith<$Res> {
  factory _$$InputObjectTypesImplCopyWith(_$InputObjectTypesImpl value,
          $Res Function(_$InputObjectTypesImpl) then) =
      __$$InputObjectTypesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<InputType>? model, List<InputType> prisma});
}

/// @nodoc
class __$$InputObjectTypesImplCopyWithImpl<$Res>
    extends _$InputObjectTypesCopyWithImpl<$Res, _$InputObjectTypesImpl>
    implements _$$InputObjectTypesImplCopyWith<$Res> {
  __$$InputObjectTypesImplCopyWithImpl(_$InputObjectTypesImpl _value,
      $Res Function(_$InputObjectTypesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = freezed,
    Object? prisma = null,
  }) {
    return _then(_$InputObjectTypesImpl(
      model: freezed == model
          ? _value._model
          : model // ignore: cast_nullable_to_non_nullable
              as List<InputType>?,
      prisma: null == prisma
          ? _value._prisma
          : prisma // ignore: cast_nullable_to_non_nullable
              as List<InputType>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InputObjectTypesImpl implements _InputObjectTypes {
  const _$InputObjectTypesImpl(
      {final List<InputType>? model, required final List<InputType> prisma})
      : _model = model,
        _prisma = prisma;

  factory _$InputObjectTypesImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputObjectTypesImplFromJson(json);

  final List<InputType>? _model;
  @override
  List<InputType>? get model {
    final value = _model;
    if (value == null) return null;
    if (_model is EqualUnmodifiableListView) return _model;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<InputType> _prisma;
  @override
  List<InputType> get prisma {
    if (_prisma is EqualUnmodifiableListView) return _prisma;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prisma);
  }

  @override
  String toString() {
    return 'InputObjectTypes(model: $model, prisma: $prisma)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputObjectTypesImpl &&
            const DeepCollectionEquality().equals(other._model, _model) &&
            const DeepCollectionEquality().equals(other._prisma, _prisma));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_model),
      const DeepCollectionEquality().hash(_prisma));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InputObjectTypesImplCopyWith<_$InputObjectTypesImpl> get copyWith =>
      __$$InputObjectTypesImplCopyWithImpl<_$InputObjectTypesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InputObjectTypesImplToJson(
      this,
    );
  }
}

abstract class _InputObjectTypes implements InputObjectTypes {
  const factory _InputObjectTypes(
      {final List<InputType>? model,
      required final List<InputType> prisma}) = _$InputObjectTypesImpl;

  factory _InputObjectTypes.fromJson(Map<String, dynamic> json) =
      _$InputObjectTypesImpl.fromJson;

  @override
  List<InputType>? get model;
  @override
  List<InputType> get prisma;
  @override
  @JsonKey(ignore: true)
  _$$InputObjectTypesImplCopyWith<_$InputObjectTypesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InputType _$InputTypeFromJson(Map<String, dynamic> json) {
  return _InputType.fromJson(json);
}

/// @nodoc
mixin _$InputType {
  String get name => throw _privateConstructorUsedError;
  Constraints get constraints => throw _privateConstructorUsedError;
  Meta? get meta => throw _privateConstructorUsedError;
  List<SchemaArg> get fields => throw _privateConstructorUsedError;
  Map<String, SchemaArg>? get fieldsMap => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InputTypeCopyWith<InputType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputTypeCopyWith<$Res> {
  factory $InputTypeCopyWith(InputType value, $Res Function(InputType) then) =
      _$InputTypeCopyWithImpl<$Res, InputType>;
  @useResult
  $Res call(
      {String name,
      Constraints constraints,
      Meta? meta,
      List<SchemaArg> fields,
      Map<String, SchemaArg>? fieldsMap});

  $ConstraintsCopyWith<$Res> get constraints;
  $MetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$InputTypeCopyWithImpl<$Res, $Val extends InputType>
    implements $InputTypeCopyWith<$Res> {
  _$InputTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? constraints = null,
    Object? meta = freezed,
    Object? fields = null,
    Object? fieldsMap = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      constraints: null == constraints
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as Constraints,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta?,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<SchemaArg>,
      fieldsMap: freezed == fieldsMap
          ? _value.fieldsMap
          : fieldsMap // ignore: cast_nullable_to_non_nullable
              as Map<String, SchemaArg>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ConstraintsCopyWith<$Res> get constraints {
    return $ConstraintsCopyWith<$Res>(_value.constraints, (value) {
      return _then(_value.copyWith(constraints: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MetaCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $MetaCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InputTypeImplCopyWith<$Res>
    implements $InputTypeCopyWith<$Res> {
  factory _$$InputTypeImplCopyWith(
          _$InputTypeImpl value, $Res Function(_$InputTypeImpl) then) =
      __$$InputTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      Constraints constraints,
      Meta? meta,
      List<SchemaArg> fields,
      Map<String, SchemaArg>? fieldsMap});

  @override
  $ConstraintsCopyWith<$Res> get constraints;
  @override
  $MetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$InputTypeImplCopyWithImpl<$Res>
    extends _$InputTypeCopyWithImpl<$Res, _$InputTypeImpl>
    implements _$$InputTypeImplCopyWith<$Res> {
  __$$InputTypeImplCopyWithImpl(
      _$InputTypeImpl _value, $Res Function(_$InputTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? constraints = null,
    Object? meta = freezed,
    Object? fields = null,
    Object? fieldsMap = freezed,
  }) {
    return _then(_$InputTypeImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      constraints: null == constraints
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as Constraints,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta?,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<SchemaArg>,
      fieldsMap: freezed == fieldsMap
          ? _value._fieldsMap
          : fieldsMap // ignore: cast_nullable_to_non_nullable
              as Map<String, SchemaArg>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InputTypeImpl implements _InputType {
  const _$InputTypeImpl(
      {required this.name,
      required this.constraints,
      this.meta,
      required final List<SchemaArg> fields,
      final Map<String, SchemaArg>? fieldsMap})
      : _fields = fields,
        _fieldsMap = fieldsMap;

  factory _$InputTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputTypeImplFromJson(json);

  @override
  final String name;
  @override
  final Constraints constraints;
  @override
  final Meta? meta;
  final List<SchemaArg> _fields;
  @override
  List<SchemaArg> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  final Map<String, SchemaArg>? _fieldsMap;
  @override
  Map<String, SchemaArg>? get fieldsMap {
    final value = _fieldsMap;
    if (value == null) return null;
    if (_fieldsMap is EqualUnmodifiableMapView) return _fieldsMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'InputType(name: $name, constraints: $constraints, meta: $meta, fields: $fields, fieldsMap: $fieldsMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputTypeImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.constraints, constraints) ||
                other.constraints == constraints) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            const DeepCollectionEquality()
                .equals(other._fieldsMap, _fieldsMap));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      constraints,
      meta,
      const DeepCollectionEquality().hash(_fields),
      const DeepCollectionEquality().hash(_fieldsMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InputTypeImplCopyWith<_$InputTypeImpl> get copyWith =>
      __$$InputTypeImplCopyWithImpl<_$InputTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InputTypeImplToJson(
      this,
    );
  }
}

abstract class _InputType implements InputType {
  const factory _InputType(
      {required final String name,
      required final Constraints constraints,
      final Meta? meta,
      required final List<SchemaArg> fields,
      final Map<String, SchemaArg>? fieldsMap}) = _$InputTypeImpl;

  factory _InputType.fromJson(Map<String, dynamic> json) =
      _$InputTypeImpl.fromJson;

  @override
  String get name;
  @override
  Constraints get constraints;
  @override
  Meta? get meta;
  @override
  List<SchemaArg> get fields;
  @override
  Map<String, SchemaArg>? get fieldsMap;
  @override
  @JsonKey(ignore: true)
  _$$InputTypeImplCopyWith<_$InputTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Constraints _$ConstraintsFromJson(Map<String, dynamic> json) {
  return _Constraints.fromJson(json);
}

/// @nodoc
mixin _$Constraints {
  int? get maxNumFields => throw _privateConstructorUsedError;
  int? get minNumFields => throw _privateConstructorUsedError;
  List<String>? get fields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConstraintsCopyWith<Constraints> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConstraintsCopyWith<$Res> {
  factory $ConstraintsCopyWith(
          Constraints value, $Res Function(Constraints) then) =
      _$ConstraintsCopyWithImpl<$Res, Constraints>;
  @useResult
  $Res call({int? maxNumFields, int? minNumFields, List<String>? fields});
}

/// @nodoc
class _$ConstraintsCopyWithImpl<$Res, $Val extends Constraints>
    implements $ConstraintsCopyWith<$Res> {
  _$ConstraintsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxNumFields = freezed,
    Object? minNumFields = freezed,
    Object? fields = freezed,
  }) {
    return _then(_value.copyWith(
      maxNumFields: freezed == maxNumFields
          ? _value.maxNumFields
          : maxNumFields // ignore: cast_nullable_to_non_nullable
              as int?,
      minNumFields: freezed == minNumFields
          ? _value.minNumFields
          : minNumFields // ignore: cast_nullable_to_non_nullable
              as int?,
      fields: freezed == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConstraintsImplCopyWith<$Res>
    implements $ConstraintsCopyWith<$Res> {
  factory _$$ConstraintsImplCopyWith(
          _$ConstraintsImpl value, $Res Function(_$ConstraintsImpl) then) =
      __$$ConstraintsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? maxNumFields, int? minNumFields, List<String>? fields});
}

/// @nodoc
class __$$ConstraintsImplCopyWithImpl<$Res>
    extends _$ConstraintsCopyWithImpl<$Res, _$ConstraintsImpl>
    implements _$$ConstraintsImplCopyWith<$Res> {
  __$$ConstraintsImplCopyWithImpl(
      _$ConstraintsImpl _value, $Res Function(_$ConstraintsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxNumFields = freezed,
    Object? minNumFields = freezed,
    Object? fields = freezed,
  }) {
    return _then(_$ConstraintsImpl(
      maxNumFields: freezed == maxNumFields
          ? _value.maxNumFields
          : maxNumFields // ignore: cast_nullable_to_non_nullable
              as int?,
      minNumFields: freezed == minNumFields
          ? _value.minNumFields
          : minNumFields // ignore: cast_nullable_to_non_nullable
              as int?,
      fields: freezed == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConstraintsImpl implements _Constraints {
  const _$ConstraintsImpl(
      {this.maxNumFields, this.minNumFields, final List<String>? fields})
      : _fields = fields;

  factory _$ConstraintsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConstraintsImplFromJson(json);

  @override
  final int? maxNumFields;
  @override
  final int? minNumFields;
  final List<String>? _fields;
  @override
  List<String>? get fields {
    final value = _fields;
    if (value == null) return null;
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Constraints(maxNumFields: $maxNumFields, minNumFields: $minNumFields, fields: $fields)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConstraintsImpl &&
            (identical(other.maxNumFields, maxNumFields) ||
                other.maxNumFields == maxNumFields) &&
            (identical(other.minNumFields, minNumFields) ||
                other.minNumFields == minNumFields) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, maxNumFields, minNumFields,
      const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConstraintsImplCopyWith<_$ConstraintsImpl> get copyWith =>
      __$$ConstraintsImplCopyWithImpl<_$ConstraintsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConstraintsImplToJson(
      this,
    );
  }
}

abstract class _Constraints implements Constraints {
  const factory _Constraints(
      {final int? maxNumFields,
      final int? minNumFields,
      final List<String>? fields}) = _$ConstraintsImpl;

  factory _Constraints.fromJson(Map<String, dynamic> json) =
      _$ConstraintsImpl.fromJson;

  @override
  int? get maxNumFields;
  @override
  int? get minNumFields;
  @override
  List<String>? get fields;
  @override
  @JsonKey(ignore: true)
  _$$ConstraintsImplCopyWith<_$ConstraintsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return _Meta.fromJson(json);
}

/// @nodoc
mixin _$Meta {
  String? get source => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MetaCopyWith<Meta> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaCopyWith<$Res> {
  factory $MetaCopyWith(Meta value, $Res Function(Meta) then) =
      _$MetaCopyWithImpl<$Res, Meta>;
  @useResult
  $Res call({String? source});
}

/// @nodoc
class _$MetaCopyWithImpl<$Res, $Val extends Meta>
    implements $MetaCopyWith<$Res> {
  _$MetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
  }) {
    return _then(_value.copyWith(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MetaImplCopyWith<$Res> implements $MetaCopyWith<$Res> {
  factory _$$MetaImplCopyWith(
          _$MetaImpl value, $Res Function(_$MetaImpl) then) =
      __$$MetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? source});
}

/// @nodoc
class __$$MetaImplCopyWithImpl<$Res>
    extends _$MetaCopyWithImpl<$Res, _$MetaImpl>
    implements _$$MetaImplCopyWith<$Res> {
  __$$MetaImplCopyWithImpl(_$MetaImpl _value, $Res Function(_$MetaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = freezed,
  }) {
    return _then(_$MetaImpl(
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MetaImpl implements _Meta {
  const _$MetaImpl({this.source});

  factory _$MetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetaImplFromJson(json);

  @override
  final String? source;

  @override
  String toString() {
    return 'Meta(source: $source)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetaImpl &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, source);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MetaImplCopyWith<_$MetaImpl> get copyWith =>
      __$$MetaImplCopyWithImpl<_$MetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetaImplToJson(
      this,
    );
  }
}

abstract class _Meta implements Meta {
  const factory _Meta({final String? source}) = _$MetaImpl;

  factory _Meta.fromJson(Map<String, dynamic> json) = _$MetaImpl.fromJson;

  @override
  String? get source;
  @override
  @JsonKey(ignore: true)
  _$$MetaImplCopyWith<_$MetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SchemaArg _$SchemaArgFromJson(Map<String, dynamic> json) {
  return _SchemaArg.fromJson(json);
}

/// @nodoc
mixin _$SchemaArg {
  String get name => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  bool get isNullable => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  List<SchemaArgInputType> get inputTypes => throw _privateConstructorUsedError;
  Deprecation? get deprecation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SchemaArgCopyWith<SchemaArg> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchemaArgCopyWith<$Res> {
  factory $SchemaArgCopyWith(SchemaArg value, $Res Function(SchemaArg) then) =
      _$SchemaArgCopyWithImpl<$Res, SchemaArg>;
  @useResult
  $Res call(
      {String name,
      String? comment,
      bool isNullable,
      bool isRequired,
      List<SchemaArgInputType> inputTypes,
      Deprecation? deprecation});

  $DeprecationCopyWith<$Res>? get deprecation;
}

/// @nodoc
class _$SchemaArgCopyWithImpl<$Res, $Val extends SchemaArg>
    implements $SchemaArgCopyWith<$Res> {
  _$SchemaArgCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? comment = freezed,
    Object? isNullable = null,
    Object? isRequired = null,
    Object? inputTypes = null,
    Object? deprecation = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      isNullable: null == isNullable
          ? _value.isNullable
          : isNullable // ignore: cast_nullable_to_non_nullable
              as bool,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      inputTypes: null == inputTypes
          ? _value.inputTypes
          : inputTypes // ignore: cast_nullable_to_non_nullable
              as List<SchemaArgInputType>,
      deprecation: freezed == deprecation
          ? _value.deprecation
          : deprecation // ignore: cast_nullable_to_non_nullable
              as Deprecation?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeprecationCopyWith<$Res>? get deprecation {
    if (_value.deprecation == null) {
      return null;
    }

    return $DeprecationCopyWith<$Res>(_value.deprecation!, (value) {
      return _then(_value.copyWith(deprecation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SchemaArgImplCopyWith<$Res>
    implements $SchemaArgCopyWith<$Res> {
  factory _$$SchemaArgImplCopyWith(
          _$SchemaArgImpl value, $Res Function(_$SchemaArgImpl) then) =
      __$$SchemaArgImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? comment,
      bool isNullable,
      bool isRequired,
      List<SchemaArgInputType> inputTypes,
      Deprecation? deprecation});

  @override
  $DeprecationCopyWith<$Res>? get deprecation;
}

/// @nodoc
class __$$SchemaArgImplCopyWithImpl<$Res>
    extends _$SchemaArgCopyWithImpl<$Res, _$SchemaArgImpl>
    implements _$$SchemaArgImplCopyWith<$Res> {
  __$$SchemaArgImplCopyWithImpl(
      _$SchemaArgImpl _value, $Res Function(_$SchemaArgImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? comment = freezed,
    Object? isNullable = null,
    Object? isRequired = null,
    Object? inputTypes = null,
    Object? deprecation = freezed,
  }) {
    return _then(_$SchemaArgImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      isNullable: null == isNullable
          ? _value.isNullable
          : isNullable // ignore: cast_nullable_to_non_nullable
              as bool,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      inputTypes: null == inputTypes
          ? _value._inputTypes
          : inputTypes // ignore: cast_nullable_to_non_nullable
              as List<SchemaArgInputType>,
      deprecation: freezed == deprecation
          ? _value.deprecation
          : deprecation // ignore: cast_nullable_to_non_nullable
              as Deprecation?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SchemaArgImpl implements _SchemaArg {
  const _$SchemaArgImpl(
      {required this.name,
      this.comment,
      required this.isNullable,
      required this.isRequired,
      required final List<SchemaArgInputType> inputTypes,
      this.deprecation})
      : _inputTypes = inputTypes;

  factory _$SchemaArgImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchemaArgImplFromJson(json);

  @override
  final String name;
  @override
  final String? comment;
  @override
  final bool isNullable;
  @override
  final bool isRequired;
  final List<SchemaArgInputType> _inputTypes;
  @override
  List<SchemaArgInputType> get inputTypes {
    if (_inputTypes is EqualUnmodifiableListView) return _inputTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inputTypes);
  }

  @override
  final Deprecation? deprecation;

  @override
  String toString() {
    return 'SchemaArg(name: $name, comment: $comment, isNullable: $isNullable, isRequired: $isRequired, inputTypes: $inputTypes, deprecation: $deprecation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchemaArgImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.isNullable, isNullable) ||
                other.isNullable == isNullable) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            const DeepCollectionEquality()
                .equals(other._inputTypes, _inputTypes) &&
            (identical(other.deprecation, deprecation) ||
                other.deprecation == deprecation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      comment,
      isNullable,
      isRequired,
      const DeepCollectionEquality().hash(_inputTypes),
      deprecation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SchemaArgImplCopyWith<_$SchemaArgImpl> get copyWith =>
      __$$SchemaArgImplCopyWithImpl<_$SchemaArgImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchemaArgImplToJson(
      this,
    );
  }
}

abstract class _SchemaArg implements SchemaArg {
  const factory _SchemaArg(
      {required final String name,
      final String? comment,
      required final bool isNullable,
      required final bool isRequired,
      required final List<SchemaArgInputType> inputTypes,
      final Deprecation? deprecation}) = _$SchemaArgImpl;

  factory _SchemaArg.fromJson(Map<String, dynamic> json) =
      _$SchemaArgImpl.fromJson;

  @override
  String get name;
  @override
  String? get comment;
  @override
  bool get isNullable;
  @override
  bool get isRequired;
  @override
  List<SchemaArgInputType> get inputTypes;
  @override
  Deprecation? get deprecation;
  @override
  @JsonKey(ignore: true)
  _$$SchemaArgImplCopyWith<_$SchemaArgImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Deprecation _$DeprecationFromJson(Map<String, dynamic> json) {
  return _Deprecation.fromJson(json);
}

/// @nodoc
mixin _$Deprecation {
  String get sinceVersion => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String? get plannedRemovalVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeprecationCopyWith<Deprecation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeprecationCopyWith<$Res> {
  factory $DeprecationCopyWith(
          Deprecation value, $Res Function(Deprecation) then) =
      _$DeprecationCopyWithImpl<$Res, Deprecation>;
  @useResult
  $Res call(
      {String sinceVersion, String reason, String? plannedRemovalVersion});
}

/// @nodoc
class _$DeprecationCopyWithImpl<$Res, $Val extends Deprecation>
    implements $DeprecationCopyWith<$Res> {
  _$DeprecationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sinceVersion = null,
    Object? reason = null,
    Object? plannedRemovalVersion = freezed,
  }) {
    return _then(_value.copyWith(
      sinceVersion: null == sinceVersion
          ? _value.sinceVersion
          : sinceVersion // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      plannedRemovalVersion: freezed == plannedRemovalVersion
          ? _value.plannedRemovalVersion
          : plannedRemovalVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeprecationImplCopyWith<$Res>
    implements $DeprecationCopyWith<$Res> {
  factory _$$DeprecationImplCopyWith(
          _$DeprecationImpl value, $Res Function(_$DeprecationImpl) then) =
      __$$DeprecationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sinceVersion, String reason, String? plannedRemovalVersion});
}

/// @nodoc
class __$$DeprecationImplCopyWithImpl<$Res>
    extends _$DeprecationCopyWithImpl<$Res, _$DeprecationImpl>
    implements _$$DeprecationImplCopyWith<$Res> {
  __$$DeprecationImplCopyWithImpl(
      _$DeprecationImpl _value, $Res Function(_$DeprecationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sinceVersion = null,
    Object? reason = null,
    Object? plannedRemovalVersion = freezed,
  }) {
    return _then(_$DeprecationImpl(
      sinceVersion: null == sinceVersion
          ? _value.sinceVersion
          : sinceVersion // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      plannedRemovalVersion: freezed == plannedRemovalVersion
          ? _value.plannedRemovalVersion
          : plannedRemovalVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeprecationImpl implements _Deprecation {
  const _$DeprecationImpl(
      {required this.sinceVersion,
      required this.reason,
      this.plannedRemovalVersion});

  factory _$DeprecationImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeprecationImplFromJson(json);

  @override
  final String sinceVersion;
  @override
  final String reason;
  @override
  final String? plannedRemovalVersion;

  @override
  String toString() {
    return 'Deprecation(sinceVersion: $sinceVersion, reason: $reason, plannedRemovalVersion: $plannedRemovalVersion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeprecationImpl &&
            (identical(other.sinceVersion, sinceVersion) ||
                other.sinceVersion == sinceVersion) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.plannedRemovalVersion, plannedRemovalVersion) ||
                other.plannedRemovalVersion == plannedRemovalVersion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, sinceVersion, reason, plannedRemovalVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeprecationImplCopyWith<_$DeprecationImpl> get copyWith =>
      __$$DeprecationImplCopyWithImpl<_$DeprecationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeprecationImplToJson(
      this,
    );
  }
}

abstract class _Deprecation implements Deprecation {
  const factory _Deprecation(
      {required final String sinceVersion,
      required final String reason,
      final String? plannedRemovalVersion}) = _$DeprecationImpl;

  factory _Deprecation.fromJson(Map<String, dynamic> json) =
      _$DeprecationImpl.fromJson;

  @override
  String get sinceVersion;
  @override
  String get reason;
  @override
  String? get plannedRemovalVersion;
  @override
  @JsonKey(ignore: true)
  _$$DeprecationImplCopyWith<_$DeprecationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SchemaArgInputType _$SchemaArgInputTypeFromJson(Map<String, dynamic> json) {
  return _SchemaArgInputType.fromJson(json);
}

/// @nodoc
mixin _$SchemaArgInputType {
  bool get isList => throw _privateConstructorUsedError;
  @_ArgTypeConverter()
  ArgType get type => throw _privateConstructorUsedError;
  FieldLocation get location => throw _privateConstructorUsedError;
  FieldNamespace? get namespace => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SchemaArgInputTypeCopyWith<SchemaArgInputType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchemaArgInputTypeCopyWith<$Res> {
  factory $SchemaArgInputTypeCopyWith(
          SchemaArgInputType value, $Res Function(SchemaArgInputType) then) =
      _$SchemaArgInputTypeCopyWithImpl<$Res, SchemaArgInputType>;
  @useResult
  $Res call(
      {bool isList,
      @_ArgTypeConverter() ArgType type,
      FieldLocation location,
      FieldNamespace? namespace});

  $ArgTypeCopyWith<$Res> get type;
}

/// @nodoc
class _$SchemaArgInputTypeCopyWithImpl<$Res, $Val extends SchemaArgInputType>
    implements $SchemaArgInputTypeCopyWith<$Res> {
  _$SchemaArgInputTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isList = null,
    Object? type = null,
    Object? location = null,
    Object? namespace = freezed,
  }) {
    return _then(_value.copyWith(
      isList: null == isList
          ? _value.isList
          : isList // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ArgType,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as FieldLocation,
      namespace: freezed == namespace
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as FieldNamespace?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ArgTypeCopyWith<$Res> get type {
    return $ArgTypeCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SchemaArgInputTypeImplCopyWith<$Res>
    implements $SchemaArgInputTypeCopyWith<$Res> {
  factory _$$SchemaArgInputTypeImplCopyWith(_$SchemaArgInputTypeImpl value,
          $Res Function(_$SchemaArgInputTypeImpl) then) =
      __$$SchemaArgInputTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isList,
      @_ArgTypeConverter() ArgType type,
      FieldLocation location,
      FieldNamespace? namespace});

  @override
  $ArgTypeCopyWith<$Res> get type;
}

/// @nodoc
class __$$SchemaArgInputTypeImplCopyWithImpl<$Res>
    extends _$SchemaArgInputTypeCopyWithImpl<$Res, _$SchemaArgInputTypeImpl>
    implements _$$SchemaArgInputTypeImplCopyWith<$Res> {
  __$$SchemaArgInputTypeImplCopyWithImpl(_$SchemaArgInputTypeImpl _value,
      $Res Function(_$SchemaArgInputTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isList = null,
    Object? type = null,
    Object? location = null,
    Object? namespace = freezed,
  }) {
    return _then(_$SchemaArgInputTypeImpl(
      isList: null == isList
          ? _value.isList
          : isList // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ArgType,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as FieldLocation,
      namespace: freezed == namespace
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as FieldNamespace?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SchemaArgInputTypeImpl implements _SchemaArgInputType {
  const _$SchemaArgInputTypeImpl(
      {required this.isList,
      @_ArgTypeConverter() required this.type,
      required this.location,
      this.namespace});

  factory _$SchemaArgInputTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchemaArgInputTypeImplFromJson(json);

  @override
  final bool isList;
  @override
  @_ArgTypeConverter()
  final ArgType type;
  @override
  final FieldLocation location;
  @override
  final FieldNamespace? namespace;

  @override
  String toString() {
    return 'SchemaArgInputType(isList: $isList, type: $type, location: $location, namespace: $namespace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchemaArgInputTypeImpl &&
            (identical(other.isList, isList) || other.isList == isList) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.namespace, namespace) ||
                other.namespace == namespace));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isList, type, location, namespace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SchemaArgInputTypeImplCopyWith<_$SchemaArgInputTypeImpl> get copyWith =>
      __$$SchemaArgInputTypeImplCopyWithImpl<_$SchemaArgInputTypeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchemaArgInputTypeImplToJson(
      this,
    );
  }
}

abstract class _SchemaArgInputType implements SchemaArgInputType {
  const factory _SchemaArgInputType(
      {required final bool isList,
      @_ArgTypeConverter() required final ArgType type,
      required final FieldLocation location,
      final FieldNamespace? namespace}) = _$SchemaArgInputTypeImpl;

  factory _SchemaArgInputType.fromJson(Map<String, dynamic> json) =
      _$SchemaArgInputTypeImpl.fromJson;

  @override
  bool get isList;
  @override
  @_ArgTypeConverter()
  ArgType get type;
  @override
  FieldLocation get location;
  @override
  FieldNamespace? get namespace;
  @override
  @JsonKey(ignore: true)
  _$$SchemaArgInputTypeImplCopyWith<_$SchemaArgInputTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArgType _$ArgTypeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'string':
      return StringArgType.fromJson(json);
    case 'object':
      return ObjectArgType.fromJson(json);
    case 'enum_':
      return EnumArgType.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ArgType',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ArgType {
  Object get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) string,
    required TResult Function(InputType value) object,
    required TResult Function(SchemaEnum value) enum_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? string,
    TResult? Function(InputType value)? object,
    TResult? Function(SchemaEnum value)? enum_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? string,
    TResult Function(InputType value)? object,
    TResult Function(SchemaEnum value)? enum_,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringArgType value) string,
    required TResult Function(ObjectArgType value) object,
    required TResult Function(EnumArgType value) enum_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringArgType value)? string,
    TResult? Function(ObjectArgType value)? object,
    TResult? Function(EnumArgType value)? enum_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringArgType value)? string,
    TResult Function(ObjectArgType value)? object,
    TResult Function(EnumArgType value)? enum_,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArgTypeCopyWith<$Res> {
  factory $ArgTypeCopyWith(ArgType value, $Res Function(ArgType) then) =
      _$ArgTypeCopyWithImpl<$Res, ArgType>;
}

/// @nodoc
class _$ArgTypeCopyWithImpl<$Res, $Val extends ArgType>
    implements $ArgTypeCopyWith<$Res> {
  _$ArgTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StringArgTypeImplCopyWith<$Res> {
  factory _$$StringArgTypeImplCopyWith(
          _$StringArgTypeImpl value, $Res Function(_$StringArgTypeImpl) then) =
      __$$StringArgTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$StringArgTypeImplCopyWithImpl<$Res>
    extends _$ArgTypeCopyWithImpl<$Res, _$StringArgTypeImpl>
    implements _$$StringArgTypeImplCopyWith<$Res> {
  __$$StringArgTypeImplCopyWithImpl(
      _$StringArgTypeImpl _value, $Res Function(_$StringArgTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$StringArgTypeImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StringArgTypeImpl implements StringArgType {
  const _$StringArgTypeImpl(this.value, {final String? $type})
      : $type = $type ?? 'string';

  factory _$StringArgTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$StringArgTypeImplFromJson(json);

  @override
  final String value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ArgType.string(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StringArgTypeImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StringArgTypeImplCopyWith<_$StringArgTypeImpl> get copyWith =>
      __$$StringArgTypeImplCopyWithImpl<_$StringArgTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) string,
    required TResult Function(InputType value) object,
    required TResult Function(SchemaEnum value) enum_,
  }) {
    return string(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? string,
    TResult? Function(InputType value)? object,
    TResult? Function(SchemaEnum value)? enum_,
  }) {
    return string?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? string,
    TResult Function(InputType value)? object,
    TResult Function(SchemaEnum value)? enum_,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringArgType value) string,
    required TResult Function(ObjectArgType value) object,
    required TResult Function(EnumArgType value) enum_,
  }) {
    return string(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringArgType value)? string,
    TResult? Function(ObjectArgType value)? object,
    TResult? Function(EnumArgType value)? enum_,
  }) {
    return string?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringArgType value)? string,
    TResult Function(ObjectArgType value)? object,
    TResult Function(EnumArgType value)? enum_,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StringArgTypeImplToJson(
      this,
    );
  }
}

abstract class StringArgType implements ArgType {
  const factory StringArgType(final String value) = _$StringArgTypeImpl;

  factory StringArgType.fromJson(Map<String, dynamic> json) =
      _$StringArgTypeImpl.fromJson;

  @override
  String get value;
  @JsonKey(ignore: true)
  _$$StringArgTypeImplCopyWith<_$StringArgTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ObjectArgTypeImplCopyWith<$Res> {
  factory _$$ObjectArgTypeImplCopyWith(
          _$ObjectArgTypeImpl value, $Res Function(_$ObjectArgTypeImpl) then) =
      __$$ObjectArgTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InputType value});

  $InputTypeCopyWith<$Res> get value;
}

/// @nodoc
class __$$ObjectArgTypeImplCopyWithImpl<$Res>
    extends _$ArgTypeCopyWithImpl<$Res, _$ObjectArgTypeImpl>
    implements _$$ObjectArgTypeImplCopyWith<$Res> {
  __$$ObjectArgTypeImplCopyWithImpl(
      _$ObjectArgTypeImpl _value, $Res Function(_$ObjectArgTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$ObjectArgTypeImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as InputType,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $InputTypeCopyWith<$Res> get value {
    return $InputTypeCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ObjectArgTypeImpl implements ObjectArgType {
  const _$ObjectArgTypeImpl(this.value, {final String? $type})
      : $type = $type ?? 'object';

  factory _$ObjectArgTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ObjectArgTypeImplFromJson(json);

  @override
  final InputType value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ArgType.object(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ObjectArgTypeImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ObjectArgTypeImplCopyWith<_$ObjectArgTypeImpl> get copyWith =>
      __$$ObjectArgTypeImplCopyWithImpl<_$ObjectArgTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) string,
    required TResult Function(InputType value) object,
    required TResult Function(SchemaEnum value) enum_,
  }) {
    return object(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? string,
    TResult? Function(InputType value)? object,
    TResult? Function(SchemaEnum value)? enum_,
  }) {
    return object?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? string,
    TResult Function(InputType value)? object,
    TResult Function(SchemaEnum value)? enum_,
    required TResult orElse(),
  }) {
    if (object != null) {
      return object(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringArgType value) string,
    required TResult Function(ObjectArgType value) object,
    required TResult Function(EnumArgType value) enum_,
  }) {
    return object(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringArgType value)? string,
    TResult? Function(ObjectArgType value)? object,
    TResult? Function(EnumArgType value)? enum_,
  }) {
    return object?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringArgType value)? string,
    TResult Function(ObjectArgType value)? object,
    TResult Function(EnumArgType value)? enum_,
    required TResult orElse(),
  }) {
    if (object != null) {
      return object(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ObjectArgTypeImplToJson(
      this,
    );
  }
}

abstract class ObjectArgType implements ArgType {
  const factory ObjectArgType(final InputType value) = _$ObjectArgTypeImpl;

  factory ObjectArgType.fromJson(Map<String, dynamic> json) =
      _$ObjectArgTypeImpl.fromJson;

  @override
  InputType get value;
  @JsonKey(ignore: true)
  _$$ObjectArgTypeImplCopyWith<_$ObjectArgTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EnumArgTypeImplCopyWith<$Res> {
  factory _$$EnumArgTypeImplCopyWith(
          _$EnumArgTypeImpl value, $Res Function(_$EnumArgTypeImpl) then) =
      __$$EnumArgTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SchemaEnum value});

  $SchemaEnumCopyWith<$Res> get value;
}

/// @nodoc
class __$$EnumArgTypeImplCopyWithImpl<$Res>
    extends _$ArgTypeCopyWithImpl<$Res, _$EnumArgTypeImpl>
    implements _$$EnumArgTypeImplCopyWith<$Res> {
  __$$EnumArgTypeImplCopyWithImpl(
      _$EnumArgTypeImpl _value, $Res Function(_$EnumArgTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$EnumArgTypeImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as SchemaEnum,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SchemaEnumCopyWith<$Res> get value {
    return $SchemaEnumCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$EnumArgTypeImpl implements EnumArgType {
  const _$EnumArgTypeImpl(this.value, {final String? $type})
      : $type = $type ?? 'enum_';

  factory _$EnumArgTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnumArgTypeImplFromJson(json);

  @override
  final SchemaEnum value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ArgType.enum_(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnumArgTypeImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EnumArgTypeImplCopyWith<_$EnumArgTypeImpl> get copyWith =>
      __$$EnumArgTypeImplCopyWithImpl<_$EnumArgTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) string,
    required TResult Function(InputType value) object,
    required TResult Function(SchemaEnum value) enum_,
  }) {
    return enum_(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? string,
    TResult? Function(InputType value)? object,
    TResult? Function(SchemaEnum value)? enum_,
  }) {
    return enum_?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? string,
    TResult Function(InputType value)? object,
    TResult Function(SchemaEnum value)? enum_,
    required TResult orElse(),
  }) {
    if (enum_ != null) {
      return enum_(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringArgType value) string,
    required TResult Function(ObjectArgType value) object,
    required TResult Function(EnumArgType value) enum_,
  }) {
    return enum_(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringArgType value)? string,
    TResult? Function(ObjectArgType value)? object,
    TResult? Function(EnumArgType value)? enum_,
  }) {
    return enum_?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringArgType value)? string,
    TResult Function(ObjectArgType value)? object,
    TResult Function(EnumArgType value)? enum_,
    required TResult orElse(),
  }) {
    if (enum_ != null) {
      return enum_(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EnumArgTypeImplToJson(
      this,
    );
  }
}

abstract class EnumArgType implements ArgType {
  const factory EnumArgType(final SchemaEnum value) = _$EnumArgTypeImpl;

  factory EnumArgType.fromJson(Map<String, dynamic> json) =
      _$EnumArgTypeImpl.fromJson;

  @override
  SchemaEnum get value;
  @JsonKey(ignore: true)
  _$$EnumArgTypeImplCopyWith<_$EnumArgTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SchemaEnum _$SchemaEnumFromJson(Map<String, dynamic> json) {
  return _SchemaEnum.fromJson(json);
}

/// @nodoc
mixin _$SchemaEnum {
  String get name => throw _privateConstructorUsedError;
  List<String> get values => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SchemaEnumCopyWith<SchemaEnum> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchemaEnumCopyWith<$Res> {
  factory $SchemaEnumCopyWith(
          SchemaEnum value, $Res Function(SchemaEnum) then) =
      _$SchemaEnumCopyWithImpl<$Res, SchemaEnum>;
  @useResult
  $Res call({String name, List<String> values});
}

/// @nodoc
class _$SchemaEnumCopyWithImpl<$Res, $Val extends SchemaEnum>
    implements $SchemaEnumCopyWith<$Res> {
  _$SchemaEnumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? values = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SchemaEnumImplCopyWith<$Res>
    implements $SchemaEnumCopyWith<$Res> {
  factory _$$SchemaEnumImplCopyWith(
          _$SchemaEnumImpl value, $Res Function(_$SchemaEnumImpl) then) =
      __$$SchemaEnumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<String> values});
}

/// @nodoc
class __$$SchemaEnumImplCopyWithImpl<$Res>
    extends _$SchemaEnumCopyWithImpl<$Res, _$SchemaEnumImpl>
    implements _$$SchemaEnumImplCopyWith<$Res> {
  __$$SchemaEnumImplCopyWithImpl(
      _$SchemaEnumImpl _value, $Res Function(_$SchemaEnumImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? values = null,
  }) {
    return _then(_$SchemaEnumImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SchemaEnumImpl implements _SchemaEnum {
  const _$SchemaEnumImpl(
      {required this.name, required final List<String> values})
      : _values = values;

  factory _$SchemaEnumImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchemaEnumImplFromJson(json);

  @override
  final String name;
  final List<String> _values;
  @override
  List<String> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'SchemaEnum(name: $name, values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchemaEnumImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SchemaEnumImplCopyWith<_$SchemaEnumImpl> get copyWith =>
      __$$SchemaEnumImplCopyWithImpl<_$SchemaEnumImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchemaEnumImplToJson(
      this,
    );
  }
}

abstract class _SchemaEnum implements SchemaEnum {
  const factory _SchemaEnum(
      {required final String name,
      required final List<String> values}) = _$SchemaEnumImpl;

  factory _SchemaEnum.fromJson(Map<String, dynamic> json) =
      _$SchemaEnumImpl.fromJson;

  @override
  String get name;
  @override
  List<String> get values;
  @override
  @JsonKey(ignore: true)
  _$$SchemaEnumImplCopyWith<_$SchemaEnumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OutputObjectTypes _$OutputObjectTypesFromJson(Map<String, dynamic> json) {
  return _OutputObjectTypes.fromJson(json);
}

/// @nodoc
mixin _$OutputObjectTypes {
  List<OutputType> get model => throw _privateConstructorUsedError;
  List<OutputType> get prisma => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutputObjectTypesCopyWith<OutputObjectTypes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutputObjectTypesCopyWith<$Res> {
  factory $OutputObjectTypesCopyWith(
          OutputObjectTypes value, $Res Function(OutputObjectTypes) then) =
      _$OutputObjectTypesCopyWithImpl<$Res, OutputObjectTypes>;
  @useResult
  $Res call({List<OutputType> model, List<OutputType> prisma});
}

/// @nodoc
class _$OutputObjectTypesCopyWithImpl<$Res, $Val extends OutputObjectTypes>
    implements $OutputObjectTypesCopyWith<$Res> {
  _$OutputObjectTypesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
    Object? prisma = null,
  }) {
    return _then(_value.copyWith(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as List<OutputType>,
      prisma: null == prisma
          ? _value.prisma
          : prisma // ignore: cast_nullable_to_non_nullable
              as List<OutputType>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutputObjectTypesImplCopyWith<$Res>
    implements $OutputObjectTypesCopyWith<$Res> {
  factory _$$OutputObjectTypesImplCopyWith(_$OutputObjectTypesImpl value,
          $Res Function(_$OutputObjectTypesImpl) then) =
      __$$OutputObjectTypesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OutputType> model, List<OutputType> prisma});
}

/// @nodoc
class __$$OutputObjectTypesImplCopyWithImpl<$Res>
    extends _$OutputObjectTypesCopyWithImpl<$Res, _$OutputObjectTypesImpl>
    implements _$$OutputObjectTypesImplCopyWith<$Res> {
  __$$OutputObjectTypesImplCopyWithImpl(_$OutputObjectTypesImpl _value,
      $Res Function(_$OutputObjectTypesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
    Object? prisma = null,
  }) {
    return _then(_$OutputObjectTypesImpl(
      model: null == model
          ? _value._model
          : model // ignore: cast_nullable_to_non_nullable
              as List<OutputType>,
      prisma: null == prisma
          ? _value._prisma
          : prisma // ignore: cast_nullable_to_non_nullable
              as List<OutputType>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutputObjectTypesImpl implements _OutputObjectTypes {
  const _$OutputObjectTypesImpl(
      {required final List<OutputType> model,
      required final List<OutputType> prisma})
      : _model = model,
        _prisma = prisma;

  factory _$OutputObjectTypesImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutputObjectTypesImplFromJson(json);

  final List<OutputType> _model;
  @override
  List<OutputType> get model {
    if (_model is EqualUnmodifiableListView) return _model;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_model);
  }

  final List<OutputType> _prisma;
  @override
  List<OutputType> get prisma {
    if (_prisma is EqualUnmodifiableListView) return _prisma;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prisma);
  }

  @override
  String toString() {
    return 'OutputObjectTypes(model: $model, prisma: $prisma)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutputObjectTypesImpl &&
            const DeepCollectionEquality().equals(other._model, _model) &&
            const DeepCollectionEquality().equals(other._prisma, _prisma));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_model),
      const DeepCollectionEquality().hash(_prisma));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutputObjectTypesImplCopyWith<_$OutputObjectTypesImpl> get copyWith =>
      __$$OutputObjectTypesImplCopyWithImpl<_$OutputObjectTypesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutputObjectTypesImplToJson(
      this,
    );
  }
}

abstract class _OutputObjectTypes implements OutputObjectTypes {
  const factory _OutputObjectTypes(
      {required final List<OutputType> model,
      required final List<OutputType> prisma}) = _$OutputObjectTypesImpl;

  factory _OutputObjectTypes.fromJson(Map<String, dynamic> json) =
      _$OutputObjectTypesImpl.fromJson;

  @override
  List<OutputType> get model;
  @override
  List<OutputType> get prisma;
  @override
  @JsonKey(ignore: true)
  _$$OutputObjectTypesImplCopyWith<_$OutputObjectTypesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OutputType _$OutputTypeFromJson(Map<String, dynamic> json) {
  return _OutputType.fromJson(json);
}

/// @nodoc
mixin _$OutputType {
  String get name => throw _privateConstructorUsedError;
  List<SchemaField> get fields => throw _privateConstructorUsedError;
  Map<String, SchemaField>? get fieldsMap => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutputTypeCopyWith<OutputType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutputTypeCopyWith<$Res> {
  factory $OutputTypeCopyWith(
          OutputType value, $Res Function(OutputType) then) =
      _$OutputTypeCopyWithImpl<$Res, OutputType>;
  @useResult
  $Res call(
      {String name,
      List<SchemaField> fields,
      Map<String, SchemaField>? fieldsMap});
}

/// @nodoc
class _$OutputTypeCopyWithImpl<$Res, $Val extends OutputType>
    implements $OutputTypeCopyWith<$Res> {
  _$OutputTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? fields = null,
    Object? fieldsMap = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<SchemaField>,
      fieldsMap: freezed == fieldsMap
          ? _value.fieldsMap
          : fieldsMap // ignore: cast_nullable_to_non_nullable
              as Map<String, SchemaField>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutputTypeImplCopyWith<$Res>
    implements $OutputTypeCopyWith<$Res> {
  factory _$$OutputTypeImplCopyWith(
          _$OutputTypeImpl value, $Res Function(_$OutputTypeImpl) then) =
      __$$OutputTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      List<SchemaField> fields,
      Map<String, SchemaField>? fieldsMap});
}

/// @nodoc
class __$$OutputTypeImplCopyWithImpl<$Res>
    extends _$OutputTypeCopyWithImpl<$Res, _$OutputTypeImpl>
    implements _$$OutputTypeImplCopyWith<$Res> {
  __$$OutputTypeImplCopyWithImpl(
      _$OutputTypeImpl _value, $Res Function(_$OutputTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? fields = null,
    Object? fieldsMap = freezed,
  }) {
    return _then(_$OutputTypeImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<SchemaField>,
      fieldsMap: freezed == fieldsMap
          ? _value._fieldsMap
          : fieldsMap // ignore: cast_nullable_to_non_nullable
              as Map<String, SchemaField>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutputTypeImpl implements _OutputType {
  const _$OutputTypeImpl(
      {required this.name,
      required final List<SchemaField> fields,
      final Map<String, SchemaField>? fieldsMap})
      : _fields = fields,
        _fieldsMap = fieldsMap;

  factory _$OutputTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutputTypeImplFromJson(json);

  @override
  final String name;
  final List<SchemaField> _fields;
  @override
  List<SchemaField> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  final Map<String, SchemaField>? _fieldsMap;
  @override
  Map<String, SchemaField>? get fieldsMap {
    final value = _fieldsMap;
    if (value == null) return null;
    if (_fieldsMap is EqualUnmodifiableMapView) return _fieldsMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'OutputType(name: $name, fields: $fields, fieldsMap: $fieldsMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutputTypeImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            const DeepCollectionEquality()
                .equals(other._fieldsMap, _fieldsMap));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_fields),
      const DeepCollectionEquality().hash(_fieldsMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutputTypeImplCopyWith<_$OutputTypeImpl> get copyWith =>
      __$$OutputTypeImplCopyWithImpl<_$OutputTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutputTypeImplToJson(
      this,
    );
  }
}

abstract class _OutputType implements OutputType {
  const factory _OutputType(
      {required final String name,
      required final List<SchemaField> fields,
      final Map<String, SchemaField>? fieldsMap}) = _$OutputTypeImpl;

  factory _OutputType.fromJson(Map<String, dynamic> json) =
      _$OutputTypeImpl.fromJson;

  @override
  String get name;
  @override
  List<SchemaField> get fields;
  @override
  Map<String, SchemaField>? get fieldsMap;
  @override
  @JsonKey(ignore: true)
  _$$OutputTypeImplCopyWith<_$OutputTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SchemaField _$SchemaFieldFromJson(Map<String, dynamic> json) {
  return _SchemaField.fromJson(json);
}

/// @nodoc
mixin _$SchemaField {
  String get name => throw _privateConstructorUsedError;
  bool? get isNullable => throw _privateConstructorUsedError;
  OutputTypeRef get outputType => throw _privateConstructorUsedError;
  List<SchemaArg> get args => throw _privateConstructorUsedError;
  Deprecation? get deprecation => throw _privateConstructorUsedError;
  String? get documentation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SchemaFieldCopyWith<SchemaField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchemaFieldCopyWith<$Res> {
  factory $SchemaFieldCopyWith(
          SchemaField value, $Res Function(SchemaField) then) =
      _$SchemaFieldCopyWithImpl<$Res, SchemaField>;
  @useResult
  $Res call(
      {String name,
      bool? isNullable,
      OutputTypeRef outputType,
      List<SchemaArg> args,
      Deprecation? deprecation,
      String? documentation});

  $OutputTypeRefCopyWith<$Res> get outputType;
  $DeprecationCopyWith<$Res>? get deprecation;
}

/// @nodoc
class _$SchemaFieldCopyWithImpl<$Res, $Val extends SchemaField>
    implements $SchemaFieldCopyWith<$Res> {
  _$SchemaFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isNullable = freezed,
    Object? outputType = null,
    Object? args = null,
    Object? deprecation = freezed,
    Object? documentation = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isNullable: freezed == isNullable
          ? _value.isNullable
          : isNullable // ignore: cast_nullable_to_non_nullable
              as bool?,
      outputType: null == outputType
          ? _value.outputType
          : outputType // ignore: cast_nullable_to_non_nullable
              as OutputTypeRef,
      args: null == args
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as List<SchemaArg>,
      deprecation: freezed == deprecation
          ? _value.deprecation
          : deprecation // ignore: cast_nullable_to_non_nullable
              as Deprecation?,
      documentation: freezed == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OutputTypeRefCopyWith<$Res> get outputType {
    return $OutputTypeRefCopyWith<$Res>(_value.outputType, (value) {
      return _then(_value.copyWith(outputType: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DeprecationCopyWith<$Res>? get deprecation {
    if (_value.deprecation == null) {
      return null;
    }

    return $DeprecationCopyWith<$Res>(_value.deprecation!, (value) {
      return _then(_value.copyWith(deprecation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SchemaFieldImplCopyWith<$Res>
    implements $SchemaFieldCopyWith<$Res> {
  factory _$$SchemaFieldImplCopyWith(
          _$SchemaFieldImpl value, $Res Function(_$SchemaFieldImpl) then) =
      __$$SchemaFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      bool? isNullable,
      OutputTypeRef outputType,
      List<SchemaArg> args,
      Deprecation? deprecation,
      String? documentation});

  @override
  $OutputTypeRefCopyWith<$Res> get outputType;
  @override
  $DeprecationCopyWith<$Res>? get deprecation;
}

/// @nodoc
class __$$SchemaFieldImplCopyWithImpl<$Res>
    extends _$SchemaFieldCopyWithImpl<$Res, _$SchemaFieldImpl>
    implements _$$SchemaFieldImplCopyWith<$Res> {
  __$$SchemaFieldImplCopyWithImpl(
      _$SchemaFieldImpl _value, $Res Function(_$SchemaFieldImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isNullable = freezed,
    Object? outputType = null,
    Object? args = null,
    Object? deprecation = freezed,
    Object? documentation = freezed,
  }) {
    return _then(_$SchemaFieldImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isNullable: freezed == isNullable
          ? _value.isNullable
          : isNullable // ignore: cast_nullable_to_non_nullable
              as bool?,
      outputType: null == outputType
          ? _value.outputType
          : outputType // ignore: cast_nullable_to_non_nullable
              as OutputTypeRef,
      args: null == args
          ? _value._args
          : args // ignore: cast_nullable_to_non_nullable
              as List<SchemaArg>,
      deprecation: freezed == deprecation
          ? _value.deprecation
          : deprecation // ignore: cast_nullable_to_non_nullable
              as Deprecation?,
      documentation: freezed == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SchemaFieldImpl implements _SchemaField {
  const _$SchemaFieldImpl(
      {required this.name,
      this.isNullable,
      required this.outputType,
      required final List<SchemaArg> args,
      this.deprecation,
      this.documentation})
      : _args = args;

  factory _$SchemaFieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchemaFieldImplFromJson(json);

  @override
  final String name;
  @override
  final bool? isNullable;
  @override
  final OutputTypeRef outputType;
  final List<SchemaArg> _args;
  @override
  List<SchemaArg> get args {
    if (_args is EqualUnmodifiableListView) return _args;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_args);
  }

  @override
  final Deprecation? deprecation;
  @override
  final String? documentation;

  @override
  String toString() {
    return 'SchemaField(name: $name, isNullable: $isNullable, outputType: $outputType, args: $args, deprecation: $deprecation, documentation: $documentation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchemaFieldImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isNullable, isNullable) ||
                other.isNullable == isNullable) &&
            (identical(other.outputType, outputType) ||
                other.outputType == outputType) &&
            const DeepCollectionEquality().equals(other._args, _args) &&
            (identical(other.deprecation, deprecation) ||
                other.deprecation == deprecation) &&
            (identical(other.documentation, documentation) ||
                other.documentation == documentation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, isNullable, outputType,
      const DeepCollectionEquality().hash(_args), deprecation, documentation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SchemaFieldImplCopyWith<_$SchemaFieldImpl> get copyWith =>
      __$$SchemaFieldImplCopyWithImpl<_$SchemaFieldImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchemaFieldImplToJson(
      this,
    );
  }
}

abstract class _SchemaField implements SchemaField {
  const factory _SchemaField(
      {required final String name,
      final bool? isNullable,
      required final OutputTypeRef outputType,
      required final List<SchemaArg> args,
      final Deprecation? deprecation,
      final String? documentation}) = _$SchemaFieldImpl;

  factory _SchemaField.fromJson(Map<String, dynamic> json) =
      _$SchemaFieldImpl.fromJson;

  @override
  String get name;
  @override
  bool? get isNullable;
  @override
  OutputTypeRef get outputType;
  @override
  List<SchemaArg> get args;
  @override
  Deprecation? get deprecation;
  @override
  String? get documentation;
  @override
  @JsonKey(ignore: true)
  _$$SchemaFieldImplCopyWith<_$SchemaFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OutputTypeRef _$OutputTypeRefFromJson(Map<String, dynamic> json) {
  return _OutputTypeRef.fromJson(json);
}

/// @nodoc
mixin _$OutputTypeRef {
  bool get isList => throw _privateConstructorUsedError;
  FieldNamespace? get namespace => throw _privateConstructorUsedError;
  FieldLocation get location => throw _privateConstructorUsedError;
  @_OutputTypeRefTypeConverter()
  OutputTypeRefType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutputTypeRefCopyWith<OutputTypeRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutputTypeRefCopyWith<$Res> {
  factory $OutputTypeRefCopyWith(
          OutputTypeRef value, $Res Function(OutputTypeRef) then) =
      _$OutputTypeRefCopyWithImpl<$Res, OutputTypeRef>;
  @useResult
  $Res call(
      {bool isList,
      FieldNamespace? namespace,
      FieldLocation location,
      @_OutputTypeRefTypeConverter() OutputTypeRefType type});

  $OutputTypeRefTypeCopyWith<$Res> get type;
}

/// @nodoc
class _$OutputTypeRefCopyWithImpl<$Res, $Val extends OutputTypeRef>
    implements $OutputTypeRefCopyWith<$Res> {
  _$OutputTypeRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isList = null,
    Object? namespace = freezed,
    Object? location = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      isList: null == isList
          ? _value.isList
          : isList // ignore: cast_nullable_to_non_nullable
              as bool,
      namespace: freezed == namespace
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as FieldNamespace?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as FieldLocation,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as OutputTypeRefType,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OutputTypeRefTypeCopyWith<$Res> get type {
    return $OutputTypeRefTypeCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OutputTypeRefImplCopyWith<$Res>
    implements $OutputTypeRefCopyWith<$Res> {
  factory _$$OutputTypeRefImplCopyWith(
          _$OutputTypeRefImpl value, $Res Function(_$OutputTypeRefImpl) then) =
      __$$OutputTypeRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isList,
      FieldNamespace? namespace,
      FieldLocation location,
      @_OutputTypeRefTypeConverter() OutputTypeRefType type});

  @override
  $OutputTypeRefTypeCopyWith<$Res> get type;
}

/// @nodoc
class __$$OutputTypeRefImplCopyWithImpl<$Res>
    extends _$OutputTypeRefCopyWithImpl<$Res, _$OutputTypeRefImpl>
    implements _$$OutputTypeRefImplCopyWith<$Res> {
  __$$OutputTypeRefImplCopyWithImpl(
      _$OutputTypeRefImpl _value, $Res Function(_$OutputTypeRefImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isList = null,
    Object? namespace = freezed,
    Object? location = null,
    Object? type = null,
  }) {
    return _then(_$OutputTypeRefImpl(
      isList: null == isList
          ? _value.isList
          : isList // ignore: cast_nullable_to_non_nullable
              as bool,
      namespace: freezed == namespace
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as FieldNamespace?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as FieldLocation,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as OutputTypeRefType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutputTypeRefImpl implements _OutputTypeRef {
  const _$OutputTypeRefImpl(
      {required this.isList,
      this.namespace,
      required this.location,
      @_OutputTypeRefTypeConverter() required this.type});

  factory _$OutputTypeRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutputTypeRefImplFromJson(json);

  @override
  final bool isList;
  @override
  final FieldNamespace? namespace;
  @override
  final FieldLocation location;
  @override
  @_OutputTypeRefTypeConverter()
  final OutputTypeRefType type;

  @override
  String toString() {
    return 'OutputTypeRef(isList: $isList, namespace: $namespace, location: $location, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutputTypeRefImpl &&
            (identical(other.isList, isList) || other.isList == isList) &&
            (identical(other.namespace, namespace) ||
                other.namespace == namespace) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isList, namespace, location, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutputTypeRefImplCopyWith<_$OutputTypeRefImpl> get copyWith =>
      __$$OutputTypeRefImplCopyWithImpl<_$OutputTypeRefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutputTypeRefImplToJson(
      this,
    );
  }
}

abstract class _OutputTypeRef implements OutputTypeRef {
  const factory _OutputTypeRef(
      {required final bool isList,
      final FieldNamespace? namespace,
      required final FieldLocation location,
      @_OutputTypeRefTypeConverter()
      required final OutputTypeRefType type}) = _$OutputTypeRefImpl;

  factory _OutputTypeRef.fromJson(Map<String, dynamic> json) =
      _$OutputTypeRefImpl.fromJson;

  @override
  bool get isList;
  @override
  FieldNamespace? get namespace;
  @override
  FieldLocation get location;
  @override
  @_OutputTypeRefTypeConverter()
  OutputTypeRefType get type;
  @override
  @JsonKey(ignore: true)
  _$$OutputTypeRefImplCopyWith<_$OutputTypeRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OutputTypeRefType _$OutputTypeRefTypeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'string':
      return StringOutputTypeRefType.fromJson(json);
    case 'object':
      return ObjectOutputTypeRefType.fromJson(json);
    case 'enum_':
      return EnumOutputTypeRefType.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'OutputTypeRefType',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$OutputTypeRefType {
  Object get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) string,
    required TResult Function(OutputType value) object,
    required TResult Function(SchemaEnum value) enum_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? string,
    TResult? Function(OutputType value)? object,
    TResult? Function(SchemaEnum value)? enum_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? string,
    TResult Function(OutputType value)? object,
    TResult Function(SchemaEnum value)? enum_,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringOutputTypeRefType value) string,
    required TResult Function(ObjectOutputTypeRefType value) object,
    required TResult Function(EnumOutputTypeRefType value) enum_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringOutputTypeRefType value)? string,
    TResult? Function(ObjectOutputTypeRefType value)? object,
    TResult? Function(EnumOutputTypeRefType value)? enum_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringOutputTypeRefType value)? string,
    TResult Function(ObjectOutputTypeRefType value)? object,
    TResult Function(EnumOutputTypeRefType value)? enum_,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutputTypeRefTypeCopyWith<$Res> {
  factory $OutputTypeRefTypeCopyWith(
          OutputTypeRefType value, $Res Function(OutputTypeRefType) then) =
      _$OutputTypeRefTypeCopyWithImpl<$Res, OutputTypeRefType>;
}

/// @nodoc
class _$OutputTypeRefTypeCopyWithImpl<$Res, $Val extends OutputTypeRefType>
    implements $OutputTypeRefTypeCopyWith<$Res> {
  _$OutputTypeRefTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StringOutputTypeRefTypeImplCopyWith<$Res> {
  factory _$$StringOutputTypeRefTypeImplCopyWith(
          _$StringOutputTypeRefTypeImpl value,
          $Res Function(_$StringOutputTypeRefTypeImpl) then) =
      __$$StringOutputTypeRefTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$StringOutputTypeRefTypeImplCopyWithImpl<$Res>
    extends _$OutputTypeRefTypeCopyWithImpl<$Res, _$StringOutputTypeRefTypeImpl>
    implements _$$StringOutputTypeRefTypeImplCopyWith<$Res> {
  __$$StringOutputTypeRefTypeImplCopyWithImpl(
      _$StringOutputTypeRefTypeImpl _value,
      $Res Function(_$StringOutputTypeRefTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$StringOutputTypeRefTypeImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StringOutputTypeRefTypeImpl implements StringOutputTypeRefType {
  const _$StringOutputTypeRefTypeImpl(this.value, {final String? $type})
      : $type = $type ?? 'string';

  factory _$StringOutputTypeRefTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$StringOutputTypeRefTypeImplFromJson(json);

  @override
  final String value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'OutputTypeRefType.string(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StringOutputTypeRefTypeImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StringOutputTypeRefTypeImplCopyWith<_$StringOutputTypeRefTypeImpl>
      get copyWith => __$$StringOutputTypeRefTypeImplCopyWithImpl<
          _$StringOutputTypeRefTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) string,
    required TResult Function(OutputType value) object,
    required TResult Function(SchemaEnum value) enum_,
  }) {
    return string(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? string,
    TResult? Function(OutputType value)? object,
    TResult? Function(SchemaEnum value)? enum_,
  }) {
    return string?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? string,
    TResult Function(OutputType value)? object,
    TResult Function(SchemaEnum value)? enum_,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringOutputTypeRefType value) string,
    required TResult Function(ObjectOutputTypeRefType value) object,
    required TResult Function(EnumOutputTypeRefType value) enum_,
  }) {
    return string(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringOutputTypeRefType value)? string,
    TResult? Function(ObjectOutputTypeRefType value)? object,
    TResult? Function(EnumOutputTypeRefType value)? enum_,
  }) {
    return string?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringOutputTypeRefType value)? string,
    TResult Function(ObjectOutputTypeRefType value)? object,
    TResult Function(EnumOutputTypeRefType value)? enum_,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StringOutputTypeRefTypeImplToJson(
      this,
    );
  }
}

abstract class StringOutputTypeRefType implements OutputTypeRefType {
  const factory StringOutputTypeRefType(final String value) =
      _$StringOutputTypeRefTypeImpl;

  factory StringOutputTypeRefType.fromJson(Map<String, dynamic> json) =
      _$StringOutputTypeRefTypeImpl.fromJson;

  @override
  String get value;
  @JsonKey(ignore: true)
  _$$StringOutputTypeRefTypeImplCopyWith<_$StringOutputTypeRefTypeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ObjectOutputTypeRefTypeImplCopyWith<$Res> {
  factory _$$ObjectOutputTypeRefTypeImplCopyWith(
          _$ObjectOutputTypeRefTypeImpl value,
          $Res Function(_$ObjectOutputTypeRefTypeImpl) then) =
      __$$ObjectOutputTypeRefTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OutputType value});

  $OutputTypeCopyWith<$Res> get value;
}

/// @nodoc
class __$$ObjectOutputTypeRefTypeImplCopyWithImpl<$Res>
    extends _$OutputTypeRefTypeCopyWithImpl<$Res, _$ObjectOutputTypeRefTypeImpl>
    implements _$$ObjectOutputTypeRefTypeImplCopyWith<$Res> {
  __$$ObjectOutputTypeRefTypeImplCopyWithImpl(
      _$ObjectOutputTypeRefTypeImpl _value,
      $Res Function(_$ObjectOutputTypeRefTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$ObjectOutputTypeRefTypeImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as OutputType,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $OutputTypeCopyWith<$Res> get value {
    return $OutputTypeCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ObjectOutputTypeRefTypeImpl implements ObjectOutputTypeRefType {
  const _$ObjectOutputTypeRefTypeImpl(this.value, {final String? $type})
      : $type = $type ?? 'object';

  factory _$ObjectOutputTypeRefTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ObjectOutputTypeRefTypeImplFromJson(json);

  @override
  final OutputType value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'OutputTypeRefType.object(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ObjectOutputTypeRefTypeImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ObjectOutputTypeRefTypeImplCopyWith<_$ObjectOutputTypeRefTypeImpl>
      get copyWith => __$$ObjectOutputTypeRefTypeImplCopyWithImpl<
          _$ObjectOutputTypeRefTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) string,
    required TResult Function(OutputType value) object,
    required TResult Function(SchemaEnum value) enum_,
  }) {
    return object(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? string,
    TResult? Function(OutputType value)? object,
    TResult? Function(SchemaEnum value)? enum_,
  }) {
    return object?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? string,
    TResult Function(OutputType value)? object,
    TResult Function(SchemaEnum value)? enum_,
    required TResult orElse(),
  }) {
    if (object != null) {
      return object(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringOutputTypeRefType value) string,
    required TResult Function(ObjectOutputTypeRefType value) object,
    required TResult Function(EnumOutputTypeRefType value) enum_,
  }) {
    return object(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringOutputTypeRefType value)? string,
    TResult? Function(ObjectOutputTypeRefType value)? object,
    TResult? Function(EnumOutputTypeRefType value)? enum_,
  }) {
    return object?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringOutputTypeRefType value)? string,
    TResult Function(ObjectOutputTypeRefType value)? object,
    TResult Function(EnumOutputTypeRefType value)? enum_,
    required TResult orElse(),
  }) {
    if (object != null) {
      return object(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ObjectOutputTypeRefTypeImplToJson(
      this,
    );
  }
}

abstract class ObjectOutputTypeRefType implements OutputTypeRefType {
  const factory ObjectOutputTypeRefType(final OutputType value) =
      _$ObjectOutputTypeRefTypeImpl;

  factory ObjectOutputTypeRefType.fromJson(Map<String, dynamic> json) =
      _$ObjectOutputTypeRefTypeImpl.fromJson;

  @override
  OutputType get value;
  @JsonKey(ignore: true)
  _$$ObjectOutputTypeRefTypeImplCopyWith<_$ObjectOutputTypeRefTypeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EnumOutputTypeRefTypeImplCopyWith<$Res> {
  factory _$$EnumOutputTypeRefTypeImplCopyWith(
          _$EnumOutputTypeRefTypeImpl value,
          $Res Function(_$EnumOutputTypeRefTypeImpl) then) =
      __$$EnumOutputTypeRefTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SchemaEnum value});

  $SchemaEnumCopyWith<$Res> get value;
}

/// @nodoc
class __$$EnumOutputTypeRefTypeImplCopyWithImpl<$Res>
    extends _$OutputTypeRefTypeCopyWithImpl<$Res, _$EnumOutputTypeRefTypeImpl>
    implements _$$EnumOutputTypeRefTypeImplCopyWith<$Res> {
  __$$EnumOutputTypeRefTypeImplCopyWithImpl(_$EnumOutputTypeRefTypeImpl _value,
      $Res Function(_$EnumOutputTypeRefTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$EnumOutputTypeRefTypeImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as SchemaEnum,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SchemaEnumCopyWith<$Res> get value {
    return $SchemaEnumCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$EnumOutputTypeRefTypeImpl implements EnumOutputTypeRefType {
  const _$EnumOutputTypeRefTypeImpl(this.value, {final String? $type})
      : $type = $type ?? 'enum_';

  factory _$EnumOutputTypeRefTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnumOutputTypeRefTypeImplFromJson(json);

  @override
  final SchemaEnum value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'OutputTypeRefType.enum_(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnumOutputTypeRefTypeImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EnumOutputTypeRefTypeImplCopyWith<_$EnumOutputTypeRefTypeImpl>
      get copyWith => __$$EnumOutputTypeRefTypeImplCopyWithImpl<
          _$EnumOutputTypeRefTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) string,
    required TResult Function(OutputType value) object,
    required TResult Function(SchemaEnum value) enum_,
  }) {
    return enum_(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? string,
    TResult? Function(OutputType value)? object,
    TResult? Function(SchemaEnum value)? enum_,
  }) {
    return enum_?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? string,
    TResult Function(OutputType value)? object,
    TResult Function(SchemaEnum value)? enum_,
    required TResult orElse(),
  }) {
    if (enum_ != null) {
      return enum_(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringOutputTypeRefType value) string,
    required TResult Function(ObjectOutputTypeRefType value) object,
    required TResult Function(EnumOutputTypeRefType value) enum_,
  }) {
    return enum_(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringOutputTypeRefType value)? string,
    TResult? Function(ObjectOutputTypeRefType value)? object,
    TResult? Function(EnumOutputTypeRefType value)? enum_,
  }) {
    return enum_?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringOutputTypeRefType value)? string,
    TResult Function(ObjectOutputTypeRefType value)? object,
    TResult Function(EnumOutputTypeRefType value)? enum_,
    required TResult orElse(),
  }) {
    if (enum_ != null) {
      return enum_(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EnumOutputTypeRefTypeImplToJson(
      this,
    );
  }
}

abstract class EnumOutputTypeRefType implements OutputTypeRefType {
  const factory EnumOutputTypeRefType(final SchemaEnum value) =
      _$EnumOutputTypeRefTypeImpl;

  factory EnumOutputTypeRefType.fromJson(Map<String, dynamic> json) =
      _$EnumOutputTypeRefTypeImpl.fromJson;

  @override
  SchemaEnum get value;
  @JsonKey(ignore: true)
  _$$EnumOutputTypeRefTypeImplCopyWith<_$EnumOutputTypeRefTypeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EnumTypes _$EnumTypesFromJson(Map<String, dynamic> json) {
  return _EnumTypes.fromJson(json);
}

/// @nodoc
mixin _$EnumTypes {
  List<SchemaEnum>? get model => throw _privateConstructorUsedError;
  List<SchemaEnum> get prisma => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EnumTypesCopyWith<EnumTypes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnumTypesCopyWith<$Res> {
  factory $EnumTypesCopyWith(EnumTypes value, $Res Function(EnumTypes) then) =
      _$EnumTypesCopyWithImpl<$Res, EnumTypes>;
  @useResult
  $Res call({List<SchemaEnum>? model, List<SchemaEnum> prisma});
}

/// @nodoc
class _$EnumTypesCopyWithImpl<$Res, $Val extends EnumTypes>
    implements $EnumTypesCopyWith<$Res> {
  _$EnumTypesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = freezed,
    Object? prisma = null,
  }) {
    return _then(_value.copyWith(
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as List<SchemaEnum>?,
      prisma: null == prisma
          ? _value.prisma
          : prisma // ignore: cast_nullable_to_non_nullable
              as List<SchemaEnum>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnumTypesImplCopyWith<$Res>
    implements $EnumTypesCopyWith<$Res> {
  factory _$$EnumTypesImplCopyWith(
          _$EnumTypesImpl value, $Res Function(_$EnumTypesImpl) then) =
      __$$EnumTypesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SchemaEnum>? model, List<SchemaEnum> prisma});
}

/// @nodoc
class __$$EnumTypesImplCopyWithImpl<$Res>
    extends _$EnumTypesCopyWithImpl<$Res, _$EnumTypesImpl>
    implements _$$EnumTypesImplCopyWith<$Res> {
  __$$EnumTypesImplCopyWithImpl(
      _$EnumTypesImpl _value, $Res Function(_$EnumTypesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = freezed,
    Object? prisma = null,
  }) {
    return _then(_$EnumTypesImpl(
      model: freezed == model
          ? _value._model
          : model // ignore: cast_nullable_to_non_nullable
              as List<SchemaEnum>?,
      prisma: null == prisma
          ? _value._prisma
          : prisma // ignore: cast_nullable_to_non_nullable
              as List<SchemaEnum>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnumTypesImpl implements _EnumTypes {
  const _$EnumTypesImpl(
      {final List<SchemaEnum>? model, required final List<SchemaEnum> prisma})
      : _model = model,
        _prisma = prisma;

  factory _$EnumTypesImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnumTypesImplFromJson(json);

  final List<SchemaEnum>? _model;
  @override
  List<SchemaEnum>? get model {
    final value = _model;
    if (value == null) return null;
    if (_model is EqualUnmodifiableListView) return _model;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SchemaEnum> _prisma;
  @override
  List<SchemaEnum> get prisma {
    if (_prisma is EqualUnmodifiableListView) return _prisma;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prisma);
  }

  @override
  String toString() {
    return 'EnumTypes(model: $model, prisma: $prisma)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnumTypesImpl &&
            const DeepCollectionEquality().equals(other._model, _model) &&
            const DeepCollectionEquality().equals(other._prisma, _prisma));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_model),
      const DeepCollectionEquality().hash(_prisma));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EnumTypesImplCopyWith<_$EnumTypesImpl> get copyWith =>
      __$$EnumTypesImplCopyWithImpl<_$EnumTypesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnumTypesImplToJson(
      this,
    );
  }
}

abstract class _EnumTypes implements EnumTypes {
  const factory _EnumTypes(
      {final List<SchemaEnum>? model,
      required final List<SchemaEnum> prisma}) = _$EnumTypesImpl;

  factory _EnumTypes.fromJson(Map<String, dynamic> json) =
      _$EnumTypesImpl.fromJson;

  @override
  List<SchemaEnum>? get model;
  @override
  List<SchemaEnum> get prisma;
  @override
  @JsonKey(ignore: true)
  _$$EnumTypesImplCopyWith<_$EnumTypesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FieldRefTypes _$FieldRefTypesFromJson(Map<String, dynamic> json) {
  return _FieldRefTypes.fromJson(json);
}

/// @nodoc
mixin _$FieldRefTypes {
  List<FieldRefType>? get prisma => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldRefTypesCopyWith<FieldRefTypes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldRefTypesCopyWith<$Res> {
  factory $FieldRefTypesCopyWith(
          FieldRefTypes value, $Res Function(FieldRefTypes) then) =
      _$FieldRefTypesCopyWithImpl<$Res, FieldRefTypes>;
  @useResult
  $Res call({List<FieldRefType>? prisma});
}

/// @nodoc
class _$FieldRefTypesCopyWithImpl<$Res, $Val extends FieldRefTypes>
    implements $FieldRefTypesCopyWith<$Res> {
  _$FieldRefTypesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prisma = freezed,
  }) {
    return _then(_value.copyWith(
      prisma: freezed == prisma
          ? _value.prisma
          : prisma // ignore: cast_nullable_to_non_nullable
              as List<FieldRefType>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldRefTypesImplCopyWith<$Res>
    implements $FieldRefTypesCopyWith<$Res> {
  factory _$$FieldRefTypesImplCopyWith(
          _$FieldRefTypesImpl value, $Res Function(_$FieldRefTypesImpl) then) =
      __$$FieldRefTypesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FieldRefType>? prisma});
}

/// @nodoc
class __$$FieldRefTypesImplCopyWithImpl<$Res>
    extends _$FieldRefTypesCopyWithImpl<$Res, _$FieldRefTypesImpl>
    implements _$$FieldRefTypesImplCopyWith<$Res> {
  __$$FieldRefTypesImplCopyWithImpl(
      _$FieldRefTypesImpl _value, $Res Function(_$FieldRefTypesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prisma = freezed,
  }) {
    return _then(_$FieldRefTypesImpl(
      prisma: freezed == prisma
          ? _value._prisma
          : prisma // ignore: cast_nullable_to_non_nullable
              as List<FieldRefType>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldRefTypesImpl implements _FieldRefTypes {
  const _$FieldRefTypesImpl({final List<FieldRefType>? prisma})
      : _prisma = prisma;

  factory _$FieldRefTypesImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldRefTypesImplFromJson(json);

  final List<FieldRefType>? _prisma;
  @override
  List<FieldRefType>? get prisma {
    final value = _prisma;
    if (value == null) return null;
    if (_prisma is EqualUnmodifiableListView) return _prisma;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FieldRefTypes(prisma: $prisma)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldRefTypesImpl &&
            const DeepCollectionEquality().equals(other._prisma, _prisma));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_prisma));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldRefTypesImplCopyWith<_$FieldRefTypesImpl> get copyWith =>
      __$$FieldRefTypesImplCopyWithImpl<_$FieldRefTypesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldRefTypesImplToJson(
      this,
    );
  }
}

abstract class _FieldRefTypes implements FieldRefTypes {
  const factory _FieldRefTypes({final List<FieldRefType>? prisma}) =
      _$FieldRefTypesImpl;

  factory _FieldRefTypes.fromJson(Map<String, dynamic> json) =
      _$FieldRefTypesImpl.fromJson;

  @override
  List<FieldRefType>? get prisma;
  @override
  @JsonKey(ignore: true)
  _$$FieldRefTypesImplCopyWith<_$FieldRefTypesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FieldRefType _$FieldRefTypeFromJson(Map<String, dynamic> json) {
  return _FieldRefType.fromJson(json);
}

/// @nodoc
mixin _$FieldRefType {
  String get name => throw _privateConstructorUsedError;
  List<OutputTypeRef> get allowTypes => throw _privateConstructorUsedError;
  List<SchemaArg> get fields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldRefTypeCopyWith<FieldRefType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldRefTypeCopyWith<$Res> {
  factory $FieldRefTypeCopyWith(
          FieldRefType value, $Res Function(FieldRefType) then) =
      _$FieldRefTypeCopyWithImpl<$Res, FieldRefType>;
  @useResult
  $Res call(
      {String name, List<OutputTypeRef> allowTypes, List<SchemaArg> fields});
}

/// @nodoc
class _$FieldRefTypeCopyWithImpl<$Res, $Val extends FieldRefType>
    implements $FieldRefTypeCopyWith<$Res> {
  _$FieldRefTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? allowTypes = null,
    Object? fields = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      allowTypes: null == allowTypes
          ? _value.allowTypes
          : allowTypes // ignore: cast_nullable_to_non_nullable
              as List<OutputTypeRef>,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<SchemaArg>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldRefTypeImplCopyWith<$Res>
    implements $FieldRefTypeCopyWith<$Res> {
  factory _$$FieldRefTypeImplCopyWith(
          _$FieldRefTypeImpl value, $Res Function(_$FieldRefTypeImpl) then) =
      __$$FieldRefTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, List<OutputTypeRef> allowTypes, List<SchemaArg> fields});
}

/// @nodoc
class __$$FieldRefTypeImplCopyWithImpl<$Res>
    extends _$FieldRefTypeCopyWithImpl<$Res, _$FieldRefTypeImpl>
    implements _$$FieldRefTypeImplCopyWith<$Res> {
  __$$FieldRefTypeImplCopyWithImpl(
      _$FieldRefTypeImpl _value, $Res Function(_$FieldRefTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? allowTypes = null,
    Object? fields = null,
  }) {
    return _then(_$FieldRefTypeImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      allowTypes: null == allowTypes
          ? _value._allowTypes
          : allowTypes // ignore: cast_nullable_to_non_nullable
              as List<OutputTypeRef>,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<SchemaArg>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldRefTypeImpl implements _FieldRefType {
  const _$FieldRefTypeImpl(
      {required this.name,
      required final List<OutputTypeRef> allowTypes,
      required final List<SchemaArg> fields})
      : _allowTypes = allowTypes,
        _fields = fields;

  factory _$FieldRefTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldRefTypeImplFromJson(json);

  @override
  final String name;
  final List<OutputTypeRef> _allowTypes;
  @override
  List<OutputTypeRef> get allowTypes {
    if (_allowTypes is EqualUnmodifiableListView) return _allowTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowTypes);
  }

  final List<SchemaArg> _fields;
  @override
  List<SchemaArg> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  String toString() {
    return 'FieldRefType(name: $name, allowTypes: $allowTypes, fields: $fields)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldRefTypeImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._allowTypes, _allowTypes) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_allowTypes),
      const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldRefTypeImplCopyWith<_$FieldRefTypeImpl> get copyWith =>
      __$$FieldRefTypeImplCopyWithImpl<_$FieldRefTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldRefTypeImplToJson(
      this,
    );
  }
}

abstract class _FieldRefType implements FieldRefType {
  const factory _FieldRefType(
      {required final String name,
      required final List<OutputTypeRef> allowTypes,
      required final List<SchemaArg> fields}) = _$FieldRefTypeImpl;

  factory _FieldRefType.fromJson(Map<String, dynamic> json) =
      _$FieldRefTypeImpl.fromJson;

  @override
  String get name;
  @override
  List<OutputTypeRef> get allowTypes;
  @override
  List<SchemaArg> get fields;
  @override
  @JsonKey(ignore: true)
  _$$FieldRefTypeImplCopyWith<_$FieldRefTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ModelMapping _$ModelMappingFromJson(Map<String, dynamic> json) {
  return _ModelMapping.fromJson(json);
}

/// @nodoc
mixin _$ModelMapping {
  String get model => throw _privateConstructorUsedError;
  String? get plural => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findUnique => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findUniqueOrThrow => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findFirst => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findFirstOrThrow => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findMany => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get create => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get createMany => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get update => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get updateMany => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get upsert => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get delete => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get deleteMany => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get aggregate => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get groupBy => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get count => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findRaw => throw _privateConstructorUsedError;
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get aggregateRaw => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ModelMappingCopyWith<ModelMapping> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelMappingCopyWith<$Res> {
  factory $ModelMappingCopyWith(
          ModelMapping value, $Res Function(ModelMapping) then) =
      _$ModelMappingCopyWithImpl<$Res, ModelMapping>;
  @useResult
  $Res call(
      {String model,
      String? plural,
      @JsonKey(readValue: _modelMappingActionValueReader) String? findUnique,
      @JsonKey(readValue: _modelMappingActionValueReader)
      String? findUniqueOrThrow,
      @JsonKey(readValue: _modelMappingActionValueReader) String? findFirst,
      @JsonKey(readValue: _modelMappingActionValueReader)
      String? findFirstOrThrow,
      @JsonKey(readValue: _modelMappingActionValueReader) String? findMany,
      @JsonKey(readValue: _modelMappingActionValueReader) String? create,
      @JsonKey(readValue: _modelMappingActionValueReader) String? createMany,
      @JsonKey(readValue: _modelMappingActionValueReader) String? update,
      @JsonKey(readValue: _modelMappingActionValueReader) String? updateMany,
      @JsonKey(readValue: _modelMappingActionValueReader) String? upsert,
      @JsonKey(readValue: _modelMappingActionValueReader) String? delete,
      @JsonKey(readValue: _modelMappingActionValueReader) String? deleteMany,
      @JsonKey(readValue: _modelMappingActionValueReader) String? aggregate,
      @JsonKey(readValue: _modelMappingActionValueReader) String? groupBy,
      @JsonKey(readValue: _modelMappingActionValueReader) String? count,
      @JsonKey(readValue: _modelMappingActionValueReader) String? findRaw,
      @JsonKey(readValue: _modelMappingActionValueReader)
      String? aggregateRaw});
}

/// @nodoc
class _$ModelMappingCopyWithImpl<$Res, $Val extends ModelMapping>
    implements $ModelMappingCopyWith<$Res> {
  _$ModelMappingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
    Object? plural = freezed,
    Object? findUnique = freezed,
    Object? findUniqueOrThrow = freezed,
    Object? findFirst = freezed,
    Object? findFirstOrThrow = freezed,
    Object? findMany = freezed,
    Object? create = freezed,
    Object? createMany = freezed,
    Object? update = freezed,
    Object? updateMany = freezed,
    Object? upsert = freezed,
    Object? delete = freezed,
    Object? deleteMany = freezed,
    Object? aggregate = freezed,
    Object? groupBy = freezed,
    Object? count = freezed,
    Object? findRaw = freezed,
    Object? aggregateRaw = freezed,
  }) {
    return _then(_value.copyWith(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      plural: freezed == plural
          ? _value.plural
          : plural // ignore: cast_nullable_to_non_nullable
              as String?,
      findUnique: freezed == findUnique
          ? _value.findUnique
          : findUnique // ignore: cast_nullable_to_non_nullable
              as String?,
      findUniqueOrThrow: freezed == findUniqueOrThrow
          ? _value.findUniqueOrThrow
          : findUniqueOrThrow // ignore: cast_nullable_to_non_nullable
              as String?,
      findFirst: freezed == findFirst
          ? _value.findFirst
          : findFirst // ignore: cast_nullable_to_non_nullable
              as String?,
      findFirstOrThrow: freezed == findFirstOrThrow
          ? _value.findFirstOrThrow
          : findFirstOrThrow // ignore: cast_nullable_to_non_nullable
              as String?,
      findMany: freezed == findMany
          ? _value.findMany
          : findMany // ignore: cast_nullable_to_non_nullable
              as String?,
      create: freezed == create
          ? _value.create
          : create // ignore: cast_nullable_to_non_nullable
              as String?,
      createMany: freezed == createMany
          ? _value.createMany
          : createMany // ignore: cast_nullable_to_non_nullable
              as String?,
      update: freezed == update
          ? _value.update
          : update // ignore: cast_nullable_to_non_nullable
              as String?,
      updateMany: freezed == updateMany
          ? _value.updateMany
          : updateMany // ignore: cast_nullable_to_non_nullable
              as String?,
      upsert: freezed == upsert
          ? _value.upsert
          : upsert // ignore: cast_nullable_to_non_nullable
              as String?,
      delete: freezed == delete
          ? _value.delete
          : delete // ignore: cast_nullable_to_non_nullable
              as String?,
      deleteMany: freezed == deleteMany
          ? _value.deleteMany
          : deleteMany // ignore: cast_nullable_to_non_nullable
              as String?,
      aggregate: freezed == aggregate
          ? _value.aggregate
          : aggregate // ignore: cast_nullable_to_non_nullable
              as String?,
      groupBy: freezed == groupBy
          ? _value.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as String?,
      findRaw: freezed == findRaw
          ? _value.findRaw
          : findRaw // ignore: cast_nullable_to_non_nullable
              as String?,
      aggregateRaw: freezed == aggregateRaw
          ? _value.aggregateRaw
          : aggregateRaw // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModelMappingImplCopyWith<$Res>
    implements $ModelMappingCopyWith<$Res> {
  factory _$$ModelMappingImplCopyWith(
          _$ModelMappingImpl value, $Res Function(_$ModelMappingImpl) then) =
      __$$ModelMappingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String model,
      String? plural,
      @JsonKey(readValue: _modelMappingActionValueReader) String? findUnique,
      @JsonKey(readValue: _modelMappingActionValueReader)
      String? findUniqueOrThrow,
      @JsonKey(readValue: _modelMappingActionValueReader) String? findFirst,
      @JsonKey(readValue: _modelMappingActionValueReader)
      String? findFirstOrThrow,
      @JsonKey(readValue: _modelMappingActionValueReader) String? findMany,
      @JsonKey(readValue: _modelMappingActionValueReader) String? create,
      @JsonKey(readValue: _modelMappingActionValueReader) String? createMany,
      @JsonKey(readValue: _modelMappingActionValueReader) String? update,
      @JsonKey(readValue: _modelMappingActionValueReader) String? updateMany,
      @JsonKey(readValue: _modelMappingActionValueReader) String? upsert,
      @JsonKey(readValue: _modelMappingActionValueReader) String? delete,
      @JsonKey(readValue: _modelMappingActionValueReader) String? deleteMany,
      @JsonKey(readValue: _modelMappingActionValueReader) String? aggregate,
      @JsonKey(readValue: _modelMappingActionValueReader) String? groupBy,
      @JsonKey(readValue: _modelMappingActionValueReader) String? count,
      @JsonKey(readValue: _modelMappingActionValueReader) String? findRaw,
      @JsonKey(readValue: _modelMappingActionValueReader)
      String? aggregateRaw});
}

/// @nodoc
class __$$ModelMappingImplCopyWithImpl<$Res>
    extends _$ModelMappingCopyWithImpl<$Res, _$ModelMappingImpl>
    implements _$$ModelMappingImplCopyWith<$Res> {
  __$$ModelMappingImplCopyWithImpl(
      _$ModelMappingImpl _value, $Res Function(_$ModelMappingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
    Object? plural = freezed,
    Object? findUnique = freezed,
    Object? findUniqueOrThrow = freezed,
    Object? findFirst = freezed,
    Object? findFirstOrThrow = freezed,
    Object? findMany = freezed,
    Object? create = freezed,
    Object? createMany = freezed,
    Object? update = freezed,
    Object? updateMany = freezed,
    Object? upsert = freezed,
    Object? delete = freezed,
    Object? deleteMany = freezed,
    Object? aggregate = freezed,
    Object? groupBy = freezed,
    Object? count = freezed,
    Object? findRaw = freezed,
    Object? aggregateRaw = freezed,
  }) {
    return _then(_$ModelMappingImpl(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      plural: freezed == plural
          ? _value.plural
          : plural // ignore: cast_nullable_to_non_nullable
              as String?,
      findUnique: freezed == findUnique
          ? _value.findUnique
          : findUnique // ignore: cast_nullable_to_non_nullable
              as String?,
      findUniqueOrThrow: freezed == findUniqueOrThrow
          ? _value.findUniqueOrThrow
          : findUniqueOrThrow // ignore: cast_nullable_to_non_nullable
              as String?,
      findFirst: freezed == findFirst
          ? _value.findFirst
          : findFirst // ignore: cast_nullable_to_non_nullable
              as String?,
      findFirstOrThrow: freezed == findFirstOrThrow
          ? _value.findFirstOrThrow
          : findFirstOrThrow // ignore: cast_nullable_to_non_nullable
              as String?,
      findMany: freezed == findMany
          ? _value.findMany
          : findMany // ignore: cast_nullable_to_non_nullable
              as String?,
      create: freezed == create
          ? _value.create
          : create // ignore: cast_nullable_to_non_nullable
              as String?,
      createMany: freezed == createMany
          ? _value.createMany
          : createMany // ignore: cast_nullable_to_non_nullable
              as String?,
      update: freezed == update
          ? _value.update
          : update // ignore: cast_nullable_to_non_nullable
              as String?,
      updateMany: freezed == updateMany
          ? _value.updateMany
          : updateMany // ignore: cast_nullable_to_non_nullable
              as String?,
      upsert: freezed == upsert
          ? _value.upsert
          : upsert // ignore: cast_nullable_to_non_nullable
              as String?,
      delete: freezed == delete
          ? _value.delete
          : delete // ignore: cast_nullable_to_non_nullable
              as String?,
      deleteMany: freezed == deleteMany
          ? _value.deleteMany
          : deleteMany // ignore: cast_nullable_to_non_nullable
              as String?,
      aggregate: freezed == aggregate
          ? _value.aggregate
          : aggregate // ignore: cast_nullable_to_non_nullable
              as String?,
      groupBy: freezed == groupBy
          ? _value.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as String?,
      findRaw: freezed == findRaw
          ? _value.findRaw
          : findRaw // ignore: cast_nullable_to_non_nullable
              as String?,
      aggregateRaw: freezed == aggregateRaw
          ? _value.aggregateRaw
          : aggregateRaw // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModelMappingImpl implements _ModelMapping {
  const _$ModelMappingImpl(
      {required this.model,
      this.plural,
      @JsonKey(readValue: _modelMappingActionValueReader) this.findUnique,
      @JsonKey(readValue: _modelMappingActionValueReader)
      this.findUniqueOrThrow,
      @JsonKey(readValue: _modelMappingActionValueReader) this.findFirst,
      @JsonKey(readValue: _modelMappingActionValueReader) this.findFirstOrThrow,
      @JsonKey(readValue: _modelMappingActionValueReader) this.findMany,
      @JsonKey(readValue: _modelMappingActionValueReader) this.create,
      @JsonKey(readValue: _modelMappingActionValueReader) this.createMany,
      @JsonKey(readValue: _modelMappingActionValueReader) this.update,
      @JsonKey(readValue: _modelMappingActionValueReader) this.updateMany,
      @JsonKey(readValue: _modelMappingActionValueReader) this.upsert,
      @JsonKey(readValue: _modelMappingActionValueReader) this.delete,
      @JsonKey(readValue: _modelMappingActionValueReader) this.deleteMany,
      @JsonKey(readValue: _modelMappingActionValueReader) this.aggregate,
      @JsonKey(readValue: _modelMappingActionValueReader) this.groupBy,
      @JsonKey(readValue: _modelMappingActionValueReader) this.count,
      @JsonKey(readValue: _modelMappingActionValueReader) this.findRaw,
      @JsonKey(readValue: _modelMappingActionValueReader) this.aggregateRaw});

  factory _$ModelMappingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModelMappingImplFromJson(json);

  @override
  final String model;
  @override
  final String? plural;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? findUnique;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? findUniqueOrThrow;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? findFirst;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? findFirstOrThrow;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? findMany;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? create;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? createMany;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? update;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? updateMany;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? upsert;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? delete;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? deleteMany;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? aggregate;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? groupBy;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? count;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? findRaw;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  final String? aggregateRaw;

  @override
  String toString() {
    return 'ModelMapping(model: $model, plural: $plural, findUnique: $findUnique, findUniqueOrThrow: $findUniqueOrThrow, findFirst: $findFirst, findFirstOrThrow: $findFirstOrThrow, findMany: $findMany, create: $create, createMany: $createMany, update: $update, updateMany: $updateMany, upsert: $upsert, delete: $delete, deleteMany: $deleteMany, aggregate: $aggregate, groupBy: $groupBy, count: $count, findRaw: $findRaw, aggregateRaw: $aggregateRaw)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelMappingImpl &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.plural, plural) || other.plural == plural) &&
            (identical(other.findUnique, findUnique) ||
                other.findUnique == findUnique) &&
            (identical(other.findUniqueOrThrow, findUniqueOrThrow) ||
                other.findUniqueOrThrow == findUniqueOrThrow) &&
            (identical(other.findFirst, findFirst) ||
                other.findFirst == findFirst) &&
            (identical(other.findFirstOrThrow, findFirstOrThrow) ||
                other.findFirstOrThrow == findFirstOrThrow) &&
            (identical(other.findMany, findMany) ||
                other.findMany == findMany) &&
            (identical(other.create, create) || other.create == create) &&
            (identical(other.createMany, createMany) ||
                other.createMany == createMany) &&
            (identical(other.update, update) || other.update == update) &&
            (identical(other.updateMany, updateMany) ||
                other.updateMany == updateMany) &&
            (identical(other.upsert, upsert) || other.upsert == upsert) &&
            (identical(other.delete, delete) || other.delete == delete) &&
            (identical(other.deleteMany, deleteMany) ||
                other.deleteMany == deleteMany) &&
            (identical(other.aggregate, aggregate) ||
                other.aggregate == aggregate) &&
            (identical(other.groupBy, groupBy) || other.groupBy == groupBy) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.findRaw, findRaw) || other.findRaw == findRaw) &&
            (identical(other.aggregateRaw, aggregateRaw) ||
                other.aggregateRaw == aggregateRaw));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
        plural,
        findUnique,
        findUniqueOrThrow,
        findFirst,
        findFirstOrThrow,
        findMany,
        create,
        createMany,
        update,
        updateMany,
        upsert,
        delete,
        deleteMany,
        aggregate,
        groupBy,
        count,
        findRaw,
        aggregateRaw
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelMappingImplCopyWith<_$ModelMappingImpl> get copyWith =>
      __$$ModelMappingImplCopyWithImpl<_$ModelMappingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModelMappingImplToJson(
      this,
    );
  }
}

abstract class _ModelMapping implements ModelMapping {
  const factory _ModelMapping(
      {required final String model,
      final String? plural,
      @JsonKey(readValue: _modelMappingActionValueReader)
      final String? findUnique,
      @JsonKey(readValue: _modelMappingActionValueReader)
      final String? findUniqueOrThrow,
      @JsonKey(readValue: _modelMappingActionValueReader)
      final String? findFirst,
      @JsonKey(readValue: _modelMappingActionValueReader)
      final String? findFirstOrThrow,
      @JsonKey(readValue: _modelMappingActionValueReader)
      final String? findMany,
      @JsonKey(readValue: _modelMappingActionValueReader) final String? create,
      @JsonKey(readValue: _modelMappingActionValueReader)
      final String? createMany,
      @JsonKey(readValue: _modelMappingActionValueReader) final String? update,
      @JsonKey(readValue: _modelMappingActionValueReader)
      final String? updateMany,
      @JsonKey(readValue: _modelMappingActionValueReader) final String? upsert,
      @JsonKey(readValue: _modelMappingActionValueReader) final String? delete,
      @JsonKey(readValue: _modelMappingActionValueReader)
      final String? deleteMany,
      @JsonKey(readValue: _modelMappingActionValueReader)
      final String? aggregate,
      @JsonKey(readValue: _modelMappingActionValueReader) final String? groupBy,
      @JsonKey(readValue: _modelMappingActionValueReader) final String? count,
      @JsonKey(readValue: _modelMappingActionValueReader) final String? findRaw,
      @JsonKey(readValue: _modelMappingActionValueReader)
      final String? aggregateRaw}) = _$ModelMappingImpl;

  factory _ModelMapping.fromJson(Map<String, dynamic> json) =
      _$ModelMappingImpl.fromJson;

  @override
  String get model;
  @override
  String? get plural;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findUnique;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findUniqueOrThrow;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findFirst;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findFirstOrThrow;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findMany;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get create;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get createMany;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get update;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get updateMany;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get upsert;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get delete;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get deleteMany;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get aggregate;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get groupBy;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get count;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get findRaw;
  @override
  @JsonKey(readValue: _modelMappingActionValueReader)
  String? get aggregateRaw;
  @override
  @JsonKey(ignore: true)
  _$$ModelMappingImplCopyWith<_$ModelMappingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
