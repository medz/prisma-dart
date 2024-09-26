enum DatasourceType { url, environment }

class Datasource {
  final DatasourceType type;
  final String value;

  const Datasource(this.type, this.value);
}

typedef Datasources = Map<String, Datasource>;
