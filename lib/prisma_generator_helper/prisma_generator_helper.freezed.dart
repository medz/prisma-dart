// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prisma_generator_helper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GeneratorManifest _$GeneratorManifestFromJson(Map<String, dynamic> json) {
  return _GeneratorManifest.fromJson(json);
}

/// @nodoc
mixin _$GeneratorManifest {
  String? get prettyName => throw _privateConstructorUsedError;
  String get defaultOutput => throw _privateConstructorUsedError;
  DenyLists? get denylists => throw _privateConstructorUsedError;
  List<String>? get requiresGenerators => throw _privateConstructorUsedError;
  List<EngineType>? get requiresEngines => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  String? get requiresEngineVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeneratorManifestCopyWith<GeneratorManifest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratorManifestCopyWith<$Res> {
  factory $GeneratorManifestCopyWith(
          GeneratorManifest value, $Res Function(GeneratorManifest) then) =
      _$GeneratorManifestCopyWithImpl<$Res, GeneratorManifest>;
  @useResult
  $Res call(
      {String? prettyName,
      String defaultOutput,
      DenyLists? denylists,
      List<String>? requiresGenerators,
      List<EngineType>? requiresEngines,
      String? version,
      String? requiresEngineVersion});

  $DenyListsCopyWith<$Res>? get denylists;
}

/// @nodoc
class _$GeneratorManifestCopyWithImpl<$Res, $Val extends GeneratorManifest>
    implements $GeneratorManifestCopyWith<$Res> {
  _$GeneratorManifestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prettyName = freezed,
    Object? defaultOutput = null,
    Object? denylists = freezed,
    Object? requiresGenerators = freezed,
    Object? requiresEngines = freezed,
    Object? version = freezed,
    Object? requiresEngineVersion = freezed,
  }) {
    return _then(_value.copyWith(
      prettyName: freezed == prettyName
          ? _value.prettyName
          : prettyName // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultOutput: null == defaultOutput
          ? _value.defaultOutput
          : defaultOutput // ignore: cast_nullable_to_non_nullable
              as String,
      denylists: freezed == denylists
          ? _value.denylists
          : denylists // ignore: cast_nullable_to_non_nullable
              as DenyLists?,
      requiresGenerators: freezed == requiresGenerators
          ? _value.requiresGenerators
          : requiresGenerators // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      requiresEngines: freezed == requiresEngines
          ? _value.requiresEngines
          : requiresEngines // ignore: cast_nullable_to_non_nullable
              as List<EngineType>?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      requiresEngineVersion: freezed == requiresEngineVersion
          ? _value.requiresEngineVersion
          : requiresEngineVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DenyListsCopyWith<$Res>? get denylists {
    if (_value.denylists == null) {
      return null;
    }

    return $DenyListsCopyWith<$Res>(_value.denylists!, (value) {
      return _then(_value.copyWith(denylists: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GeneratorManifestImplCopyWith<$Res>
    implements $GeneratorManifestCopyWith<$Res> {
  factory _$$GeneratorManifestImplCopyWith(_$GeneratorManifestImpl value,
          $Res Function(_$GeneratorManifestImpl) then) =
      __$$GeneratorManifestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? prettyName,
      String defaultOutput,
      DenyLists? denylists,
      List<String>? requiresGenerators,
      List<EngineType>? requiresEngines,
      String? version,
      String? requiresEngineVersion});

  @override
  $DenyListsCopyWith<$Res>? get denylists;
}

/// @nodoc
class __$$GeneratorManifestImplCopyWithImpl<$Res>
    extends _$GeneratorManifestCopyWithImpl<$Res, _$GeneratorManifestImpl>
    implements _$$GeneratorManifestImplCopyWith<$Res> {
  __$$GeneratorManifestImplCopyWithImpl(_$GeneratorManifestImpl _value,
      $Res Function(_$GeneratorManifestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prettyName = freezed,
    Object? defaultOutput = null,
    Object? denylists = freezed,
    Object? requiresGenerators = freezed,
    Object? requiresEngines = freezed,
    Object? version = freezed,
    Object? requiresEngineVersion = freezed,
  }) {
    return _then(_$GeneratorManifestImpl(
      prettyName: freezed == prettyName
          ? _value.prettyName
          : prettyName // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultOutput: null == defaultOutput
          ? _value.defaultOutput
          : defaultOutput // ignore: cast_nullable_to_non_nullable
              as String,
      denylists: freezed == denylists
          ? _value.denylists
          : denylists // ignore: cast_nullable_to_non_nullable
              as DenyLists?,
      requiresGenerators: freezed == requiresGenerators
          ? _value._requiresGenerators
          : requiresGenerators // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      requiresEngines: freezed == requiresEngines
          ? _value._requiresEngines
          : requiresEngines // ignore: cast_nullable_to_non_nullable
              as List<EngineType>?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      requiresEngineVersion: freezed == requiresEngineVersion
          ? _value.requiresEngineVersion
          : requiresEngineVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneratorManifestImpl implements _GeneratorManifest {
  const _$GeneratorManifestImpl(
      {this.prettyName,
      this.defaultOutput = '.',
      this.denylists,
      final List<String>? requiresGenerators,
      final List<EngineType>? requiresEngines,
      this.version,
      this.requiresEngineVersion})
      : _requiresGenerators = requiresGenerators,
        _requiresEngines = requiresEngines;

  factory _$GeneratorManifestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneratorManifestImplFromJson(json);

  @override
  final String? prettyName;
  @override
  @JsonKey()
  final String defaultOutput;
  @override
  final DenyLists? denylists;
  final List<String>? _requiresGenerators;
  @override
  List<String>? get requiresGenerators {
    final value = _requiresGenerators;
    if (value == null) return null;
    if (_requiresGenerators is EqualUnmodifiableListView)
      return _requiresGenerators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<EngineType>? _requiresEngines;
  @override
  List<EngineType>? get requiresEngines {
    final value = _requiresEngines;
    if (value == null) return null;
    if (_requiresEngines is EqualUnmodifiableListView) return _requiresEngines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? version;
  @override
  final String? requiresEngineVersion;

  @override
  String toString() {
    return 'GeneratorManifest(prettyName: $prettyName, defaultOutput: $defaultOutput, denylists: $denylists, requiresGenerators: $requiresGenerators, requiresEngines: $requiresEngines, version: $version, requiresEngineVersion: $requiresEngineVersion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratorManifestImpl &&
            (identical(other.prettyName, prettyName) ||
                other.prettyName == prettyName) &&
            (identical(other.defaultOutput, defaultOutput) ||
                other.defaultOutput == defaultOutput) &&
            (identical(other.denylists, denylists) ||
                other.denylists == denylists) &&
            const DeepCollectionEquality()
                .equals(other._requiresGenerators, _requiresGenerators) &&
            const DeepCollectionEquality()
                .equals(other._requiresEngines, _requiresEngines) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.requiresEngineVersion, requiresEngineVersion) ||
                other.requiresEngineVersion == requiresEngineVersion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      prettyName,
      defaultOutput,
      denylists,
      const DeepCollectionEquality().hash(_requiresGenerators),
      const DeepCollectionEquality().hash(_requiresEngines),
      version,
      requiresEngineVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratorManifestImplCopyWith<_$GeneratorManifestImpl> get copyWith =>
      __$$GeneratorManifestImplCopyWithImpl<_$GeneratorManifestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneratorManifestImplToJson(
      this,
    );
  }
}

abstract class _GeneratorManifest implements GeneratorManifest {
  const factory _GeneratorManifest(
      {final String? prettyName,
      final String defaultOutput,
      final DenyLists? denylists,
      final List<String>? requiresGenerators,
      final List<EngineType>? requiresEngines,
      final String? version,
      final String? requiresEngineVersion}) = _$GeneratorManifestImpl;

  factory _GeneratorManifest.fromJson(Map<String, dynamic> json) =
      _$GeneratorManifestImpl.fromJson;

  @override
  String? get prettyName;
  @override
  String get defaultOutput;
  @override
  DenyLists? get denylists;
  @override
  List<String>? get requiresGenerators;
  @override
  List<EngineType>? get requiresEngines;
  @override
  String? get version;
  @override
  String? get requiresEngineVersion;
  @override
  @JsonKey(ignore: true)
  _$$GeneratorManifestImplCopyWith<_$GeneratorManifestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DenyLists _$DenyListsFromJson(Map<String, dynamic> json) {
  return _DenyLists.fromJson(json);
}

/// @nodoc
mixin _$DenyLists {
  List<String>? get models => throw _privateConstructorUsedError;
  List<String>? get fields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DenyListsCopyWith<DenyLists> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DenyListsCopyWith<$Res> {
  factory $DenyListsCopyWith(DenyLists value, $Res Function(DenyLists) then) =
      _$DenyListsCopyWithImpl<$Res, DenyLists>;
  @useResult
  $Res call({List<String>? models, List<String>? fields});
}

/// @nodoc
class _$DenyListsCopyWithImpl<$Res, $Val extends DenyLists>
    implements $DenyListsCopyWith<$Res> {
  _$DenyListsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? models = freezed,
    Object? fields = freezed,
  }) {
    return _then(_value.copyWith(
      models: freezed == models
          ? _value.models
          : models // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      fields: freezed == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DenyListsImplCopyWith<$Res>
    implements $DenyListsCopyWith<$Res> {
  factory _$$DenyListsImplCopyWith(
          _$DenyListsImpl value, $Res Function(_$DenyListsImpl) then) =
      __$$DenyListsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? models, List<String>? fields});
}

/// @nodoc
class __$$DenyListsImplCopyWithImpl<$Res>
    extends _$DenyListsCopyWithImpl<$Res, _$DenyListsImpl>
    implements _$$DenyListsImplCopyWith<$Res> {
  __$$DenyListsImplCopyWithImpl(
      _$DenyListsImpl _value, $Res Function(_$DenyListsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? models = freezed,
    Object? fields = freezed,
  }) {
    return _then(_$DenyListsImpl(
      models: freezed == models
          ? _value._models
          : models // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      fields: freezed == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DenyListsImpl implements _DenyLists {
  const _$DenyListsImpl(
      {final List<String>? models, final List<String>? fields})
      : _models = models,
        _fields = fields;

  factory _$DenyListsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DenyListsImplFromJson(json);

  final List<String>? _models;
  @override
  List<String>? get models {
    final value = _models;
    if (value == null) return null;
    if (_models is EqualUnmodifiableListView) return _models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
    return 'DenyLists(models: $models, fields: $fields)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DenyListsImpl &&
            const DeepCollectionEquality().equals(other._models, _models) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_models),
      const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DenyListsImplCopyWith<_$DenyListsImpl> get copyWith =>
      __$$DenyListsImplCopyWithImpl<_$DenyListsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DenyListsImplToJson(
      this,
    );
  }
}

abstract class _DenyLists implements DenyLists {
  const factory _DenyLists(
      {final List<String>? models,
      final List<String>? fields}) = _$DenyListsImpl;

  factory _DenyLists.fromJson(Map<String, dynamic> json) =
      _$DenyListsImpl.fromJson;

  @override
  List<String>? get models;
  @override
  List<String>? get fields;
  @override
  @JsonKey(ignore: true)
  _$$DenyListsImplCopyWith<_$DenyListsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeneratorOptions _$GeneratorOptionsFromJson(Map<String, dynamic> json) {
  return _GeneratorOptions.fromJson(json);
}

/// @nodoc
mixin _$GeneratorOptions {
  GeneratorConfig get generator => throw _privateConstructorUsedError;
  List<GeneratorConfig>? get otherGenerators =>
      throw _privateConstructorUsedError;
  String get schemaPath => throw _privateConstructorUsedError;
  Document get dmmf => throw _privateConstructorUsedError;
  List<DataSource> get datasources => throw _privateConstructorUsedError;
  String get datamodel => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  BinaryPaths? get binaryPaths => throw _privateConstructorUsedError;
  bool get dataProxy => throw _privateConstructorUsedError;
  bool? get postinstall => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeneratorOptionsCopyWith<GeneratorOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratorOptionsCopyWith<$Res> {
  factory $GeneratorOptionsCopyWith(
          GeneratorOptions value, $Res Function(GeneratorOptions) then) =
      _$GeneratorOptionsCopyWithImpl<$Res, GeneratorOptions>;
  @useResult
  $Res call(
      {GeneratorConfig generator,
      List<GeneratorConfig>? otherGenerators,
      String schemaPath,
      Document dmmf,
      List<DataSource> datasources,
      String datamodel,
      String version,
      BinaryPaths? binaryPaths,
      bool dataProxy,
      bool? postinstall});

  $GeneratorConfigCopyWith<$Res> get generator;
  $DocumentCopyWith<$Res> get dmmf;
  $BinaryPathsCopyWith<$Res>? get binaryPaths;
}

/// @nodoc
class _$GeneratorOptionsCopyWithImpl<$Res, $Val extends GeneratorOptions>
    implements $GeneratorOptionsCopyWith<$Res> {
  _$GeneratorOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generator = null,
    Object? otherGenerators = freezed,
    Object? schemaPath = null,
    Object? dmmf = null,
    Object? datasources = null,
    Object? datamodel = null,
    Object? version = null,
    Object? binaryPaths = freezed,
    Object? dataProxy = null,
    Object? postinstall = freezed,
  }) {
    return _then(_value.copyWith(
      generator: null == generator
          ? _value.generator
          : generator // ignore: cast_nullable_to_non_nullable
              as GeneratorConfig,
      otherGenerators: freezed == otherGenerators
          ? _value.otherGenerators
          : otherGenerators // ignore: cast_nullable_to_non_nullable
              as List<GeneratorConfig>?,
      schemaPath: null == schemaPath
          ? _value.schemaPath
          : schemaPath // ignore: cast_nullable_to_non_nullable
              as String,
      dmmf: null == dmmf
          ? _value.dmmf
          : dmmf // ignore: cast_nullable_to_non_nullable
              as Document,
      datasources: null == datasources
          ? _value.datasources
          : datasources // ignore: cast_nullable_to_non_nullable
              as List<DataSource>,
      datamodel: null == datamodel
          ? _value.datamodel
          : datamodel // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      binaryPaths: freezed == binaryPaths
          ? _value.binaryPaths
          : binaryPaths // ignore: cast_nullable_to_non_nullable
              as BinaryPaths?,
      dataProxy: null == dataProxy
          ? _value.dataProxy
          : dataProxy // ignore: cast_nullable_to_non_nullable
              as bool,
      postinstall: freezed == postinstall
          ? _value.postinstall
          : postinstall // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeneratorConfigCopyWith<$Res> get generator {
    return $GeneratorConfigCopyWith<$Res>(_value.generator, (value) {
      return _then(_value.copyWith(generator: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DocumentCopyWith<$Res> get dmmf {
    return $DocumentCopyWith<$Res>(_value.dmmf, (value) {
      return _then(_value.copyWith(dmmf: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BinaryPathsCopyWith<$Res>? get binaryPaths {
    if (_value.binaryPaths == null) {
      return null;
    }

    return $BinaryPathsCopyWith<$Res>(_value.binaryPaths!, (value) {
      return _then(_value.copyWith(binaryPaths: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GeneratorOptionsImplCopyWith<$Res>
    implements $GeneratorOptionsCopyWith<$Res> {
  factory _$$GeneratorOptionsImplCopyWith(_$GeneratorOptionsImpl value,
          $Res Function(_$GeneratorOptionsImpl) then) =
      __$$GeneratorOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GeneratorConfig generator,
      List<GeneratorConfig>? otherGenerators,
      String schemaPath,
      Document dmmf,
      List<DataSource> datasources,
      String datamodel,
      String version,
      BinaryPaths? binaryPaths,
      bool dataProxy,
      bool? postinstall});

  @override
  $GeneratorConfigCopyWith<$Res> get generator;
  @override
  $DocumentCopyWith<$Res> get dmmf;
  @override
  $BinaryPathsCopyWith<$Res>? get binaryPaths;
}

/// @nodoc
class __$$GeneratorOptionsImplCopyWithImpl<$Res>
    extends _$GeneratorOptionsCopyWithImpl<$Res, _$GeneratorOptionsImpl>
    implements _$$GeneratorOptionsImplCopyWith<$Res> {
  __$$GeneratorOptionsImplCopyWithImpl(_$GeneratorOptionsImpl _value,
      $Res Function(_$GeneratorOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generator = null,
    Object? otherGenerators = freezed,
    Object? schemaPath = null,
    Object? dmmf = null,
    Object? datasources = null,
    Object? datamodel = null,
    Object? version = null,
    Object? binaryPaths = freezed,
    Object? dataProxy = null,
    Object? postinstall = freezed,
  }) {
    return _then(_$GeneratorOptionsImpl(
      generator: null == generator
          ? _value.generator
          : generator // ignore: cast_nullable_to_non_nullable
              as GeneratorConfig,
      otherGenerators: freezed == otherGenerators
          ? _value._otherGenerators
          : otherGenerators // ignore: cast_nullable_to_non_nullable
              as List<GeneratorConfig>?,
      schemaPath: null == schemaPath
          ? _value.schemaPath
          : schemaPath // ignore: cast_nullable_to_non_nullable
              as String,
      dmmf: null == dmmf
          ? _value.dmmf
          : dmmf // ignore: cast_nullable_to_non_nullable
              as Document,
      datasources: null == datasources
          ? _value._datasources
          : datasources // ignore: cast_nullable_to_non_nullable
              as List<DataSource>,
      datamodel: null == datamodel
          ? _value.datamodel
          : datamodel // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      binaryPaths: freezed == binaryPaths
          ? _value.binaryPaths
          : binaryPaths // ignore: cast_nullable_to_non_nullable
              as BinaryPaths?,
      dataProxy: null == dataProxy
          ? _value.dataProxy
          : dataProxy // ignore: cast_nullable_to_non_nullable
              as bool,
      postinstall: freezed == postinstall
          ? _value.postinstall
          : postinstall // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneratorOptionsImpl implements _GeneratorOptions {
  const _$GeneratorOptionsImpl(
      {required this.generator,
      final List<GeneratorConfig>? otherGenerators,
      required this.schemaPath,
      required this.dmmf,
      required final List<DataSource> datasources,
      required this.datamodel,
      required this.version,
      this.binaryPaths,
      this.dataProxy = false,
      this.postinstall})
      : _otherGenerators = otherGenerators,
        _datasources = datasources;

  factory _$GeneratorOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneratorOptionsImplFromJson(json);

  @override
  final GeneratorConfig generator;
  final List<GeneratorConfig>? _otherGenerators;
  @override
  List<GeneratorConfig>? get otherGenerators {
    final value = _otherGenerators;
    if (value == null) return null;
    if (_otherGenerators is EqualUnmodifiableListView) return _otherGenerators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String schemaPath;
  @override
  final Document dmmf;
  final List<DataSource> _datasources;
  @override
  List<DataSource> get datasources {
    if (_datasources is EqualUnmodifiableListView) return _datasources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_datasources);
  }

  @override
  final String datamodel;
  @override
  final String version;
  @override
  final BinaryPaths? binaryPaths;
  @override
  @JsonKey()
  final bool dataProxy;
  @override
  final bool? postinstall;

  @override
  String toString() {
    return 'GeneratorOptions(generator: $generator, otherGenerators: $otherGenerators, schemaPath: $schemaPath, dmmf: $dmmf, datasources: $datasources, datamodel: $datamodel, version: $version, binaryPaths: $binaryPaths, dataProxy: $dataProxy, postinstall: $postinstall)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratorOptionsImpl &&
            (identical(other.generator, generator) ||
                other.generator == generator) &&
            const DeepCollectionEquality()
                .equals(other._otherGenerators, _otherGenerators) &&
            (identical(other.schemaPath, schemaPath) ||
                other.schemaPath == schemaPath) &&
            (identical(other.dmmf, dmmf) || other.dmmf == dmmf) &&
            const DeepCollectionEquality()
                .equals(other._datasources, _datasources) &&
            (identical(other.datamodel, datamodel) ||
                other.datamodel == datamodel) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.binaryPaths, binaryPaths) ||
                other.binaryPaths == binaryPaths) &&
            (identical(other.dataProxy, dataProxy) ||
                other.dataProxy == dataProxy) &&
            (identical(other.postinstall, postinstall) ||
                other.postinstall == postinstall));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      generator,
      const DeepCollectionEquality().hash(_otherGenerators),
      schemaPath,
      dmmf,
      const DeepCollectionEquality().hash(_datasources),
      datamodel,
      version,
      binaryPaths,
      dataProxy,
      postinstall);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratorOptionsImplCopyWith<_$GeneratorOptionsImpl> get copyWith =>
      __$$GeneratorOptionsImplCopyWithImpl<_$GeneratorOptionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneratorOptionsImplToJson(
      this,
    );
  }
}

abstract class _GeneratorOptions implements GeneratorOptions {
  const factory _GeneratorOptions(
      {required final GeneratorConfig generator,
      final List<GeneratorConfig>? otherGenerators,
      required final String schemaPath,
      required final Document dmmf,
      required final List<DataSource> datasources,
      required final String datamodel,
      required final String version,
      final BinaryPaths? binaryPaths,
      final bool dataProxy,
      final bool? postinstall}) = _$GeneratorOptionsImpl;

  factory _GeneratorOptions.fromJson(Map<String, dynamic> json) =
      _$GeneratorOptionsImpl.fromJson;

  @override
  GeneratorConfig get generator;
  @override
  List<GeneratorConfig>? get otherGenerators;
  @override
  String get schemaPath;
  @override
  Document get dmmf;
  @override
  List<DataSource> get datasources;
  @override
  String get datamodel;
  @override
  String get version;
  @override
  BinaryPaths? get binaryPaths;
  @override
  bool get dataProxy;
  @override
  bool? get postinstall;
  @override
  @JsonKey(ignore: true)
  _$$GeneratorOptionsImplCopyWith<_$GeneratorOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeneratorConfig _$GeneratorConfigFromJson(Map<String, dynamic> json) {
  return _GeneratorConfig.fromJson(json);
}

/// @nodoc
mixin _$GeneratorConfig {
  String get name => throw _privateConstructorUsedError;
  @_EnvValueConverter()
  EnvValue? get output => throw _privateConstructorUsedError;
  bool? get isCustomOutput => throw _privateConstructorUsedError;
  @_EnvValueConverter()
  EnvValue get provider => throw _privateConstructorUsedError;
  Map<String, String> get config => throw _privateConstructorUsedError;
  List<BinaryTargetsEnvValue> get binaryTargets =>
      throw _privateConstructorUsedError;
  List<String> get previewFeatures => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeneratorConfigCopyWith<GeneratorConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratorConfigCopyWith<$Res> {
  factory $GeneratorConfigCopyWith(
          GeneratorConfig value, $Res Function(GeneratorConfig) then) =
      _$GeneratorConfigCopyWithImpl<$Res, GeneratorConfig>;
  @useResult
  $Res call(
      {String name,
      @_EnvValueConverter() EnvValue? output,
      bool? isCustomOutput,
      @_EnvValueConverter() EnvValue provider,
      Map<String, String> config,
      List<BinaryTargetsEnvValue> binaryTargets,
      List<String> previewFeatures});

  $EnvValueCopyWith<$Res>? get output;
  $EnvValueCopyWith<$Res> get provider;
}

/// @nodoc
class _$GeneratorConfigCopyWithImpl<$Res, $Val extends GeneratorConfig>
    implements $GeneratorConfigCopyWith<$Res> {
  _$GeneratorConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? output = freezed,
    Object? isCustomOutput = freezed,
    Object? provider = null,
    Object? config = null,
    Object? binaryTargets = null,
    Object? previewFeatures = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      output: freezed == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as EnvValue?,
      isCustomOutput: freezed == isCustomOutput
          ? _value.isCustomOutput
          : isCustomOutput // ignore: cast_nullable_to_non_nullable
              as bool?,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as EnvValue,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      binaryTargets: null == binaryTargets
          ? _value.binaryTargets
          : binaryTargets // ignore: cast_nullable_to_non_nullable
              as List<BinaryTargetsEnvValue>,
      previewFeatures: null == previewFeatures
          ? _value.previewFeatures
          : previewFeatures // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EnvValueCopyWith<$Res>? get output {
    if (_value.output == null) {
      return null;
    }

    return $EnvValueCopyWith<$Res>(_value.output!, (value) {
      return _then(_value.copyWith(output: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EnvValueCopyWith<$Res> get provider {
    return $EnvValueCopyWith<$Res>(_value.provider, (value) {
      return _then(_value.copyWith(provider: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GeneratorConfigImplCopyWith<$Res>
    implements $GeneratorConfigCopyWith<$Res> {
  factory _$$GeneratorConfigImplCopyWith(_$GeneratorConfigImpl value,
          $Res Function(_$GeneratorConfigImpl) then) =
      __$$GeneratorConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @_EnvValueConverter() EnvValue? output,
      bool? isCustomOutput,
      @_EnvValueConverter() EnvValue provider,
      Map<String, String> config,
      List<BinaryTargetsEnvValue> binaryTargets,
      List<String> previewFeatures});

  @override
  $EnvValueCopyWith<$Res>? get output;
  @override
  $EnvValueCopyWith<$Res> get provider;
}

/// @nodoc
class __$$GeneratorConfigImplCopyWithImpl<$Res>
    extends _$GeneratorConfigCopyWithImpl<$Res, _$GeneratorConfigImpl>
    implements _$$GeneratorConfigImplCopyWith<$Res> {
  __$$GeneratorConfigImplCopyWithImpl(
      _$GeneratorConfigImpl _value, $Res Function(_$GeneratorConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? output = freezed,
    Object? isCustomOutput = freezed,
    Object? provider = null,
    Object? config = null,
    Object? binaryTargets = null,
    Object? previewFeatures = null,
  }) {
    return _then(_$GeneratorConfigImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      output: freezed == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as EnvValue?,
      isCustomOutput: freezed == isCustomOutput
          ? _value.isCustomOutput
          : isCustomOutput // ignore: cast_nullable_to_non_nullable
              as bool?,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as EnvValue,
      config: null == config
          ? _value._config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      binaryTargets: null == binaryTargets
          ? _value._binaryTargets
          : binaryTargets // ignore: cast_nullable_to_non_nullable
              as List<BinaryTargetsEnvValue>,
      previewFeatures: null == previewFeatures
          ? _value._previewFeatures
          : previewFeatures // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneratorConfigImpl implements _GeneratorConfig {
  const _$GeneratorConfigImpl(
      {required this.name,
      @_EnvValueConverter() this.output,
      this.isCustomOutput,
      @_EnvValueConverter() required this.provider,
      required final Map<String, String> config,
      required final List<BinaryTargetsEnvValue> binaryTargets,
      required final List<String> previewFeatures})
      : _config = config,
        _binaryTargets = binaryTargets,
        _previewFeatures = previewFeatures;

  factory _$GeneratorConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneratorConfigImplFromJson(json);

  @override
  final String name;
  @override
  @_EnvValueConverter()
  final EnvValue? output;
  @override
  final bool? isCustomOutput;
  @override
  @_EnvValueConverter()
  final EnvValue provider;
  final Map<String, String> _config;
  @override
  Map<String, String> get config {
    if (_config is EqualUnmodifiableMapView) return _config;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_config);
  }

  final List<BinaryTargetsEnvValue> _binaryTargets;
  @override
  List<BinaryTargetsEnvValue> get binaryTargets {
    if (_binaryTargets is EqualUnmodifiableListView) return _binaryTargets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_binaryTargets);
  }

  final List<String> _previewFeatures;
  @override
  List<String> get previewFeatures {
    if (_previewFeatures is EqualUnmodifiableListView) return _previewFeatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previewFeatures);
  }

  @override
  String toString() {
    return 'GeneratorConfig(name: $name, output: $output, isCustomOutput: $isCustomOutput, provider: $provider, config: $config, binaryTargets: $binaryTargets, previewFeatures: $previewFeatures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratorConfigImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.output, output) || other.output == output) &&
            (identical(other.isCustomOutput, isCustomOutput) ||
                other.isCustomOutput == isCustomOutput) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            const DeepCollectionEquality().equals(other._config, _config) &&
            const DeepCollectionEquality()
                .equals(other._binaryTargets, _binaryTargets) &&
            const DeepCollectionEquality()
                .equals(other._previewFeatures, _previewFeatures));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      output,
      isCustomOutput,
      provider,
      const DeepCollectionEquality().hash(_config),
      const DeepCollectionEquality().hash(_binaryTargets),
      const DeepCollectionEquality().hash(_previewFeatures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratorConfigImplCopyWith<_$GeneratorConfigImpl> get copyWith =>
      __$$GeneratorConfigImplCopyWithImpl<_$GeneratorConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneratorConfigImplToJson(
      this,
    );
  }
}

abstract class _GeneratorConfig implements GeneratorConfig {
  const factory _GeneratorConfig(
      {required final String name,
      @_EnvValueConverter() final EnvValue? output,
      final bool? isCustomOutput,
      @_EnvValueConverter() required final EnvValue provider,
      required final Map<String, String> config,
      required final List<BinaryTargetsEnvValue> binaryTargets,
      required final List<String> previewFeatures}) = _$GeneratorConfigImpl;

  factory _GeneratorConfig.fromJson(Map<String, dynamic> json) =
      _$GeneratorConfigImpl.fromJson;

  @override
  String get name;
  @override
  @_EnvValueConverter()
  EnvValue? get output;
  @override
  bool? get isCustomOutput;
  @override
  @_EnvValueConverter()
  EnvValue get provider;
  @override
  Map<String, String> get config;
  @override
  List<BinaryTargetsEnvValue> get binaryTargets;
  @override
  List<String> get previewFeatures;
  @override
  @JsonKey(ignore: true)
  _$$GeneratorConfigImplCopyWith<_$GeneratorConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EnvValue _$EnvValueFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'env':
      return EnvValueViaName.fromJson(json);
    case 'value':
      return EnvValueViaValue.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'EnvValue',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$EnvValue {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) env,
    required TResult Function(String value) value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? env,
    TResult? Function(String value)? value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? env,
    TResult Function(String value)? value,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnvValueViaName value) env,
    required TResult Function(EnvValueViaValue value) value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnvValueViaName value)? env,
    TResult? Function(EnvValueViaValue value)? value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnvValueViaName value)? env,
    TResult Function(EnvValueViaValue value)? value,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnvValueCopyWith<$Res> {
  factory $EnvValueCopyWith(EnvValue value, $Res Function(EnvValue) then) =
      _$EnvValueCopyWithImpl<$Res, EnvValue>;
}

/// @nodoc
class _$EnvValueCopyWithImpl<$Res, $Val extends EnvValue>
    implements $EnvValueCopyWith<$Res> {
  _$EnvValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EnvValueViaNameImplCopyWith<$Res> {
  factory _$$EnvValueViaNameImplCopyWith(_$EnvValueViaNameImpl value,
          $Res Function(_$EnvValueViaNameImpl) then) =
      __$$EnvValueViaNameImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$EnvValueViaNameImplCopyWithImpl<$Res>
    extends _$EnvValueCopyWithImpl<$Res, _$EnvValueViaNameImpl>
    implements _$$EnvValueViaNameImplCopyWith<$Res> {
  __$$EnvValueViaNameImplCopyWithImpl(
      _$EnvValueViaNameImpl _value, $Res Function(_$EnvValueViaNameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$EnvValueViaNameImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnvValueViaNameImpl implements EnvValueViaName {
  const _$EnvValueViaNameImpl(this.name, {final String? $type})
      : $type = $type ?? 'env';

  factory _$EnvValueViaNameImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnvValueViaNameImplFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'EnvValue.env(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnvValueViaNameImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EnvValueViaNameImplCopyWith<_$EnvValueViaNameImpl> get copyWith =>
      __$$EnvValueViaNameImplCopyWithImpl<_$EnvValueViaNameImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) env,
    required TResult Function(String value) value,
  }) {
    return env(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? env,
    TResult? Function(String value)? value,
  }) {
    return env?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? env,
    TResult Function(String value)? value,
    required TResult orElse(),
  }) {
    if (env != null) {
      return env(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnvValueViaName value) env,
    required TResult Function(EnvValueViaValue value) value,
  }) {
    return env(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnvValueViaName value)? env,
    TResult? Function(EnvValueViaValue value)? value,
  }) {
    return env?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnvValueViaName value)? env,
    TResult Function(EnvValueViaValue value)? value,
    required TResult orElse(),
  }) {
    if (env != null) {
      return env(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EnvValueViaNameImplToJson(
      this,
    );
  }
}

abstract class EnvValueViaName implements EnvValue {
  const factory EnvValueViaName(final String name) = _$EnvValueViaNameImpl;

  factory EnvValueViaName.fromJson(Map<String, dynamic> json) =
      _$EnvValueViaNameImpl.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$EnvValueViaNameImplCopyWith<_$EnvValueViaNameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EnvValueViaValueImplCopyWith<$Res> {
  factory _$$EnvValueViaValueImplCopyWith(_$EnvValueViaValueImpl value,
          $Res Function(_$EnvValueViaValueImpl) then) =
      __$$EnvValueViaValueImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$EnvValueViaValueImplCopyWithImpl<$Res>
    extends _$EnvValueCopyWithImpl<$Res, _$EnvValueViaValueImpl>
    implements _$$EnvValueViaValueImplCopyWith<$Res> {
  __$$EnvValueViaValueImplCopyWithImpl(_$EnvValueViaValueImpl _value,
      $Res Function(_$EnvValueViaValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$EnvValueViaValueImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnvValueViaValueImpl implements EnvValueViaValue {
  const _$EnvValueViaValueImpl(this.value, {final String? $type})
      : $type = $type ?? 'value';

  factory _$EnvValueViaValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnvValueViaValueImplFromJson(json);

  @override
  final String value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'EnvValue.value(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnvValueViaValueImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EnvValueViaValueImplCopyWith<_$EnvValueViaValueImpl> get copyWith =>
      __$$EnvValueViaValueImplCopyWithImpl<_$EnvValueViaValueImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) env,
    required TResult Function(String value) value,
  }) {
    return value(this.value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? env,
    TResult? Function(String value)? value,
  }) {
    return value?.call(this.value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? env,
    TResult Function(String value)? value,
    required TResult orElse(),
  }) {
    if (value != null) {
      return value(this.value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnvValueViaName value) env,
    required TResult Function(EnvValueViaValue value) value,
  }) {
    return value(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnvValueViaName value)? env,
    TResult? Function(EnvValueViaValue value)? value,
  }) {
    return value?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnvValueViaName value)? env,
    TResult Function(EnvValueViaValue value)? value,
    required TResult orElse(),
  }) {
    if (value != null) {
      return value(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EnvValueViaValueImplToJson(
      this,
    );
  }
}

abstract class EnvValueViaValue implements EnvValue {
  const factory EnvValueViaValue(final String value) = _$EnvValueViaValueImpl;

  factory EnvValueViaValue.fromJson(Map<String, dynamic> json) =
      _$EnvValueViaValueImpl.fromJson;

  String get value;
  @JsonKey(ignore: true)
  _$$EnvValueViaValueImplCopyWith<_$EnvValueViaValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BinaryTargetsEnvValue _$BinaryTargetsEnvValueFromJson(
    Map<String, dynamic> json) {
  return _BinaryTargetsEnvValue.fromJson(json);
}

/// @nodoc
mixin _$BinaryTargetsEnvValue {
  String? get fromEnvVar => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  bool? get native => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BinaryTargetsEnvValueCopyWith<BinaryTargetsEnvValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BinaryTargetsEnvValueCopyWith<$Res> {
  factory $BinaryTargetsEnvValueCopyWith(BinaryTargetsEnvValue value,
          $Res Function(BinaryTargetsEnvValue) then) =
      _$BinaryTargetsEnvValueCopyWithImpl<$Res, BinaryTargetsEnvValue>;
  @useResult
  $Res call({String? fromEnvVar, String value, bool? native});
}

/// @nodoc
class _$BinaryTargetsEnvValueCopyWithImpl<$Res,
        $Val extends BinaryTargetsEnvValue>
    implements $BinaryTargetsEnvValueCopyWith<$Res> {
  _$BinaryTargetsEnvValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromEnvVar = freezed,
    Object? value = null,
    Object? native = freezed,
  }) {
    return _then(_value.copyWith(
      fromEnvVar: freezed == fromEnvVar
          ? _value.fromEnvVar
          : fromEnvVar // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      native: freezed == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BinaryTargetsEnvValueImplCopyWith<$Res>
    implements $BinaryTargetsEnvValueCopyWith<$Res> {
  factory _$$BinaryTargetsEnvValueImplCopyWith(
          _$BinaryTargetsEnvValueImpl value,
          $Res Function(_$BinaryTargetsEnvValueImpl) then) =
      __$$BinaryTargetsEnvValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? fromEnvVar, String value, bool? native});
}

/// @nodoc
class __$$BinaryTargetsEnvValueImplCopyWithImpl<$Res>
    extends _$BinaryTargetsEnvValueCopyWithImpl<$Res,
        _$BinaryTargetsEnvValueImpl>
    implements _$$BinaryTargetsEnvValueImplCopyWith<$Res> {
  __$$BinaryTargetsEnvValueImplCopyWithImpl(_$BinaryTargetsEnvValueImpl _value,
      $Res Function(_$BinaryTargetsEnvValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromEnvVar = freezed,
    Object? value = null,
    Object? native = freezed,
  }) {
    return _then(_$BinaryTargetsEnvValueImpl(
      fromEnvVar: freezed == fromEnvVar
          ? _value.fromEnvVar
          : fromEnvVar // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      native: freezed == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BinaryTargetsEnvValueImpl implements _BinaryTargetsEnvValue {
  const _$BinaryTargetsEnvValueImpl(
      {this.fromEnvVar, required this.value, this.native});

  factory _$BinaryTargetsEnvValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$BinaryTargetsEnvValueImplFromJson(json);

  @override
  final String? fromEnvVar;
  @override
  final String value;
  @override
  final bool? native;

  @override
  String toString() {
    return 'BinaryTargetsEnvValue(fromEnvVar: $fromEnvVar, value: $value, native: $native)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BinaryTargetsEnvValueImpl &&
            (identical(other.fromEnvVar, fromEnvVar) ||
                other.fromEnvVar == fromEnvVar) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.native, native) || other.native == native));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fromEnvVar, value, native);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BinaryTargetsEnvValueImplCopyWith<_$BinaryTargetsEnvValueImpl>
      get copyWith => __$$BinaryTargetsEnvValueImplCopyWithImpl<
          _$BinaryTargetsEnvValueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BinaryTargetsEnvValueImplToJson(
      this,
    );
  }
}

abstract class _BinaryTargetsEnvValue implements BinaryTargetsEnvValue {
  const factory _BinaryTargetsEnvValue(
      {final String? fromEnvVar,
      required final String value,
      final bool? native}) = _$BinaryTargetsEnvValueImpl;

  factory _BinaryTargetsEnvValue.fromJson(Map<String, dynamic> json) =
      _$BinaryTargetsEnvValueImpl.fromJson;

  @override
  String? get fromEnvVar;
  @override
  String get value;
  @override
  bool? get native;
  @override
  @JsonKey(ignore: true)
  _$$BinaryTargetsEnvValueImplCopyWith<_$BinaryTargetsEnvValueImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DataSource _$DataSourceFromJson(Map<String, dynamic> json) {
  return _DataSource.fromJson(json);
}

/// @nodoc
mixin _$DataSource {
  String get name => throw _privateConstructorUsedError;
  ConnectorType get provider => throw _privateConstructorUsedError;
  ConnectorType get activeProvider => throw _privateConstructorUsedError;
  @_EnvValueConverter()
  EnvValue get url => throw _privateConstructorUsedError;
  @_EnvValueConverter()
  EnvValue? get directUrl => throw _privateConstructorUsedError;
  List<String> get schemas => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataSourceCopyWith<DataSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSourceCopyWith<$Res> {
  factory $DataSourceCopyWith(
          DataSource value, $Res Function(DataSource) then) =
      _$DataSourceCopyWithImpl<$Res, DataSource>;
  @useResult
  $Res call(
      {String name,
      ConnectorType provider,
      ConnectorType activeProvider,
      @_EnvValueConverter() EnvValue url,
      @_EnvValueConverter() EnvValue? directUrl,
      List<String> schemas});

  $EnvValueCopyWith<$Res> get url;
  $EnvValueCopyWith<$Res>? get directUrl;
}

/// @nodoc
class _$DataSourceCopyWithImpl<$Res, $Val extends DataSource>
    implements $DataSourceCopyWith<$Res> {
  _$DataSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? provider = null,
    Object? activeProvider = null,
    Object? url = null,
    Object? directUrl = freezed,
    Object? schemas = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as ConnectorType,
      activeProvider: null == activeProvider
          ? _value.activeProvider
          : activeProvider // ignore: cast_nullable_to_non_nullable
              as ConnectorType,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as EnvValue,
      directUrl: freezed == directUrl
          ? _value.directUrl
          : directUrl // ignore: cast_nullable_to_non_nullable
              as EnvValue?,
      schemas: null == schemas
          ? _value.schemas
          : schemas // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EnvValueCopyWith<$Res> get url {
    return $EnvValueCopyWith<$Res>(_value.url, (value) {
      return _then(_value.copyWith(url: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EnvValueCopyWith<$Res>? get directUrl {
    if (_value.directUrl == null) {
      return null;
    }

    return $EnvValueCopyWith<$Res>(_value.directUrl!, (value) {
      return _then(_value.copyWith(directUrl: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DataSourceImplCopyWith<$Res>
    implements $DataSourceCopyWith<$Res> {
  factory _$$DataSourceImplCopyWith(
          _$DataSourceImpl value, $Res Function(_$DataSourceImpl) then) =
      __$$DataSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      ConnectorType provider,
      ConnectorType activeProvider,
      @_EnvValueConverter() EnvValue url,
      @_EnvValueConverter() EnvValue? directUrl,
      List<String> schemas});

  @override
  $EnvValueCopyWith<$Res> get url;
  @override
  $EnvValueCopyWith<$Res>? get directUrl;
}

/// @nodoc
class __$$DataSourceImplCopyWithImpl<$Res>
    extends _$DataSourceCopyWithImpl<$Res, _$DataSourceImpl>
    implements _$$DataSourceImplCopyWith<$Res> {
  __$$DataSourceImplCopyWithImpl(
      _$DataSourceImpl _value, $Res Function(_$DataSourceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? provider = null,
    Object? activeProvider = null,
    Object? url = null,
    Object? directUrl = freezed,
    Object? schemas = null,
  }) {
    return _then(_$DataSourceImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as ConnectorType,
      activeProvider: null == activeProvider
          ? _value.activeProvider
          : activeProvider // ignore: cast_nullable_to_non_nullable
              as ConnectorType,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as EnvValue,
      directUrl: freezed == directUrl
          ? _value.directUrl
          : directUrl // ignore: cast_nullable_to_non_nullable
              as EnvValue?,
      schemas: null == schemas
          ? _value._schemas
          : schemas // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataSourceImpl implements _DataSource {
  const _$DataSourceImpl(
      {required this.name,
      required this.provider,
      required this.activeProvider,
      @_EnvValueConverter() required this.url,
      @_EnvValueConverter() this.directUrl,
      required final List<String> schemas})
      : _schemas = schemas;

  factory _$DataSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataSourceImplFromJson(json);

  @override
  final String name;
  @override
  final ConnectorType provider;
  @override
  final ConnectorType activeProvider;
  @override
  @_EnvValueConverter()
  final EnvValue url;
  @override
  @_EnvValueConverter()
  final EnvValue? directUrl;
  final List<String> _schemas;
  @override
  List<String> get schemas {
    if (_schemas is EqualUnmodifiableListView) return _schemas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_schemas);
  }

  @override
  String toString() {
    return 'DataSource(name: $name, provider: $provider, activeProvider: $activeProvider, url: $url, directUrl: $directUrl, schemas: $schemas)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataSourceImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.activeProvider, activeProvider) ||
                other.activeProvider == activeProvider) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.directUrl, directUrl) ||
                other.directUrl == directUrl) &&
            const DeepCollectionEquality().equals(other._schemas, _schemas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, provider, activeProvider,
      url, directUrl, const DeepCollectionEquality().hash(_schemas));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataSourceImplCopyWith<_$DataSourceImpl> get copyWith =>
      __$$DataSourceImplCopyWithImpl<_$DataSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataSourceImplToJson(
      this,
    );
  }
}

abstract class _DataSource implements DataSource {
  const factory _DataSource(
      {required final String name,
      required final ConnectorType provider,
      required final ConnectorType activeProvider,
      @_EnvValueConverter() required final EnvValue url,
      @_EnvValueConverter() final EnvValue? directUrl,
      required final List<String> schemas}) = _$DataSourceImpl;

  factory _DataSource.fromJson(Map<String, dynamic> json) =
      _$DataSourceImpl.fromJson;

  @override
  String get name;
  @override
  ConnectorType get provider;
  @override
  ConnectorType get activeProvider;
  @override
  @_EnvValueConverter()
  EnvValue get url;
  @override
  @_EnvValueConverter()
  EnvValue? get directUrl;
  @override
  List<String> get schemas;
  @override
  @JsonKey(ignore: true)
  _$$DataSourceImplCopyWith<_$DataSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BinaryPaths _$BinaryPathsFromJson(Map<String, dynamic> json) {
  return _BinaryPaths.fromJson(json);
}

/// @nodoc
mixin _$BinaryPaths {
  Map<String, String>? get migrationEngine =>
      throw _privateConstructorUsedError;
  Map<String, String>? get queryEngine => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BinaryPathsCopyWith<BinaryPaths> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BinaryPathsCopyWith<$Res> {
  factory $BinaryPathsCopyWith(
          BinaryPaths value, $Res Function(BinaryPaths) then) =
      _$BinaryPathsCopyWithImpl<$Res, BinaryPaths>;
  @useResult
  $Res call(
      {Map<String, String>? migrationEngine, Map<String, String>? queryEngine});
}

/// @nodoc
class _$BinaryPathsCopyWithImpl<$Res, $Val extends BinaryPaths>
    implements $BinaryPathsCopyWith<$Res> {
  _$BinaryPathsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? migrationEngine = freezed,
    Object? queryEngine = freezed,
  }) {
    return _then(_value.copyWith(
      migrationEngine: freezed == migrationEngine
          ? _value.migrationEngine
          : migrationEngine // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      queryEngine: freezed == queryEngine
          ? _value.queryEngine
          : queryEngine // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BinaryPathsImplCopyWith<$Res>
    implements $BinaryPathsCopyWith<$Res> {
  factory _$$BinaryPathsImplCopyWith(
          _$BinaryPathsImpl value, $Res Function(_$BinaryPathsImpl) then) =
      __$$BinaryPathsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, String>? migrationEngine, Map<String, String>? queryEngine});
}

/// @nodoc
class __$$BinaryPathsImplCopyWithImpl<$Res>
    extends _$BinaryPathsCopyWithImpl<$Res, _$BinaryPathsImpl>
    implements _$$BinaryPathsImplCopyWith<$Res> {
  __$$BinaryPathsImplCopyWithImpl(
      _$BinaryPathsImpl _value, $Res Function(_$BinaryPathsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? migrationEngine = freezed,
    Object? queryEngine = freezed,
  }) {
    return _then(_$BinaryPathsImpl(
      migrationEngine: freezed == migrationEngine
          ? _value._migrationEngine
          : migrationEngine // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      queryEngine: freezed == queryEngine
          ? _value._queryEngine
          : queryEngine // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BinaryPathsImpl implements _BinaryPaths {
  const _$BinaryPathsImpl(
      {final Map<String, String>? migrationEngine,
      final Map<String, String>? queryEngine})
      : _migrationEngine = migrationEngine,
        _queryEngine = queryEngine;

  factory _$BinaryPathsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BinaryPathsImplFromJson(json);

  final Map<String, String>? _migrationEngine;
  @override
  Map<String, String>? get migrationEngine {
    final value = _migrationEngine;
    if (value == null) return null;
    if (_migrationEngine is EqualUnmodifiableMapView) return _migrationEngine;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, String>? _queryEngine;
  @override
  Map<String, String>? get queryEngine {
    final value = _queryEngine;
    if (value == null) return null;
    if (_queryEngine is EqualUnmodifiableMapView) return _queryEngine;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BinaryPaths(migrationEngine: $migrationEngine, queryEngine: $queryEngine)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BinaryPathsImpl &&
            const DeepCollectionEquality()
                .equals(other._migrationEngine, _migrationEngine) &&
            const DeepCollectionEquality()
                .equals(other._queryEngine, _queryEngine));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_migrationEngine),
      const DeepCollectionEquality().hash(_queryEngine));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BinaryPathsImplCopyWith<_$BinaryPathsImpl> get copyWith =>
      __$$BinaryPathsImplCopyWithImpl<_$BinaryPathsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BinaryPathsImplToJson(
      this,
    );
  }
}

abstract class _BinaryPaths implements BinaryPaths {
  const factory _BinaryPaths(
      {final Map<String, String>? migrationEngine,
      final Map<String, String>? queryEngine}) = _$BinaryPathsImpl;

  factory _BinaryPaths.fromJson(Map<String, dynamic> json) =
      _$BinaryPathsImpl.fromJson;

  @override
  Map<String, String>? get migrationEngine;
  @override
  Map<String, String>? get queryEngine;
  @override
  @JsonKey(ignore: true)
  _$$BinaryPathsImplCopyWith<_$BinaryPathsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
