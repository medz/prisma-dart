import 'load_project_config.dart';

class PrismaConfig {
  static PrismaConfig get find => PrismaConfig._(loadPrismaConfig());

  final Map _document;
  const PrismaConfig._(this._document);

  dynamic call(String key) => _document[key.toLowerCase()];
}
