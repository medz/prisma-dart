import 'data_source_provider.dart';

class DataSourceUrl {
  const DataSourceUrl._(this.provider, this.url);

  final String url;
  final DataSourceProvider provider;

  factory DataSourceUrl.lookup(String url) {
    for (final provider in DataSourceProvider.values) {
      if (url.substring(0, provider.name.length).toLowerCase() ==
          provider.name.toLowerCase()) {
        return DataSourceUrl._(provider, url);
      }
    }

    throw Exception('Unsupported data source url: $url');
  }
}
