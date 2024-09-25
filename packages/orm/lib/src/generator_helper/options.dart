import '../dmmf/dmmf.dart';
import 'config.dart';
import 'env_value.dart';

typedef _Source = Map<String, dynamic>;

/// Represents a column in an SQL query
extension type SqlQueryColumn(_Source _) implements _Source {
  /// The name of the column
  String get name => _['name'];

  /// The data type of the column
  String get typ => _['typ'];

  /// Indicates whether the column can contain null values
  bool get nullable => _['nullable'];
}

/// Represents a parameter in an SQL query
extension type SqlQueryParam(SqlQueryColumn _) implements _Source {
  /// Optional documentation for the parameter
  String? get documentation => _['documentation'];
}

/// Represents an SQL query
extension type SqlQuery(_Source _) implements _Source {
  /// The name of the query
  String get name => _['name'];

  /// The source code of the query
  String get source => _['source'];

  /// Optional documentation for the query
  String? get documentation => _['documentation'];

  /// The list of parameters for the query
  Iterable<SqlQueryParam> get parameters =>
      (_['parameters'] as Iterable).cast();

  /// The list of result columns for the query
  Iterable<SqlQueryColumn> get resultColumns =>
      (_['resultColumns'] as Iterable).cast();
}

class GeneratorOptions {
  final GeneratorConfig generator;
  final Iterable<GeneratorConfig> otherGenerators;
  final String schemaPath;
  final String schema;
  final DMMF dmmf;
  final Iterable<Datasource> datasources;
  final String version;
  final BinaryPaths binaryPaths;
  final bool postinstall;
  final bool noEngine;
  final Iterable<SqlQuery>? typedSql;

  const GeneratorOptions({
    required this.generator,
    required this.otherGenerators,
    required this.schemaPath,
    required this.schema,
    required this.dmmf,
    required this.datasources,
    required this.version,
    required this.binaryPaths,
    this.typedSql,
    this.postinstall = false,
    this.noEngine = false,
  });

  factory GeneratorOptions.fromJson(Map json) {
    return GeneratorOptions(
      generator: GeneratorConfig.fromJson(json['generator']),
      otherGenerators: (json['otherGenerators'] as Iterable)
          .map((e) => GeneratorConfig.fromJson(e)),
      schemaPath: json['schemaPath'],
      schema: json['schema'] ?? json['datamodel'],
      dmmf: DMMF.fromJson(json['dmmf']),
      datasources:
          (json['datasources'] as Iterable).map((e) => Datasource.fromJson(e)),
      version: json['version'],
      binaryPaths: BinaryPaths.fromJson(json['binaryPaths'] ?? const {}),
      postinstall: json['postinstall'] ?? false,
      noEngine: json['noEngine'] ?? false,
      typedSql: (json['typedSql'] as Iterable?)?.cast(),
    );
  }
}

class Datasource {
  final String name;
  final ConnectorType provider;
  final ConnectorType activeProvider;
  final Env url;
  final Env? directUrl;
  final Iterable<String> schemas;

  const Datasource({
    required this.name,
    required this.provider,
    required this.activeProvider,
    required this.url,
    this.directUrl,
    required this.schemas,
  });

  factory Datasource.fromJson(Map json) {
    return Datasource(
      name: json['name'],
      provider: ConnectorType.of(json['provider']),
      activeProvider: ConnectorType.of(json['activeProvider']),
      url: Env.fromJson(json['url']),
      directUrl:
          json['directUrl'] != null ? Env.fromJson(json['directUrl']) : null,
      schemas: (json['schemas'] as Iterable).cast(),
    );
  }
}

enum ConnectorType {
  mysql,
  mongodb,
  sqlite,
  postgresql, // postgres | postgresql
  sqlserver, // sqlserver | jdbc:sqlserver
  cockroachdb;

  static ConnectorType of(String name) {
    return switch (name) {
      'mysql' => ConnectorType.mysql,
      'mongodb' => ConnectorType.mongodb,
      'sqlite' => ConnectorType.sqlite,
      'postgresql' || 'postgres' => ConnectorType.postgresql,
      'sqlserver' || 'jdbc:sqlserver' => ConnectorType.sqlserver,
      'cockroachdb' => ConnectorType.cockroachdb,
      _ => throw ArgumentError.value(name, 'name',
          'Invalid connector type, must be one of: ${ConnectorType.values.join(', ')}.'),
    };
  }
}

class BinaryPaths {
  final Map<String, String>? schemaEngine;
  final Map<String, String>? queryEngine;
  final Map<String, String>? libqueryEngine;

  const BinaryPaths({
    this.schemaEngine,
    this.queryEngine,
    this.libqueryEngine,
  });

  factory BinaryPaths.fromJson(Map json) {
    return BinaryPaths(
      schemaEngine: (json['schemaEngine'] as Map?)?.cast(),
      queryEngine: (json['queryEngine'] as Map?)?.cast(),
      libqueryEngine: (json['libqueryEngine'] as Map?)?.cast(),
    );
  }
}
