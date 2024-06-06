import 'package:path/path.dart' as path;
import 'package:rc/loaders/dotenv.dart';

final loader = DotenvLoader(
  files: ['.env', path.join('prisma', '.env')],
  includeSystemEnvironment: true,
  skipMultipleLocations: true,
  searchProjectDirectory: true,
);
