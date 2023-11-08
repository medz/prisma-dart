// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnvValue _$EnvValueFromJson(Map json) => $checkedCreate(
      'EnvValue',
      json,
      ($checkedConvert) {
        final val = EnvValue(
          formEnvVar: $checkedConvert('formEnvVar', (v) => v as String?),
          value: $checkedConvert('value', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$EnvValueToJson(EnvValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('formEnvVar', instance.formEnvVar);
  writeNotNull('value', instance.value);
  return val;
}

BinaryTargetsEnvValue _$BinaryTargetsEnvValueFromJson(Map json) =>
    $checkedCreate(
      'BinaryTargetsEnvValue',
      json,
      ($checkedConvert) {
        final val = BinaryTargetsEnvValue(
          value: $checkedConvert('value', (v) => v as String),
          native: $checkedConvert('native', (v) => v as bool),
          formEnvVar: $checkedConvert('formEnvVar', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$BinaryTargetsEnvValueToJson(
    BinaryTargetsEnvValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('formEnvVar', instance.formEnvVar);
  val['native'] = instance.native;
  val['value'] = instance.value;
  return val;
}

GeneratorConfig _$GeneratorConfigFromJson(Map json) => $checkedCreate(
      'GeneratorConfig',
      json,
      ($checkedConvert) {
        final val = GeneratorConfig(
          name: $checkedConvert('name', (v) => v as String),
          provider:
              $checkedConvert('provider', (v) => EnvValue.fromJson(v as Map)),
          config: $checkedConvert('config', (v) => v as Map),
          binaryTargets: $checkedConvert(
              'binaryTargets',
              (v) => (v as List<dynamic>)
                  .map((e) => BinaryTargetsEnvValue.fromJson(e as Map))),
          previewFeatures: $checkedConvert('previewFeatures',
              (v) => (v as List<dynamic>).map((e) => e as String)),
          output: $checkedConvert(
              'output', (v) => v == null ? null : EnvValue.fromJson(v as Map)),
        );
        return val;
      },
    );

Map<String, dynamic> _$GeneratorConfigToJson(GeneratorConfig instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'provider': instance.provider.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('output', instance.output?.toJson());
  val['config'] = instance.config;
  val['binaryTargets'] = instance.binaryTargets.map((e) => e.toJson()).toList();
  val['previewFeatures'] = instance.previewFeatures.toList();
  return val;
}

DenyLists _$DenyListsFromJson(Map json) => $checkedCreate(
      'DenyLists',
      json,
      ($checkedConvert) {
        final val = DenyLists(
          models: $checkedConvert(
              'models', (v) => (v as List<dynamic>?)?.map((e) => e as String)),
          fields: $checkedConvert(
              'fields', (v) => (v as List<dynamic>?)?.map((e) => e as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$DenyListsToJson(DenyLists instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('models', instance.models?.toList());
  writeNotNull('fields', instance.fields?.toList());
  return val;
}

GeneratorManifest _$GeneratorManifestFromJson(Map json) => $checkedCreate(
      'GeneratorManifest',
      json,
      ($checkedConvert) {
        final val = GeneratorManifest(
          prettyName: $checkedConvert('prettyName', (v) => v as String?),
          defaultOutput: $checkedConvert('defaultOutput', (v) => v as String?),
          denylists: $checkedConvert('denylists',
              (v) => v == null ? null : DenyLists.fromJson(v as Map)),
          requiresGenerators: $checkedConvert('requiresGenerators',
              (v) => (v as List<dynamic>?)?.map((e) => e as String)),
          version: $checkedConvert('version', (v) => v as String?),
          requiresEngineVersion:
              $checkedConvert('requiresEngineVersion', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$GeneratorManifestToJson(GeneratorManifest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('prettyName', instance.prettyName);
  writeNotNull('defaultOutput', instance.defaultOutput);
  writeNotNull('denylists', instance.denylists?.toJson());
  writeNotNull('requiresGenerators', instance.requiresGenerators?.toList());
  writeNotNull('version', instance.version);
  writeNotNull('requiresEngineVersion', instance.requiresEngineVersion);
  return val;
}

DataSource _$DataSourceFromJson(Map json) => $checkedCreate(
      'DataSource',
      json,
      ($checkedConvert) {
        final val = DataSource(
          name: $checkedConvert('name', (v) => v as String),
          provider: $checkedConvert(
              'provider', (v) => $enumDecode(_$ConnectorTypeEnumMap, v)),
          activeProvider: $checkedConvert(
              'activeProvider', (v) => $enumDecode(_$ConnectorTypeEnumMap, v)),
          url: $checkedConvert('url', (v) => EnvValue.fromJson(v as Map)),
          directUrl: $checkedConvert('directUrl',
              (v) => v == null ? null : EnvValue.fromJson(v as Map)),
          schemas: $checkedConvert(
              'schemas', (v) => (v as List<dynamic>).map((e) => e as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$DataSourceToJson(DataSource instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'provider': _$ConnectorTypeEnumMap[instance.provider]!,
    'activeProvider': _$ConnectorTypeEnumMap[instance.activeProvider]!,
    'url': instance.url.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('directUrl', instance.directUrl?.toJson());
  val['schemas'] = instance.schemas.toList();
  return val;
}

const _$ConnectorTypeEnumMap = {
  ConnectorType.mysql: 'mysql',
  ConnectorType.mongodb: 'mongodb',
  ConnectorType.sqlite: 'sqlite',
  ConnectorType.postgresql: 'postgresql',
  ConnectorType.sqlserver: 'sqlserver',
  ConnectorType.cockroachdb: 'cockroachdb',
};

GeneratorOptions _$GeneratorOptionsFromJson(Map json) => $checkedCreate(
      'GeneratorOptions',
      json,
      ($checkedConvert) {
        final val = GeneratorOptions(
          generator: $checkedConvert(
              'generator', (v) => GeneratorConfig.fromJson(v as Map)),
          schemaPath: $checkedConvert('schemaPath', (v) => v as String),
          datamodel: $checkedConvert('datamodel', (v) => v as String),
          datasources: $checkedConvert(
              'datasources',
              (v) => (v as List<dynamic>)
                  .map((e) => DataSource.fromJson(e as Map))),
          version: $checkedConvert('version', (v) => v as String),
          dmmf: $checkedConvert('dmmf',
              (v) => Document.fromJson(Map<String, dynamic>.from(v as Map))),
        );
        return val;
      },
    );

Map<String, dynamic> _$GeneratorOptionsToJson(GeneratorOptions instance) =>
    <String, dynamic>{
      'generator': instance.generator.toJson(),
      'schemaPath': instance.schemaPath,
      'datamodel': instance.datamodel,
      'datasources': instance.datasources.map((e) => e.toJson()).toList(),
      'version': instance.version,
      'dmmf': instance.dmmf.toJson(),
    };
