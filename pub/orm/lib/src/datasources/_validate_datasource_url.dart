import '../errors.dart';

const _allowdProtocels = <String>[
  'file',
  'mysql',
  'postgresql',
  'mongodb',
  'sqlserver',
  'prisma'
];

PrismaClientInitializationError _createInvalidDatasourceError(String message) =>
    PrismaClientInitializationError(errorCode: 'P1013', message: message);

String validateDatasourceURL(String datasourceUrl) {
  final url = Uri.tryParse(datasourceUrl);

  if (url?.scheme == 'file') {
    throw _createInvalidDatasourceError(
        "The current platform does not support SQLite, please change the datasource URL");
  }

  if (url == null || !_allowdProtocels.contains(url.scheme)) {
    throw _createInvalidDatasourceError("Invalid Prisma datasource URL");
  }

  return url.toString();
}
