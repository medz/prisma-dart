import 'dart:io';

import 'package:path/path.dart' as path;

import '../_internal/project_directory.dart';
import '../errors.dart';
import '_validate_datasource_url.dart' as shared;

String validateDatasourceURL(String datasourceUrl, {bool isPorxy = false}) {
  final url = Uri.tryParse(datasourceUrl);
  if (url?.scheme != 'file' || url == null) {
    return shared.validateDatasourceURL(datasourceUrl, isPorxy: isPorxy);
  }

  final pwd = findProjectDirectory()?.path ?? Directory.current.path;
  final databasePath =
      path.relative(path.join(pwd, datasourceUrl.substring(5)));
  if (File(databasePath).existsSync()) {
    return 'file:$databasePath';
  }

  throw PrismaClientInitializationError(
      errorCode: "P1003",
      message: "The SQLite database file ($databasePath) does not exist");
}
