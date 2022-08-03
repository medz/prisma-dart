/// Prisma supported data source providers.
enum DataSourceProvider {
  postgresql,
  mysql,
  sqlite,
  sqlserver,
  mongodb,
  cockroachdb,
  ;

  /// Lookup a provider from a enum name.
  static DataSourceProvider lookup(String? name) {
    for (final provider in values) {
      if (provider.name == name) {
        return provider;
      }
    }
    return DataSourceProvider.postgresql;
  }

  /// Get default url for this provider.
  String get defaultUrl {
    switch (this) {
      case DataSourceProvider.postgresql:
        return 'postgres://postgres:postgres@localhost:5432/postgres';
      case DataSourceProvider.mysql:
        return 'mysql://root:root@localhost:3306/mysql';
      case DataSourceProvider.sqlite:
        return 'file://./prisma/prisma.db';
      case DataSourceProvider.sqlserver:
        return 'sqlserver://sa:sa@localhost:1433/sqlserver';
      case DataSourceProvider.mongodb:
        return 'mongodb://localhost:27017/mongodb';
      case DataSourceProvider.cockroachdb:
        return 'cockroachdb://localhost:26257/cockroachdb';
    }
  }
}
