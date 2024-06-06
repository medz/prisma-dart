enum DatasourceType { url, enviroment }

class Datasource {
  final DatasourceType type;
  final String value;

  const Datasource(this.type, this.value);
}

typedef Datasources = Map<String, Datasource>;
