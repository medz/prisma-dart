import '../src/json_convertible.dart';

class GeneratorManifest implements JsonConvertible<Map<String, dynamic>> {
  final String? prettyName;
  final String? defaultOutput;
  final String? version;
  final GeneratorManifestDenyList? denylists;
  final Iterable<String>? requiresGenerators;
  final Iterable<EngineType>? requiresEngines;
  final String? requiresEngineVersion;

  const GeneratorManifest({
    this.prettyName,
    this.defaultOutput,
    this.denylists,
    this.requiresGenerators,
    this.requiresEngines,
    this.requiresEngineVersion,
    this.version,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (prettyName != null) 'prettyName': prettyName,
      if (defaultOutput != null) 'defaultOutput': defaultOutput,
      if (denylists != null) 'denylists': denylists?.toJson(),
      if (requiresGenerators != null) 'requiresGenerators': requiresGenerators,
      if (requiresEngines != null) 'requiresEngines': requiresEngines,
      if (requiresEngineVersion != null)
        'requiresEngineVersion': requiresEngineVersion,
      if (version != null) 'version': version,
    };
  }
}

class GeneratorManifestDenyList
    implements JsonConvertible<Map<String, dynamic>> {
  final Iterable<String>? models;
  final Iterable<String>? fields;

  const GeneratorManifestDenyList({this.models, this.fields});

  factory GeneratorManifestDenyList.fromJson(Map<String, dynamic> json) {
    return GeneratorManifestDenyList(
      models: json['models']?.cast<String>(),
      fields: json['fields']?.cast<String>(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (models != null) 'models': models,
      if (fields != null) 'fields': fields,
    };
  }
}

enum EngineType implements JsonConvertible<String> {
  queryEngine,
  libqueryEngine,
  schemaEngine;

  @override
  String toJson() => name;
}
