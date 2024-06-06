import 'dart:io';

import 'package:path/path.dart' as path;

import '../errors.dart';
import '_validate_datasource_url.dart' as shared;

String validateDatasourceURL(String datasourceUrl, {bool isPorxy = false}) {
  final url = Uri.tryParse(datasourceUrl);
  if (url?.scheme != 'file' || url == null) {
    return shared.validateDatasourceURL(datasourceUrl, isPorxy: isPorxy);
  }

  final databaseFile = File.fromUri(url);
  final databasePath = path.relative(databaseFile.path);
  if (databaseFile.existsSync()) {
    return 'file:$databasePath';
  }

  throw PrismaClientInitializationError(
      errorCode: "P1003",
      message: "The SQLite database file ($databasePath) does not exist");
}
