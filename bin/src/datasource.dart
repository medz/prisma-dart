/// Datasource provider.
enum DatasourceProvider {
  postgresql,
  mysql,
  sqlite,
  sqlserver,
  mongodb,
  cockroachdb,
  ;

  /// Lookup a provider from a enum name.
  static DatasourceProvider lookup(String name) {
    if (name.toLowerCase() == 'file') {
      return sqlite;
    }

    return values.firstWhere(
      (element) => element.name.toLowerCase() == name.toLowerCase(),
      orElse: () => postgresql,
    );
  }
}
