import '../errors.dart';

const _allowdProtocels = <String>[
  'mysql',
  'postgresql',
  'mongodb',
  'sqlserver'
];

PrismaClientInitializationError _createInvalidDatasourceError(String message) =>
    PrismaClientInitializationError(errorCode: 'P1013', message: message);

String validateDatasourceURL(String datasourceUrl, {bool isProxy = false}) {
  final url = Uri.tryParse(datasourceUrl);

  if (isProxy && url?.scheme == 'prisma') {
    return url.toString();
  } else if (isProxy) {
    throw _createInvalidDatasourceError(
        "Proxy connection URL must use the `prisma://` protocol");
  }

  if (url?.scheme == 'file') {
    throw _createInvalidDatasourceError(
        "The current platform does not support SQLite, please change the datasource URL");
  }

  if (url == null || !_allowdProtocels.contains(url.scheme)) {
    throw _createInvalidDatasourceError("Invalid Prisma datasource URL");
  }

  return url.toString();
}
